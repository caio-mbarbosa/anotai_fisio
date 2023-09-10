import 'package:anotai_fisio/models/pacient.dart';
import 'package:anotai_fisio/provider/pacients_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';


// class PacientFormProvider extends StatelessWidget{
//   final String id;
//
//   PacientFormProvider({required this.id});
//
//   @override
//   Widget build(BuildContext context){
//     return ChangeNotifierProvider(
//       create: (ctx) => Pacients(),
//       child: PacientForm(id: id),
//     );
//   }
// }


class PacientForm extends StatelessWidget{
  final String id;
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  PacientForm({required this.id});

  void _loadFormData(String id, BuildContext context){
    if (id != ''){
     final Pacient pacient = Provider.of<Pacients>(context, listen: false).byIndex(id);
    _formData['id'] = pacient.id;
    _formData['name'] = pacient.name;
    _formData['age'] = pacient.age.toString();
    _formData['sex'] = pacient.sex;
    _formData['occupation'] = pacient.occupation;
    }
  }

  @override
  Widget build(BuildContext context){
    final String name = Provider.of<Pacients>(context, listen: false).byIndex(id).name;

    _loadFormData(id, context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario paciente'),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          final isValid = _form.currentState?.validate();

          if (isValid == true){
           _form.currentState?.save();
           Provider.of<Pacients>(context, listen: false).put(Pacient(
               id: _formData['id'].toString(),
               name: _formData['name'].toString(),
               age: int.parse(_formData['age'].toString()),
               sex: _formData['sex'].toString(),
               occupation: _formData['occupation'].toString()
           ));
           Navigator.of(context).pop();
           print('dei put de um pacient');
          }
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return 'Nome invalido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['name'] = value.toString();
                },
              ),
              TextFormField(
                initialValue: _formData['age'],
                decoration: InputDecoration(labelText: 'Idade'),
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return 'Nome invalido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['age'] = value.toString();
                },
              ),
              TextFormField(
                initialValue: _formData['sex'],
                decoration: InputDecoration(labelText: 'Sexo'),
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return 'Nome invalido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['sex'] = value.toString();
                },
              ),
              TextFormField(
                initialValue: _formData['occupation'],
                decoration: InputDecoration(labelText: 'Ocupacao'),
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return 'Nome invalido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['occupation'] = value.toString();
                },
              )
            ],
          )
        ),
      ),
    );
  }
}