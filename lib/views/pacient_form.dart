import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PacientForm extends StatelessWidget{
  final String id;

  PacientForm({required this.id});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario paciente'),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Idade'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sexo'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ocupacao'),
              )
            ],
          )
        ),
      ),
    );
  }
}