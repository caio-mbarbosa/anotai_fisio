import 'dart:async';
import 'package:anotai_fisio/models/pacient.dart';
import 'package:anotai_fisio/start.dart';
import 'package:anotai_fisio/views/pacients.dart';
import 'package:anotai_fisio/views/customize.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:anotai_fisio/provider/pacients_provider.dart';
import 'package:anotai_fisio/audio_player.dart';
import 'package:anotai_fisio/data/dummy_pacients.dart';
import 'record.dart';
import 'home.dart';
import 'end.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Pacients()),
      ],
      child: MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: kDebugMode
            ? AppBar(
                centerTitle: true,
                title: const Text(
                  'Home',
                ),
                backgroundColor: const Color(0xff764abc),
              )
            : null,
        drawer: kDebugMode
            ? Drawer(
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        color: const Color(0xff764abc),
                      ),
                      child: Text('Menu'),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.record_voice_over,
                      ),
                      title: const Text('Gravação'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Recording(
                                  // campos: ['asdas'],
                                  // pacient: Pacient(
                                  //     id: '100',
                                  //     name: 'TesteDummy',
                                  //     age: 11,
                                  //     sex: 'M',
                                  //     link_sheets: 'abc')
                                  )),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.home,
                      ),
                      title: const Text('Home'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.start,
                      ),
                      title: const Text('Start'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Start()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.train,
                      ),
                      title: const Text('Cadastrar Paciente'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PacientsList()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.addchart_sharp,
                      ),
                      title: const Text('Customizar Prontuários'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomizeView()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                      ),
                      title: const Text('End'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => End(
                                  pacient_link_sheets:
                                      '1uNxaDQBfw4DArgUpP51EucaRNLnrwghR5VpO8hmAoW8',
                                  mensagemCode: 'Placeholder')),
                        );
                      },
                    ),
                  ],
                ),
              )
            : null,
        body: Start());
  }
}
