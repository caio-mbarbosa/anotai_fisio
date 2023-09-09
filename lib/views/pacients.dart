import 'dart:ffi';

import 'package:anotai_fisio/data/dummy_pacients.dart';
import 'package:anotai_fisio/models/pacient.dart';
import 'package:flutter/material.dart';

class PacientsView extends StatelessWidget {
  final pacients = {...DUMMY_PACIENTS};
  final double fem = 1;
  final double ffem = 1.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione o paciente'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: pacients.length,
        itemBuilder: (ctx, i) => PacientTile(pacients.values.elementAt(i)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}

class PacientTile extends StatelessWidget{
  final Pacient pacient;

  const PacientTile(this.pacient);

  @override
  Widget build(BuildContext context){
    final avatar = CircleAvatar(child: Icon(Icons.person, color: Colors.white70,), backgroundColor: Colors.deepPurple,);
    return ListTile(
        leading: avatar,
        title: Text(pacient.name),
        trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(onPressed: () {}, icon: Icon(Icons.edit))
              ],
            )
        )
    );
  }
}