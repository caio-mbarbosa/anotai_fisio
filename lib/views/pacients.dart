import 'package:anotai_fisio/models/pacient.dart';
import 'package:anotai_fisio/provider/pacients_provider.dart';
import 'package:anotai_fisio/views/pacient_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PacientsList extends StatelessWidget {
  const PacientsList({super.key});

  @override
  Widget build(BuildContext context) {
    final Pacients pacients = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione o paciente'),
        backgroundColor: const Color(0xff552a7f),
      ),
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
    );
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
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: avatar,
        title: Text(pacient.name),
        trailing: SizedBox(
          width: 30,
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PacientForm(id: pacient.id)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
