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
      _TranscribeState(campos: campos, pacient: pacient, mensagemCode: 'A planilha trollou');
}

class _TranscribeState extends State<Transcribe> {
  bool _isLoading = false;
  String? text;
  final Pacient pacient;
  final List<String> campos;
  String mensagemCode;

  _TranscribeState({required this.campos, required this.pacient, required this.mensagemCode});

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

  Future<int> main_service(String texto) async {
    int error = 0;
    print("comecando gpt...");
    final gsheets = GSheets(credentials);
    //final ss = await gsheets.spreadsheet(spreadsheetId);
    var sheet = null;
    try{
      final ss = await gsheets.spreadsheet(this.pacient.link_sheets);
      sheet = ss.worksheetByTitle('Teste');
    }
    on Exception catch(_){
      error = 1;
      return error;
    }
    var camposAntigos = await sheet?.values.row(1);
    final campos = this.campos;
    var camposNovo;
    if (camposAntigos != null){
      camposNovo = List.from(camposAntigos)..addAll(campos);
      camposNovo = List.from(['Id','Data'])..addAll(camposNovo);
      camposNovo = camposNovo.toSet().toList();
    }
    else{
      camposNovo = List.from(['Id','Data'])..addAll(campos);
    }
    await sheet?.values.insertRow(1, camposNovo);

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
    if (chatCompletion == null || chatCompletion.choices.isEmpty) {
      error = 2;
      return error;
    }
    DateTime data = DateTime.now();
    String newData = data.toString();
    newData = newData.substring(0, 19);
    var resultadoGpt = json.decode(chatCompletion.choices.first.message.content);
    // Inserir na planilha:
    print(resultadoGpt);
    var colunaIds = await sheet?.values.columnByKey('Id');
    int novoId = colunaIds.length +1;
    print(colunaIds);
    print(novoId);
    Map<String, dynamic> novoMapa = {
      "Id": novoId,
      "Data": newData, // Substitua pela sua data real
      ...resultadoGpt, // Isso copiará todos os campos de resultadoGpt para o novo mapa
    };
    print(novoMapa);
    print(newData);
    // convertendo para numerico ao verificar existencia da data

    if(novoMapa != null){
      await sheet?.values.map.appendRow(novoMapa);
    }
    List<String>? colunaDeIds = await sheet?.values.columnByKey('Id');
    List<int> listaDeInteiros = [];
    print(colunaDeIds);
    if (colunaDeIds != null){
      listaDeInteiros = colunaDeIds.map((string) => int.parse(string)).toList();
    }
    // Verifica se a data está presente na coluna de datas.
    print(listaDeInteiros);
    if (listaDeInteiros != []){
      if (listaDeInteiros.contains(novoId) != true) {
        error = 3;
        return error;
      }
    }
    print('Dados inseridos com sucesso na planilha.');
    return error;
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
            _isLoading = true;
            print(widget.audioPath);

            if (widget.audioPath != null) {
              // Chame a API de transcrição do OpenAI
              convertSpeechToText(widget.audioPath!).then((value) {
                setState(() {
                  text = value;
                  print(text);
                  if (text != null) {
                    // 0 - não erros
                    // 1 - erro achando planilha
                    // 2 - erro gpt
                    // 3 - erro inserir planilha
                    Future<int> mensagem = main_service(text!);
                    mensagem.then((result) {
                      if (result == 1) {
                        // Handle error finding spreadsheet
                        mensagemCode =
                        'Houve um erro ao acessar a planilha, verifique o link no perfil';
                        print('código 1 de retorno');
                      } else if (result == 2) {
                        // Handle error with GPT
                        mensagemCode =
                        'Houve um erro ao processar os dados, tente novamente';
                        print('código 2 de retorno');
                      } else if (result == 3) {
                        // Handle error inserting spreadsheet
                        mensagemCode =
                        'Houve um erro ao inserir os dados, tente novamente';
                        print('código 3 de retorno');
                      } else if (result == 0) {
                        // No error
                        mensagemCode =
                        'A planilha preenchida pode ser acessada';
                        print('código 0 de retorno');
                      }
                      // Agora que você atualizou a mensagemCode, navegue para a próxima tela aqui
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => End(
                            pacient_link_sheets: widget.pacient.link_sheets,
                            mensagemCode: mensagemCode,
                          ),
                        ),
                      );
                    });
                  }
                });
              });
            }
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Color(0xff552a7f),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100 * fem),
            ),
          ),
          child: Stack( // Use um Stack para sobrepor o botão e o CircularProgressIndicator
            alignment: Alignment.center,
            children: [
              Visibility(visible: !_isLoading,
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
              )),
              Visibility(
                visible: _isLoading, // Controla a visibilidade do CircularProgressIndicator
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                  backgroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}