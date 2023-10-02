// ignore_for_file: avoid_print, must_be_immutable
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'record.dart';

// OnBoarding content Model
class OnBoard {
  final String image = "assets/logo.png", title, description;

  OnBoard({
    required this.title,
    required this.description,
  });
}

// OnBoarding content list
final List<OnBoard> demoData = [
  OnBoard(
    title: "Você fala, nós anotamos!",
    description:
        "Passo 1: Clique para iniciar a gravação e escolha o modelo de preenchimento adequado.",
  ),
  OnBoard(
    title: "Confira as informações!",
    description:
        "Passo 2: Grave o áudio, escolha o paciente e revise os dados coletados, após isso, é só submeter seu relatório para a planilha de armazenamento.",
  ),
  OnBoard(
    title: "Tudo certo!",
    description:
        "Passo 3: Acesse os relatórios preenchidos e organizados na sua planilha de armazenamento. Você também pode acessar pela lista de pacientes salvos!",
  ),
  OnBoard(
    title: "Crie o modelo e o paciente!",
    description:
        "Antes de começar, lembre-se de criar o seu primeiro modelo de preenchimento e primeiro o paciente!",
  ),
  OnBoard(
    title: "Disponibilize uma planilha Google Sheets!",
    description:
        "Para essa demo, precisamos que seja disponibilizada, para cada paciente, uma planilha aberta para edição de qualquer pessoa com o link",
  ),
];

// OnBoardingScreen
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // Variables
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize page controller
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // Dispose everything
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fem = .9;
    double ffem = 1;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        // Background gradient
        decoration: const BoxDecoration(
          color: Color(0xff552a7f),
        ),
        child: Column(
          children: [
            // Carousel area
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemCount: demoData.length,
                controller: _pageController,
                itemBuilder: (context, index) => OnBoardContent(
                  title: demoData[index].title,
                  description: demoData[index].description,
                  image: demoData[index].image,
                ),
              ),
            ),
            // Indicator area
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    demoData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: DotIndicator(
                        isActive: index == _pageIndex,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // White space
            const SizedBox(
              height: 16,
            ),
            // Button area
            (_pageIndex == demoData.length - 1)
                ? InkWell(
                    onTap: () {
                      print("Button clicked!");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Recording()),
                      );
                    },
                    child: Container(
                      width: 220,
                      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                      margin: const EdgeInsets.only(bottom: 48),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Finalizar",
                          style: GoogleFonts.roboto(
                            fontSize: 20 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.4285714286 * ffem / fem,
                            letterSpacing: 0.1000000015 * fem,
                            color: Color(0xff552a7f),
                          ),
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {},
                    child: Container(
                      width: 220,
                      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                      margin: const EdgeInsets.only(bottom: 48),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(0, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Finalizar",
                          style: GoogleFonts.roboto(
                            fontSize: 20 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.4285714286 * ffem / fem,
                            letterSpacing: 0.1000000015 * fem,
                            color: Color.fromARGB(0, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

// OnBoarding area widget
class OnBoardContent extends StatelessWidget {
  OnBoardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  String image;
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(image),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Spacer(),
      ],
    );
  }
}

// Dot indicator widget
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? Color(0xff21005D) : Colors.white,
        border: isActive ? null : Border.all(color: Color(0xff21005D)),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
