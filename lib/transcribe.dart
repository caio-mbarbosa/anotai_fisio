import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Colocar sua chave API numa variável chamada apiSecretKey em constant.dart
import 'constant.dart';
import 'package:http/http.dart' as http;

class Transcribe extends StatefulWidget {
  final String? audioPath;

  const Transcribe({
    Key? key,
    required this.audioPath,
  }) : super(key: key);

  @override
  State<Transcribe> createState() => _TranscribeState();
}

class _TranscribeState extends State<Transcribe> {
  String? text;

  @override
  void initState() {
    super.initState();
  }

  Future<String> convertSpeechToText(String filePath) async {
    const apiKey = apiSecretKey;
    var url = Uri.https("api.openai.com", "v1/audio/transcriptions");
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(({"Authorization": "Bearer $apiKey"}));
    request.fields["model"] = 'whisper-1';
    request.fields["language"] = "pt";
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    var response = await request.send();
    var newresponse = await http.Response.fromStream(response);
    final responseData = json.decode(newresponse.body);

    return responseData['text'];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          child: ElevatedButton(
        onPressed: () async {
          print("Apertou");
          print(widget.audioPath);
          // Quando tivermos uma chave funcionando podemos testar o retorno
          // if (audioPath != null) {
          //   //call openai's transcription api
          //   convertSpeechToText(audioPath!).then((value) {
          //     setState(() {
          //       text = value;
          //     });
          //   });
          // }
        },
        child: Text(" Submeter Áudio "),
      ));
    });
  }
}
