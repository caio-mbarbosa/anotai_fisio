import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'onboarding.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    double fem = .9;
    double ffem = 1;
    double svgSize = 300;
    double screenPadding = 50;
    double rowGap = 20;
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(
              screenPadding * fem,
              3 * screenPadding * fem,
              screenPadding * fem,
              screenPadding * fem),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff552a7f),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    0 * fem, 0 * fem, 0 * fem, rowGap * fem),
                width: svgSize * fem,
                height: svgSize * fem,
                child: SvgPicture.asset('assets/logoanotai.svg',
                    semanticsLabel: 'Logo',
                    // ignore: deprecated_member_use
                    color: const Color.fromRGBO(255, 255, 255, 1)),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    // buttonATy (1:728)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, rowGap * fem),
                    width: 200 * fem,
                    height: 40 * fem,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: const Color.fromRGBO(247, 242, 250, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100 * fem)),
                      ),
                      child: Center(
                        child: Center(
                          child: Text(
                            'Iniciar',
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
              ),
            ],
          )),
    );
  }
}
