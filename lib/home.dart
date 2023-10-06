import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:anotai_fisio/views/pacients.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double fem = .9;
    double ffem = 1;
    double svgSize = 300;
    String user = 'fisio';
    double screenPadding = 15;
    double rowGap = 20;
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(screenPadding * fem, screenPadding * fem,
              screenPadding * fem, screenPadding * fem),
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, -1),
              end: Alignment(-0, 1),
              colors: <Color>[
                Color.fromARGB(204, 85, 42, 127),
                Color.fromRGBO(85, 42, 127, 0.5)
              ],
              stops: <double>[0, 1],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, rowGap * fem),
                    width: svgSize * fem,
                    height: svgSize * fem,
                    child: SvgPicture.asset('assets/logoanotfisio.svg',
                        semanticsLabel: 'Logo'),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, rowGap * fem),
                    width: double.infinity,
                    height: 30 * fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // labeltextu8j (1:618)
                          child: Align(
                            child: SizedBox(
                              child: Text(
                                'Olá, $user 👋',
                                style: GoogleFonts.roboto(
                                  fontSize: 20 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2 * ffem / fem,
                                  letterSpacing: 0.5 * fem,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // buttonATy (1:728)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, rowGap * fem),
                    width: 200 * fem,
                    height: 40 * fem,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PacientsList()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: const Color.fromRGBO(247, 242, 250, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100 * fem)),
                      ),
                      child: Container(
                        child: Center(
                          child: Center(
                            child: Text(
                              'Criar Prontuário',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.4285714286 * ffem / fem,
                                letterSpacing: 0.1000000015 * fem,
                                color: const Color(0xff552a7f),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // buttonLFy (1:725)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, rowGap * fem),
                    width: 150 * fem,
                    height: 26 * fem,
                    child: ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: const Color.fromRGBO(247, 242, 250, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100 * fem)),
                      ),
                      child: Container(
                        child: Center(
                          child: Center(
                            child: Text(
                              'Minha Conta',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.4285714286 * ffem / fem,
                                letterSpacing: 0.1000000015 * fem,
                                color: const Color(0xff552a7f),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        width: 48 * fem,
                        height: 48 * fem,
                        decoration: const ShapeDecoration(
                            shape: CircleBorder(eccentricity: 1),
                            color: Color.fromRGBO(247, 242, 250, .5)),
                        child: const IconButton.filled(
                            icon: Icon(Icons.question_mark),
                            color: Color(0xff552a7f),
                            onPressed: null))),
              ),
            ],
          )),
    );
  }
}
