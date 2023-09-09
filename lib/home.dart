import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double fem = .9;
    double ffem = 1;
    String user = 'fisio';
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(80 * fem, 332 * fem, 22 * fem, 30 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin:
                  EdgeInsets.fromLTRB(59 * fem, 0 * fem, 98 * fem, 62 * fem),
              width: double.infinity,
              height: 30 * fem,
              child: Stack(
                children: [
                  Positioned(
                    // labeltextu8j (1:618)
                    left: 0 * fem,
                    top: 0 * fem,
                    child: Align(
                      child: SizedBox(
                        child: Text(
                          'Olá, $user 👋',
                          style: GoogleFonts.roboto(
                            fontSize: 20 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.2 * ffem / fem,
                            letterSpacing: 0.5 * fem,
                            color: Color(0xffffffff),
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
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 58 * fem, 10 * fem),
              width: 200 * fem,
              height: 40 * fem,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Color.fromRGBO(247, 242, 250, 1),
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
                          color: Color(0xff552a7f),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // buttonLFy (1:725)
              margin:
                  EdgeInsets.fromLTRB(35 * fem, 0 * fem, 94 * fem, 228 * fem),
              width: 150 * fem,
              height: 26 * fem,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Color.fromRGBO(247, 242, 250, 1),
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
                          color: Color(0xff552a7f),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
                margin:
                    EdgeInsets.fromLTRB(250 * fem, 20 * fem, 0 * fem, 0 * fem),
                width: 48 * fem,
                height: 48 * fem,
                decoration: ShapeDecoration(
                    shape: CircleBorder(eccentricity: 1),
                    color: Color.fromRGBO(247, 242, 250, 1)),
                child: IconButton.filled(
                    icon: const Icon(Icons.question_mark),
                    color: Color(0xff552a7f),
                    onPressed: () => {})),
          ],
        ),
      ),
    );
  }
}
