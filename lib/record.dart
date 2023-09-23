import 'dart:async';

import 'package:anotai_fisio/models/pacient.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:audio_wave/audio_wave.dart';
import 'package:dart_numerics/dart_numerics.dart' as numerics;

import 'package:anotai_fisio/audio_player.dart';
import 'transcribe.dart';

class AudioRecorder extends StatefulWidget {
  final void Function(String path) onStop;

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

  Future<void> _start() async {
    try {
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

  Future<void> _stop() async {
    _timer?.cancel();
    _recordDuration = 0;

    final path = await _audioRecorder.stop();

    if (path != null) {
      widget.onStop(path);
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
    double columnGap = 100;
    double fem = .9;
    double rowGap = 50;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_recordState != RecordState.stop) ...[
          // Ainda não consegui implementar funcionalidade
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.close, color: Color(0xFF000000))),
          _buildTimer()
        ],
        Container(
          margin: EdgeInsets.fromLTRB(
              rowGap * fem, rowGap * fem, rowGap * fem, rowGap * fem),
          child: _buildStartControl(),
        ),
        if (_recordState == RecordState.stop) ...[
          const Text("Clique para gravar")
        ],
        if (_recordState != RecordState.stop) ...[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _buildPauseResumeControl(),
            SizedBox(width: columnGap),
            _buildRecordStopControl()
          ]),
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
      color = Color(0xFFFFFFFF);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            (_recordState != RecordState.stop) ? _stop() : _start();
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
      color = Color(0xff552a7f);
    } else {
      icon = Icon(Icons.mic, color: Color(0xFFFFFFFF), size: 45);
      color = Color(0xff552a7f);
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
                (_recordState != RecordState.stop) ? null : _start();
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
      color = Color(0xFFFFFFFF);
    } else {
      icon = const Icon(Icons.play_arrow, color: Color(0xff552a7f), size: 30);
      color = Color(0xFFFFFFFF);
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
  final List<String> campos;
  final Pacient pacient;
  const Recording({Key? key, required this.campos, required this.pacient})
      : super(key: key);

  @override
  State<Recording> createState() =>
      _RecordingState(campos: campos, pacient: pacient);
}

class _RecordingState extends State<Recording> {
  bool showPlayer = false;
  String? audioPath;
  final List<String> campos;
  final Pacient pacient;

  _RecordingState({required this.campos, required this.pacient});

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double fem = .9;
    double screenPadding = 50;
    double rowGap = 2;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(
              screenPadding * fem,
              3 * screenPadding * fem,
              screenPadding * fem,
              screenPadding * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF9175AC),
          ),
          child: showPlayer
              ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: rowGap),
                SizedBox(height: rowGap),
                AudioPlayer(
                  source: audioPath!,
                  onDelete: () {
                    setState(() => showPlayer = false);
                  },
                ),
                Transcribe(
                    audioPath: audioPath!,
                    campos: campos,
                    pacient: pacient),
                SizedBox(height: rowGap),
              ])
              : AudioRecorder(
            onStop: (path) {
              if (kDebugMode) print('Recorded file path: $path');
              setState(() {
                audioPath = path;
                showPlayer = true;
              });
            },
          ),
        ),
      ),
    );
  }
}
