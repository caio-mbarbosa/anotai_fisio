import 'package:anotai_fisio/models/pacient.dart';
import 'package:anotai_fisio/provider/pacients_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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

class PacientForm extends StatelessWidget {
  final String id;
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  PacientForm({required this.id});

  void _loadFormData(String id, BuildContext context) {
    if (id != '') {
      final Pacient? pacient =
          Provider.of<Pacients>(context, listen: false).byId(id);
      if (pacient != null) {
        _formData['id'] = pacient.id;
        _formData['name'] = pacient.name;
        _formData['age'] = pacient.age.toString();
        _formData['sex'] = pacient.sex;
        _formData['link_sheets'] = pacient.link_sheets;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadFormData(id, context);
    double fem = .9;
    double ffem = 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario paciente'),
        backgroundColor: Color(0xff552a7f),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        backgroundColor: Color(0xff552a7f),
        onPressed: () {
          final isValid = _form.currentState?.validate();

          if (isValid == true) {
            _form.currentState?.save();
            Provider.of<Pacients>(context, listen: false).put(Pacient(
                id: _formData['id'].toString(),
                name: _formData['name'].toString(),
                age: int.parse(_formData['age'].toString()),
                sex: _formData['sex'].toString(),
                link_sheets: _formData['link_sheets'].toString(),
                hasInserted: false));
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
                    if (value == null || value.isEmpty) {
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
                    if (value == null || value.isEmpty) {
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
                    if (value == null || value.isEmpty) {
                      return 'Nome invalido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _formData['sex'] = value.toString();
                  },
                ),
                TextFormField(
                    initialValue: _formData['link_sheets'],
                    decoration:
                        InputDecoration(labelText: 'Link Google Sheets'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome invalido';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _formData['link_sheets'] = value.toString();
                    }),
                const SizedBox(height: 80),
                _formData['link_sheets'] != null
                    ? InkWell(
                        onTap: () {
                          final Uri _url = Uri.parse(_formData['link_sheets']!);
                          print("Button clicked!");
                          launchUrl(_url);
                        },
                        child: Container(
                          width: 220,
                          padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                          decoration: BoxDecoration(
                            color: Color(0xff552a7f),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Abrir planilha",
                              style: GoogleFonts.roboto(
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.4285714286 * ffem / fem,
                                letterSpacing: 0.1000000015 * fem,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(height: 1),
              ],
            )),
      ),
    );
  }
}
