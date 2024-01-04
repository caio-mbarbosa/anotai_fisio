import 'dart:async';

import 'package:anotai_fisio/models/pacient.dart';
import 'package:anotai_fisio/models/prontuario.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:audio_wave/audio_wave.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dart_numerics/dart_numerics.dart' as numerics;

import 'package:anotai_fisio/audio_player.dart';
import 'transcribe.dart';
import 'views/pacients_choose.dart';
import 'templates_choose.dart';
import 'views/pacients.dart';
import 'views/customize.dart';

class AudioRecorder extends StatefulWidget {
  final void Function(String path, Modelo modelo, Pacient paciente) onStop;

  const AudioRecorder({Key? key, required this.onStop}) : super(key: key);

  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  int _recordDuration = 0;
  Timer? _timer;
  final _audioRecorder = Record();
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;
  Modelo? modelo;

  @override
  void initState() {
    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      setState(() => _recordState = recordState);
    });

    _amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) => setState(() => _amplitude = amp));

    super.initState();
  }

  Future<Pacient?> openPacientePopUp() => showDialog<Pacient>(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Escolha o Paciente"),
          content: Pacientes(),
        ),
      );

  Future<Modelo?> openTemplatePopUp() => showDialog<Modelo>(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Escolha o template"),
          content: Templates(),
        ),
      );

  Future<void> _start() async {
    try {
      final Modelo? template;
      template = await openTemplatePopUp();
      print(template);
      if (template == null) {
        return;
      }
      setState(() => modelo = template);

      if (await _audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }

        // final devs = await _audioRecorder.listInputDevices();
        // final isRecording = await _audioRecorder.isRecording();

        await _audioRecorder.start();
        _recordDuration = 0;

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop(template) async {
    _timer?.cancel();
    _recordDuration = 0;
    final path = await _audioRecorder.stop();

    final Pacient? paciente;
    if (template != null) {
      paciente = await openPacientePopUp();
    } else {
      paciente = null;
    }
    print(paciente);

    if (path != null && template != null && paciente != null) {
      widget.onStop(path, template, paciente);
    }
  }

  Future<void> _pause() async {
    _timer?.cancel();
    await _audioRecorder.pause();
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();
  }

  @override
  Widget build(BuildContext context) {
    double fem = .9;
    double ffem = .8;
    double rowGap = 1;
    String user = 'fisio';
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_recordState == RecordState.stop) ...[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
                width: 100 * fem,
                height: 100 * fem,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 48 * fem,
                          height: 48 * fem,
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: const ShapeDecoration(
                              shape: CircleBorder(eccentricity: 1),
                              color: Colors.white),
                          child: IconButton.filled(
                              icon: const Icon(Icons.person),
                              color: const Color(0xff552a7f),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const PacientsList()),
                                );
                              })),
                      Text(
                        "Pacientes",
                        style: GoogleFonts.roboto(
                          fontSize: 12 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2 * ffem / fem,
                          letterSpacing: 0.5 * fem,
                          color: const Color(0xffffffff),
                        ),
                      )
                    ])),
            Text(
              'Olá, $user 👋',
              style: GoogleFonts.roboto(
                fontSize: 24 * ffem,
                fontWeight: FontWeight.w400,
                height: 1.2 * ffem / fem,
                letterSpacing: 0.5 * fem,
                color: const Color(0xffffffff),
              ),
            ),
            SizedBox(
                width: 100 * fem,
                height: 100 * fem,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 48 * fem,
                          height: 48 * fem,
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: const ShapeDecoration(
                              shape: CircleBorder(eccentricity: 1),
                              color: Colors.white),
                          child: IconButton.filled(
                              icon: const Icon(Icons.file_open_outlined),
                              color: const Color(0xff552a7f),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CustomizeView()),
                                );
                              })),
                      Text(
                        "Template",
                        style: GoogleFonts.roboto(
                          fontSize: 12 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2 * ffem / fem,
                          letterSpacing: 0.5 * fem,
                          color: const Color(0xffffffff),
                        ),
                      )
                    ]))
          ]),
          SizedBox(height: rowGap),
          SizedBox(height: rowGap),
          _buildStartControl(),
          const Text("Clique para gravar"),
          SizedBox(height: rowGap),
          SizedBox(height: rowGap),
          SizedBox(height: rowGap)
        ],
        if (_recordState != RecordState.stop) ...[
          SizedBox(height: rowGap),
          SizedBox(height: rowGap),
          SizedBox(height: rowGap),
          SizedBox(height: rowGap),
          IconButton(
              onPressed: () {
                _stop(null);
              },
              icon: const Icon(Icons.close, color: Color(0xFF000000))),
          _buildTimer(),
          _buildStartControl(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(height: rowGap),
            _buildPauseResumeControl(),
            SizedBox(height: rowGap),
            SizedBox(height: rowGap),
            _buildRecordStopControl(),
            SizedBox(height: rowGap),
          ]),
          SizedBox(height: rowGap),
          SizedBox(height: rowGap),
          SizedBox(height: rowGap),
          SizedBox(height: rowGap),
        ],
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;

    if (_recordState != RecordState.stop) {
      icon = const Icon(Icons.stop, color: Color(0xff552a7f), size: 30);
      color = const Color(0xFFFFFFFF);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            (_recordState != RecordState.stop) ? _stop(modelo) : _start();
          },
        ),
      ),
    );
  }

  Widget _buildStartControl() {
    late Widget icon;
    late Color color;

    if (_recordState != RecordState.stop) {
      double amp = 1;
      if (_amplitude != null) {
        amp = numerics.sin(_amplitude!.current);
        amp.abs();
      }
      try {
        icon = AudioWave(
          height: 32,
          width: 32,
          spacing: 2.5,
          animation: false,
          bars: [
            AudioWaveBar(heightFactor: .5 * amp, color: Colors.white),
            AudioWaveBar(heightFactor: .8 * amp, color: Colors.white),
            AudioWaveBar(heightFactor: amp, color: Colors.white),
            AudioWaveBar(heightFactor: .8 * amp, color: Colors.white),
            AudioWaveBar(heightFactor: .5 * amp, color: Colors.white),
          ],
        );
      } catch (exeption) {
        icon = AudioWave(
          height: 32,
          width: 32,
          spacing: 2.5,
          animation: false,
          bars: [
            AudioWaveBar(heightFactor: .5 * 1, color: Colors.white),
            AudioWaveBar(heightFactor: .8 * 1, color: Colors.white),
            AudioWaveBar(heightFactor: 1, color: Colors.white),
            AudioWaveBar(heightFactor: .8 * 1, color: Colors.white),
            AudioWaveBar(heightFactor: .5 * 1, color: Colors.white),
          ],
        );
      }
      color = const Color(0xff552a7f);
    } else {
      icon = const Icon(Icons.mic, color: Color(0xFFFFFFFF), size: 45);
      color = const Color(0xff552a7f);
    }

    return AvatarGlow(
        endRadius: 100.0,
        child: Material(
          // Replace this child with your own
          elevation: 8.0,
          shape: const CircleBorder(),
          child: CircleAvatar(
            backgroundColor: color,
            radius: 60.0,
            child: InkWell(
              child: SizedBox(child: icon),
              onTap: () {
                (_recordState != RecordState.stop) ? _stop(modelo) : _start();
              },
            ),
          ),
        ));
  }

  Widget _buildPauseResumeControl() {
    if (_recordState == RecordState.stop) {
      return const SizedBox.shrink();
    }

    late Icon icon;
    late Color color;

    if (_recordState == RecordState.record) {
      icon = const Icon(Icons.pause, color: Color(0xff552a7f), size: 30);
      color = const Color(0xFFFFFFFF);
    } else {
      icon = const Icon(Icons.play_arrow, color: Color(0xff552a7f), size: 30);
      color = const Color(0xFFFFFFFF);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            (_recordState == RecordState.pause) ? _resume() : _pause();
          },
        ),
      ),
    );
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Color(0xFF000000), fontSize: 20),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }
}

