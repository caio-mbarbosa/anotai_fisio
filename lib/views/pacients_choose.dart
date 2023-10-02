import 'package:anotai_fisio/models/pacient.dart';
import 'package:anotai_fisio/provider/pacients_provider.dart';
import 'package:anotai_fisio/views/pacient_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pacientes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pacients pacients = Provider.of(context);

    return FractionallySizedBox(
        heightFactor: .4,
        child: Scaffold(
          backgroundColor: Colors.white,
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
            backgroundColor: Color(0xff552a7f),
          ),
        ));
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
      backgroundColor: Color(0xff552a7f),
    );
    return Card(
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop(pacient);
          },
          child: ListTile(
            leading: avatar,
            title: Text(pacient.name),
          ),
        ));
  }
}
