import 'package:anotai_fisio/models/pacient.dart';
import 'package:anotai_fisio/provider/pacients_provider.dart';
import 'package:anotai_fisio/views/pacient_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pacientes extends StatelessWidget {
  const Pacientes({super.key});

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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PacientForm(id: '')),
              );
            },
            backgroundColor: const Color(0xff552a7f),
            child: const Icon(Icons.add),
          ),
        ));
  }
}

class PacientTile extends StatelessWidget {
  final Pacient pacient;

  const PacientTile(this.pacient, {super.key});

  @override
  Widget build(BuildContext context) {
    const avatar = CircleAvatar(
      backgroundColor: Color(0xff552a7f),
      child: Icon(
        Icons.person,
        color: Colors.white70,
      ),
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