class Recording extends StatefulWidget {
  const Recording({Key? key}) : super(key: key);

  @override
  State<Recording> createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  bool showPlayer = false;
  String? audioPath;
  Modelo? modelo;
  Pacient? pacient;

  _RecordingState();

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  Future<Pacient?> openPacientePopUp() => showDialog<Pacient>(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Escolha o Paciente"),
          content: Pacientes(),
        ),
      );

  Future<Modelo?> openTemplatePopUp() => showDialog<Modelo>(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Escolha o template"),
          content: Templates(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    double fem = .9;
    double screenPadding = 20;
    double rowGap = 2;
    return MaterialApp(
      home: Scaffold(
        appBar: showPlayer
            ? AppBar(
                centerTitle: true,
                title: const Text('Conferir informações'),
                //titleTextStyle: TextStyle(color: Colors.black),
                backgroundColor: const Color(0xff552a7f),
              )
            : null,
        body: Container(
          padding: EdgeInsets.fromLTRB(screenPadding * fem, screenPadding * fem,
              screenPadding * fem, screenPadding * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            color: showPlayer ? Colors.white : const Color(0xFF9175AC),
          ),
          child: showPlayer
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(5),
                              shape: BoxShape.rectangle,
                            ),
                            child: InkWell(
                              child: Text(
                                pacient!.name,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              onTap: () async {
                                Pacient? paciente = await openPacientePopUp();
                                if (paciente != null) {
                                  setState(() {
                                    pacient = paciente;
                                  });
                                }
                              },
                            ),
                          ),
                          Positioned(
                            left: 30,
                            top: 12,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 10, right: 10),
                              color: Colors.white,
                              child: const Text(
                                'Paciente',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(5),
                              shape: BoxShape.rectangle,
                            ),
                            child: InkWell(
                              child: Text(modelo!.nome,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18)),
                              onTap: () async {
                                Modelo? template = await openTemplatePopUp();
                                if (template != null) {
                                  setState(() {
                                    modelo = template;
                                  });
                                }
                              },
                            ),
                          ),
                          Positioned(
                            left: 30,
                            top: 12,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 10, right: 10),
                              color: Colors.white,
                              child: const Text(
                                'Template',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: rowGap),
                      SizedBox(height: rowGap),
                      SizedBox(height: rowGap),
                      SizedBox(height: rowGap),
                      AudioPlayer(
                        source: audioPath!,
                        onDelete: () {
                          setState(() => showPlayer = false);
                        },
                      ),
                      SizedBox(height: rowGap),
                      SizedBox(height: rowGap),
                      SizedBox(height: rowGap),
                      SizedBox(height: rowGap),
                      Transcribe(
                          audioPath: audioPath!,
                          campos: modelo!.campos,
                          pacient: pacient!),
                      SizedBox(height: rowGap),
                      SizedBox(height: rowGap),
                      SizedBox(height: rowGap),
                      SizedBox(height: rowGap),
                    ])
              : AudioRecorder(
                  onStop: (path, template, paciente) {
                    if (kDebugMode) print('Recorded file path: $path');
                    print(modelo);
                    print(pacient);
                    setState(() {
                      audioPath = path;
                      modelo = template;
                      pacient = paciente;
                      showPlayer = true;
                    });
                  },
                ),
        ),
      ),
    );
  }
}
