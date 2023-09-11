import 'dart:async';
import 'dart:convert';

import 'package:anotai_fisio/models/pacient.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'end.dart';
import 'package:http/http.dart' as http;
import 'package:gsheets/gsheets.dart';
import 'package:dart_openai/dart_openai.dart';

class Transcribe extends StatefulWidget {
  final String? audioPath;
  final Pacient pacient;
  final List<String> campos;

  const Transcribe(
      {Key? key,
      required this.audioPath,
      required this.campos,
      required this.pacient})
      : super(key: key);

  @override
  State<Transcribe> createState() =>
      _TranscribeState(campos: campos, pacient: pacient);
}

class _TranscribeState extends State<Transcribe> {
  String? text;
  final Pacient pacient;
  final List<String> campos;

  _TranscribeState({required this.campos, required this.pacient});

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
    //final ss = await gsheets.spreadsheet(spreadsheetId);
    final ss = await gsheets.spreadsheet(this.pacient.link_sheets);
    var sheet = ss.worksheetByTitle('Teste');
    print("Debugging info:");
    print(this.pacient.name);
    print(this.campos);
    print(this.pacient.link_sheets);
    print("end");
    final campos = this.campos;
    await sheet?.values.insertRow(1, campos);
    //final campos = await sheet?.values.row(1);
    OpenAI.apiKey = apiSecretKey;
    final prompt = '''
    Você vai ler um relato de um fisioterapeuta após a consulta com o cliente, ajude ele a dividir as informações da conversa nos campos a seguir: $campos. Formate o resultado da sua análise para o formato JSON com apenas as chaves inclusas nos campos previstos (podem existir campos vazios caso não sejam mencionados na conversa), responda APENAS com o JSON e NADA mais, esse é o texto:
    
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
    var resultadoGpt =
        json.decode(chatCompletion.choices.first.message.content);
    // Inserir na planilha:
    if (resultadoGpt != null) {
      await sheet?.values.map.appendRow(resultadoGpt);
    }
    print('Dados inseridos com sucesso na planilha.');
  }

  @override
  Widget build(BuildContext context) {
    double fem = .9;
    double ffem = 1;
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          width: 200,
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
                    if (text != null) main_service(text!);
                  });
                });
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        End(pacient_link_sheets: widget.pacient.link_sheets)),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: Color(0xff552a7f),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100 * fem)),
            ),
            child: Text(
              'Submeter Áudio',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 14 * ffem,
                fontWeight: FontWeight.w500,
                height: 1.4285714286 * ffem / fem,
                letterSpacing: 0.1000000015 * fem,
                color: Color.fromRGBO(247, 242, 250, 1),
              ),
            ),
          ));
    });
  }
}
