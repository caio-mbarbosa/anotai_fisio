import 'package:anotai_fisio/onboarding.dart';
import 'package:anotai_fisio/start.dart';
import 'package:anotai_fisio/views/pacients.dart';
import 'package:anotai_fisio/views/customize.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anotai_fisio/provider/pacients_provider.dart';
import 'record.dart';
import 'home.dart';
import 'end.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Pacients()),
      ],
      child: const MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false),
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
                backgroundColor: const Color(0xff552a7f),
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
                        color: Color(0xff552a7f),
                      ),
                      child: Text('Menu'),
                    ),
                    ListTile(
                      leading: const Icon(
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
                      leading: const Icon(
                        Icons.home,
                      ),
                      title: const Text('Home'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.start,
                      ),
                      title: const Text('Start'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Start()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.train,
                      ),
                      title: const Text('Cadastrar Paciente'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PacientsList()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.addchart_sharp,
                      ),
                      title: const Text('Customizar Prontuários'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CustomizeView()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.exit_to_app,
                      ),
                      title: const Text('End'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const End(
                                  pacient_link_sheets:
                                      '1uNxaDQBfw4DArgUpP51EucaRNLnrwghR5VpO8hmAoW8',
                                  mensagemCode: 'Placeholder')),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.on_device_training,
                      ),
                      title: const Text('Onboarding'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OnBoardingScreen()),
                        );
                      },
                    ),
                  ],
                ),
              )
            : null,
        body: const Start());
  }
}
