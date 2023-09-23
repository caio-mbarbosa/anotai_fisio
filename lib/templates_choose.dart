import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:anotai_fisio/models/prontuario.dart';
import 'dart:convert';

class Templates extends StatefulWidget {
  @override
  _ModelosScreenState createState() => _ModelosScreenState();

  Templates();
}

class _ModelosScreenState extends State<Templates> {
  List<Modelo> modelos = [];
  _ModelosScreenState();

  @override
  void initState() {
    super.initState();
    loadModelos();
  }

  Future<void> loadModelos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> modelosStringList = prefs.getStringList('modelos') ?? [];
    List<Modelo> modelosList = modelosStringList.map((modelString) {
      Map<String, dynamic> map = json.decode(modelString);
      return Modelo.fromMap(map);
    }).toList();
    setState(() {
      modelos = modelosList;
    });
  }

  void salvarModelo(Modelo novoModelo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    modelos.add(novoModelo);
    List<String> modelosStringList = modelos.map((model) {
      Map<String, dynamic> map = model.toMap();
      return json.encode(map);
    }).toList();
    await prefs.setStringList('modelos', modelosStringList);
    setState(() {});
  }

  void removerModelo(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String modeloRemovido = modelos[index].nome;
    modelos.removeAt(index);
    List<String> modelosStringList = modelos.map((model) {
      Map<String, dynamic> map = model.toMap();
      return json.encode(map);
    }).toList();
    await prefs.setStringList('modelos', modelosStringList);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Modelo "$modeloRemovido" removido com sucesso.'),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modelos'),
        backgroundColor: Color(0xff764abc),
      ),
      body: ListView.builder(
        itemCount: modelos.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2.0,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditScreen(modelo: modelos[index]),
                  ),
                );
              },
              title: Text(modelos[index].nome),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  removerModelo(index);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff764abc),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NovoModeloScreen(),
            ),
          ).then((novoModelo) {
            if (novoModelo != null) {
              salvarModelo(novoModelo);
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class EditScreen extends StatefulWidget {
  final Modelo modelo;

  EditScreen({required this.modelo});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  List<String> campos = [];
  int campoCount = 0;
  _EditScreenState();

  @override
  void initState() {
    super.initState();
    campos = widget.modelo.campos;
  }

  void removerCampo(int index) {
    setState(() {
      campos.removeAt(index);
    });
  }

  void salvarCampos() async {
    widget.modelo.campos = campos;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> modelosStringList = prefs.getStringList('modelos') ?? [];
    List<String> novosModelosStringList = modelosStringList.map((modelString) {
      Map<String, dynamic> map = json.decode(modelString);
      if (map['nome'] == widget.modelo.nome) {
        map['campos'] = campos;
      }
      return json.encode(map);
    }).toList();
    await prefs.setStringList('modelos', novosModelosStringList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Modelo: ${widget.modelo.nome}'),
        backgroundColor: Color(0xff764abc),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: campos.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 10.0),
                    Text(
                      'Campo ${index + 1}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListTile(
                      title: Text(campos[index]),
                    ),
                    Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            removerCampo(index);
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.check_box),
                  color: Color(0xff764abc),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(widget.modelo);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NovoCampoScreen(),
                      ),
                    ).then((novoCampo) {
                      if (novoCampo != null) {
                        setState(() {
                          campoCount++;
                          campos.add(novoCampo);
                        });
                      }
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.save),
                  color: Color(0xff764abc),
                  onPressed: () {
                    salvarCampos();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NovoModeloScreen extends StatelessWidget {
  final TextEditingController _modeloController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Modelo'),
        backgroundColor: Color(0xff764abc),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Novo Modelo',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _modeloController,
              decoration: InputDecoration(
                labelText: 'Nome do Modelo',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff764abc),
              ),
              onPressed: () {
                String nomeModelo = _modeloController.text;
                if (nomeModelo.isNotEmpty) {
                  Modelo novoModelo = Modelo(nome: nomeModelo, campos: []);
                  Navigator.pop(context, novoModelo);
                }
              },
              child: Text('Adicionar Modelo'),
            ),
          ],
        ),
      ),
    );
  }
}

class NovoCampoScreen extends StatelessWidget {
  final TextEditingController _campoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Campo'),
        backgroundColor: Color(0xff764abc),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Novo Campo',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _campoController,
              decoration: InputDecoration(
                labelText: 'Nome do Campo',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String novoCampo = _campoController.text;
                Navigator.pop(context, novoCampo);
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xff764abc)),
              child: Text('Adicionar Campo'),
            ),
          ],
        ),
      ),
    );
  }
}
