import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gsheets/gsheets.dart';
import 'constant.dart';


Future<String?> signInWithGoogle() async {
  final signIn = GoogleSignIn();
  final GoogleSignInAccount? account = await signIn.signIn();

  if (account == null) {
    // O usuário cancelou o processo de login.
    return null;
  }

  final GoogleSignInAuthentication? googleAuth = await account.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

  final userEmail = userCredential.user?.email;
  print('E-mail da pessoa: $userEmail');

  return userEmail;
}


Future<void> getPacientes(fisioterapeuta) async {
  final gsheets = GSheets(credentials);
  final ss = await gsheets.spreadsheet(spreadsheetFisioPaci);
  var sheet = ss.worksheetByTitle('Página1'); // Substitua pelo título da sua planilha
  // Buscar todos os dados da planilha
  final allData = await sheet?.values.allColumns();

  if (allData != null) {
    // Índice das colunas
    final columnIndexFisioterapeuta = 0; // Índice da coluna Fisioterapeuta (começando em 0)
    final columnIndexPaciente = 1; // Índice da coluna Paciente (começando em 0)
    final columnIndexPlanilha = 2; // Índice da coluna Planilha (começando em 0)

    // Filtrar os dados para encontrar Pacientes/Planilhas com o Fisioterapeuta desejado
    final filteredData = allData.where((row) =>
    row.length > columnIndexFisioterapeuta &&
        row[columnIndexFisioterapeuta] == fisioterapeuta);

    // Imprimir os Pacientes/Planilhas encontrados
    filteredData.forEach((row) {
      if (row.length > columnIndexPaciente && row.length > columnIndexPlanilha) {
        final paciente = row[columnIndexPaciente];
        final planilha = row[columnIndexPlanilha];
        print('Paciente: $paciente, Planilha: $planilha');
      }
    });
  }
}

String? extractSheetIdFromUrl(String url) {
  // Verifica se a URL contém "/spreadsheets/d/"
  if (url.contains("/spreadsheets/d/")) {
    // Divide a URL em partes usando "/" como separador
    final parts = url.split("/");
    // Encontra a posição do elemento "/spreadsheets/d/" na lista de partes
    final index = parts.indexOf("spreadsheets") + 2;
    // Verifica se a posição encontrada está dentro dos limites
    if (index < parts.length) {
      // Retorna o ID da planilha
      return parts[index];
    }
  }
  // Caso a URL não corresponda ao formato esperado, retorna null
  return null;
}


Future<void> CadastraPaciente(fisioterapeuta, paciente, planilha) async {
  final gsheets = GSheets(credentials);
  final ss = await gsheets.spreadsheet(spreadsheetFisioPaci);
  var sheet = ss.worksheetByTitle('Página1');
  final sheetId = extractSheetIdFromUrl(planilha);
  // Buscar todos os dados da planilha
  await sheet?.values.map.appendRow({
    'Fisioterapeuta': fisioterapeuta,
    'Paciente': paciente,
    'Planilha': sheetId,
  });
}

Future<String?> GetPlanilhaPaciente(String fisioterapeuta, String paciente) async {
  final gsheets = GSheets(credentials);
  final ss = await gsheets.spreadsheet(spreadsheetFisioPaci);
  var sheet = ss.worksheetByTitle('Página1');
  final allData = await sheet?.values.allColumns();

  if (allData != null) {
    // Índice das colunas
    final columnIndexFisioterapeuta = 0; // Índice da coluna Fisioterapeuta (começando em 0)
    final columnIndexPaciente = 1; // Índice da coluna Paciente (começando em 0)
    final columnIndexPlanilha = 2; // Índice da coluna Planilha (começando em 0)

    // Filtrar os dados para encontrar Pacientes/Planilhas com o Fisioterapeuta desejado
    final filteredData = allData.where((row) =>
    row.length > columnIndexFisioterapeuta &&
        row.length > columnIndexPaciente &&
        row.length > columnIndexPlanilha &&
        row[columnIndexFisioterapeuta] == fisioterapeuta &&
        row[columnIndexPaciente] == paciente);

    // Verificar se foram encontrados registros
    if (filteredData.isNotEmpty) {
      final firstRow = filteredData.first;
      if (firstRow.length > columnIndexPlanilha) {
        final planilha = firstRow[columnIndexPlanilha];
        print('Planilha: $planilha');
        return planilha;
      }
    }
  }
  return null;
}

void main() {
  final texto = 'felipe@gmail.com';
  getPacientes(texto);
}