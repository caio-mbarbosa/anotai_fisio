import 'dart:ui';

import 'package:anotai_fisio/start.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:anotai_fisio/views/pacients.dart';
import 'package:url_launcher/url_launcher.dart';

class End extends StatelessWidget {
  final String? pacient_link_sheets;
  final String mensagemCode;

  const End({Key? key, required this.pacient_link_sheets, required this.mensagemCode}) : super(key: key);

  void updateText(){

  }

  @override
  Widget build(BuildContext context) {
    double fem = 1;
    double ffem = 1;
    double svgSize = 300;
    String user = 'Fisio';
    double screenPadding = 15;
    double rowGap = 20;
    final Uri _url = Uri.parse(
        'https://docs.google.com/spreadsheets/d/' + pacient_link_sheets!);
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(screenPadding * fem, screenPadding * fem,
              screenPadding * fem, screenPadding * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF9175AC),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  height: 50 * fem,
                  child: Stack(
                    children: [
                      Positioned(
                        // labeltextu8j (1:618)
                        child: Align(
                          child: SizedBox(
                            child: Text(
                              'Obrigado!',
                              style: GoogleFonts.roboto(
                                fontSize: 30 * ffem,
                                fontWeight: FontWeight.bold,
                                height: 1.2 * ffem / fem,
                                letterSpacing: 0.5 * fem,
                                color: Color(0xffffffff),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 0 * fem, rowGap * fem),
                  width: double.infinity,
                  height: 50 * fem,
                  child: Stack(
                    children: [
                      Positioned(
                        // labeltextu8j (1:618)
                        child: Align(
                          child: SizedBox(
                            child: Text(
                              mensagemCode,
                              style: GoogleFonts.roboto(
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2 * ffem / fem,
                                letterSpacing: 0.5 * fem,
                                color: Color(0xffffffff),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.fromLTRB(
                //       0 * fem, 0 * fem, 0 * fem, rowGap * fem),
                //   width: double.infinity,
                //   height: 50 * fem,
                //   child: Stack(
                //     children: [
                //       Positioned(
                //         // labeltextu8j (1:618)
                //         child: Align(
                //           child: SizedBox(
                //             child: Text(
                //               '$user, a planilha preenchida pode ser acessada por esse link:',
                //               style: GoogleFonts.roboto(
                //                 fontSize: 20 * ffem,
                //                 fontWeight: FontWeight.w400,
                //                 height: 1.2 * ffem / fem,
                //                 letterSpacing: 0.5 * fem,
                //                 color: Color(0xffffffff),
                //               ),
                //               textAlign: TextAlign.center,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // InkWell(
                //     child: Text(
                //       'Abrir no Browser',
                //       style: GoogleFonts.roboto(
                //         fontSize: 12 * ffem,
                //         decoration: TextDecoration.underline,
                //         fontWeight: FontWeight.w400,
                //         height: 1.2 * ffem / fem,
                //         letterSpacing: 0.5 * fem,
                //         color: Color(0xff0000ff),
                //       ),
                //     ),
                //     onTap: () => launchUrl(_url)),
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Start()),
                      );
                    },
                    icon: Icon(Icons.exit_to_app,
                        color: Color.fromARGB(255, 255, 255, 255))),
                SizedBox(height: rowGap),
                SizedBox(height: rowGap),
                SizedBox(height: rowGap),
              ])),
    );
  }
}
