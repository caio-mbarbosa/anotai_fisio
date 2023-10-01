import 'dart:math';
import 'package:anotai_fisio/data/dummy_pacients.dart';
import 'package:anotai_fisio/models/pacient.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

Future<Map<String, Pacient>> loadAndIterateJSON() async{
  try {
    File arquivoAtual = await get_localFile();
    //final file = File("assets/dummy_pacients.json"); // Substitua pelo caminho do seu arquivo JSON
    final jsonString = await arquivoAtual.readAsString();
    print("Json as string!");
    print(jsonString);
    final jsonMap = jsonDecode(jsonString);
    Map<String, Pacient> jsonFinal = {};
    // Itere pelas chaves do mapa
    jsonMap.keys.forEach((key) {
      jsonFinal[key] = Pacient(id: jsonMap[key]["id"], name: jsonMap[key]["name"], age: jsonMap[key]["age"],
          sex: jsonMap[key]["sex"], link_sheets: jsonMap[key]["link_sheets"], hasInserted: jsonMap[key]["hasInserted"]);
    });
    return jsonFinal;
  } catch (e) {
    print("Erro ao carregar o arquivo JSON: $e");
    final Directory directory = await getApplicationDocumentsDirectory();
    String pathFinal = directory.path;
    File arquivo = File('$pathFinal/dummy_pacients.json');
    arquivo.writeAsString(jsonEncode({}));
    print("tive que criar arquivo!");
    return {};
  }
}

Future<File> get_localFile() async {
  final Directory directory = await getApplicationDocumentsDirectory();
  String pathFinal = directory.path;
  var arquivo = File('$pathFinal/dummy_pacients.json');
  return arquivo;
}

class Pacients with ChangeNotifier{
  //final Map<String, Pacient> _items = {...DUMMY_PACIENTS};
  Map<String, Pacient> _items = {};

  Pacients() {
    loadAndIterateJSON().then((result) {
      _items = result;
      print("Variavel items");
      print(_items);
      notifyListeners();
    });
  }

  List<Pacient> get all{
    return [..._items.values];
  }

  int get count{
    return _items.length;
  }

  Pacient byIndex(int i){
    return _items.values.elementAt(i);
  }

  void put(Pacient pacient) async{

    if ( pacient.id != '' && _items.containsKey(pacient.id)){
      _items.update(pacient.id, (_) => Pacient(
          id: pacient.id,
          name: pacient.name,
          age: pacient.age,
          sex: pacient.sex,
          link_sheets: pacient.link_sheets,
          hasInserted: false
      ));
    } else {
      // adicionar
      print('vou add');
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(id, () => Pacient(
          id: id,
          name: pacient.name,
          age: pacient.age,
          sex: pacient.sex,
          link_sheets: pacient.link_sheets,
          hasInserted: false
      ));
    }
    //escrever o arquivo json denovo
    Map<String, dynamic> jsonMap = {};
    _items.forEach((key, value) {
      jsonMap[key] = value.toJson(); // Usando o método toJson da classe Pacient
    });
    final updatedJsonString = json.encode(jsonMap);
    File arquivoAtual = await get_localFile();
    arquivoAtual.writeAsString(updatedJsonString);
    print(await arquivoAtual.readAsString());
    print("terminei de salvar");
    //criar o arquivo antes


    notifyListeners();
  }

  void remove(Pacient pacient){
    if (pacient.id != ''){
      _items.remove(pacient.id);
      notifyListeners();
    }
  }

  Pacient? byId(String id){
    if (_items.containsKey(id)){
      return _items[id];
    }
    return null;
  }
}