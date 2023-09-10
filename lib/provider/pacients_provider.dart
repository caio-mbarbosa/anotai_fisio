import 'dart:math';
import 'package:anotai_fisio/data/dummy_pacients.dart';
import 'package:anotai_fisio/models/pacient.dart';
import 'package:flutter/material.dart';

class Pacients with ChangeNotifier{
  final Map<String, Pacient> _items = {...DUMMY_PACIENTS};

  List<Pacient> get all{
    return [..._items.values];
  }

  int get count{
    return _items.length;
  }

  Pacient byIndex(String idx){
    final int i = int.parse(idx);
    return _items.values.elementAt(i);
  }

  void put(Pacient pacient){

    if ( pacient.id != '' && _items.containsKey(pacient.id)){
      _items.update(pacient.id, (_) => Pacient(
          id: pacient.id,
          name: pacient.name,
          age: pacient.age,
          sex: pacient.sex,
          occupation: pacient.occupation
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
        occupation: pacient.occupation
    ));
    }
    notifyListeners();
  }

  void remove(Pacient pacient){
    if (pacient.id != ''){
      _items.remove(pacient.id);
      notifyListeners();
    }
  }
}