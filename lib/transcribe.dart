import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'package:http/http.dart' as http;
import 'package:gsheets/gsheets.dart';
import 'package:dart_openai/dart_openai.dart';

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
    final responseData = json.decode(utf8.decode(newresponse.bodyBytes));
    return responseData['text'];
  }

  Future<void> main_service(String texto) async {
    print("comecando gpt...");
    final gsheets = GSheets(credentials);
    final ss = await gsheets.spreadsheet(spreadsheetId);
    var sheet = ss.worksheetByTitle('Teste');

    final campos = await sheet?.values.row(1);
    OpenAI.apiKey = apiSecretKey;
    final prompt = '''
    Você vai ler um relato de um fisioterapeuta após a consulta com o cliente, ajude ele a dividir 
    as informações da conversa nos campos a seguir: $campos, formate o resultado da sua análise para o 
    formato JSON com apenas as chaves inclusas nos campos previstos (podem existir campos vazios caso não sejam mencionados na conversa),
    responda APENAS com o JSON e NADA mais, esse é o texto:
    $texto
    ''';

    OpenAIChatCompletionModel chatCompletion =
    await OpenAI.instance.chat.create(model: "gpt-3.5-turbo", messages: [
      OpenAIChatCompletionChoiceMessageModel(
        content: prompt,
        role: OpenAIChatMessageRole.user,
      )
    ]);

    print(chatCompletion.choices.first.message.content);
    var resultadoGpt = json.decode(chatCompletion.choices.first.message.content);
    // Inserir na planilha:
    if(resultadoGpt != null){
      await sheet?.values.map.appendRow(resultadoGpt);
    }
    print('Dados inseridos com sucesso na planilha.');

  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          child: ElevatedButton(
            onPressed: () async {
              print("Apertou");
              print(widget.audioPath);
              //Quando tivermos uma chave funcionando podemos testar o retorno
              if (widget.audioPath != null) {
                //call openai's transcription api
                convertSpeechToText(widget.audioPath!).then((value) {
                  setState(() {
                    text = value;
                    print(text);
                    if(text != null) main_service(text!);
                  });
                });
              }
            },
            child: Text(" Submeter Áudio "),
          ));
    });
  }
}