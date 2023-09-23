import 'package:anotai_fisio/models/pacient.dart';
import 'package:anotai_fisio/provider/pacients_provider.dart';
import 'package:anotai_fisio/views/pacient_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pacientes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pacients pacients = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione o paciente'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: pacients.count,
        itemBuilder: (ctx, i) => PacientTile(pacients.byIndex(i)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PacientForm(id: '')),
          );
        },
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}

class PacientTile extends StatelessWidget {
  final Pacient pacient;

  const PacientTile(this.pacient);

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      child: Icon(
        Icons.person,
        color: Colors.white70,
      ),
      backgroundColor: Colors.deepPurple,
    );
    return InkWell(
      onTap: () {
        Navigator.of(context).pop(pacient);
      },
      child: ListTile(
        leading: avatar,
        title: Text(pacient.name),
      ),
    );
  }
}
