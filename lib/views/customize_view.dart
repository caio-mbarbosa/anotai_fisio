import 'package:flutter/material.dart';

class OldPacientsView extends StatelessWidget {
  final double fem = 1;
  final double ffem = 1.5;

  const OldPacientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // files9hq (2:6)
        padding: EdgeInsets.fromLTRB(24 * fem, 59 * fem, 26 * fem, 43 * fem),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogroupd3ybDxb (4UrAq7KXi3JsvPBT6md3YB)
              margin: EdgeInsets.fromLTRB(0*fem, 0 * fem, 55 * fem, 98 * fem),
              width: double.infinity,
              child:
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // iconYzs (16:5109)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 51.59 * fem, 0 * fem),
                      width: 7.41 * fem,
                      height: 12 * fem,
                      child:
                      Container(
                        width: 200, // Largura desejada do Container
                        height: 200, // Altura desejada do Container
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/return_icon.png'), // Caminho para a imagem no seu projeto
                            fit: BoxFit.cover, // Ajuste da imagem dentro do Container
                          ),
                        ),
                      )
                    // child:
                    // Image.network(
                    //   [Image url]
                    //   width: 7.41*fem,
                    //   height: 12 * fem,
                    // ),
                  ),
                  Text(
                    // labeltextfZh (16:3097)
                    'Selecione o Paciente',
                    style: TextStyle(
                      fontSize: 20 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.2 * ffem / fem,
                      letterSpacing: 0.5 * fem,
                      color: const Color(0xff1d1b20),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // horizontalcardNyu (1:666)
              margin: EdgeInsets.fromLTRB(2 * fem, 0 * fem, 0 * fem, 17 * fem),
              width: 308 * fem,
              height: 69 * fem,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12 * fem),
              ),
              child:
              Container(
                // cardstatelayerelevated7Ao (I1:666;52350:28184)
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xfff7f2fa),
                  borderRadius: BorderRadius.circular(12 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x26000000),
                      offset: Offset(0 * fem, 1 * fem),
                      blurRadius: 1.5 * fem,
                    ),
                    BoxShadow(
                      color: const Color(0x4c000000),
                      offset: Offset(0 * fem, 1 * fem),
                      blurRadius: 1 * fem,
                    ),
                  ],
                ),
                child:
                Container(
                  // contentcontainerc7Z (I1:666;52350:28185)
                  padding: EdgeInsets.fromLTRB(16 * fem, 0 * fem, 0 * fem, 0 * fem),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffcac4d0)),
                    borderRadius: BorderRadius.circular(12 * fem),
                  ),
                  child:
                  SizedBox(
                    // headerjxs (I1:666;52350:28186)
                    width: double.infinity,
                    height: 70.5 * fem,
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // content5mq (I1:666;52350:28187)
                          margin: EdgeInsets.fromLTRB(0*fem, 0 * fem, 78 * fem, 0 * fem),
                          child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // monogramEPq (I1:666;52350:28188)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 16 * fem, 0 * fem),
                                width: 40 * fem,
                                height: 40 * fem,
                                decoration: BoxDecoration(
                                  color: const Color(0xff552a7f),
                                  borderRadius: BorderRadius.circular(20 * fem),
                                ),
                                child:
                                Center(
                                  child:
                                  Center(
                                    child:
                                    Text(
                                      'P',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        //'Roboto',
                                        fontSize: 16 * ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5 * ffem / fem,
                                        letterSpacing: 0.150000006 * fem,
                                        color: const Color(0xfffef7ff),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                // text5QT (I1:666;52350:28191)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 8 * fem, 0 * fem, 0 * fem),
                                height: 48 * fem,
                                child:
                                Text(
                                  'Paciente 1',
                                  style: TextStyle(
                                    //'Roboto',
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5 * ffem / fem,
                                    letterSpacing: 0.150000006 * fem,
                                    color: const Color(0xff1d1b20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // mediaykj (I1:666;52350:28194)
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                          width: 80 * fem,
                          height: 69 * fem,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffcac4d0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // horizontalcardhgj (17:5449)
              margin: EdgeInsets.fromLTRB(2*fem, 0*fem, 0*fem, 365*fem),
              width: 308*fem,
              height: 69*fem,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(12*fem),
              ),
              child:
              Container(
                // cardstatelayerelevatedDQB (I17:5449;52350:28184)
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration (
                  color: const Color(0xfff7f2fa),
                  borderRadius: BorderRadius.circular(12*fem),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x26000000),
                      offset: Offset(0*fem, 1*fem),
                      blurRadius: 1.5*fem,
                    ),
                    BoxShadow(
                      color: const Color(0x4c000000),
                      offset: Offset(0*fem, 1*fem),
                      blurRadius: 1*fem,
                    ),
                  ],
                ),
                child:
                Container(
                  // contentcontainerWu5 (I17:5449;52350:28185)
                  padding: EdgeInsets.fromLTRB(16*fem, 0*fem, 0*fem, 0*fem),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration (
                    border: Border.all(color: const Color(0xffcac4d0)),
                    borderRadius: BorderRadius.circular(12*fem),
                  ),
                  child:
                  SizedBox(
                    // header49u (I17:5449;52350:28186)
                    width: double.infinity,
                    height: 70.5*fem,
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // content1aw (I17:5449;52350:28187)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 78*fem, 0*fem),
                          child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // monogramkYX (I17:5449;52350:28188)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                                width: 40*fem,
                                height: 40*fem,
                                decoration: BoxDecoration (
                                  color: const Color(0xff552a7f),
                                  borderRadius: BorderRadius.circular(20*fem),
                                ),
                                child:
                                Center(
                                  child:
                                  Center(
                                    child:
                                    Text(
                                      'P',
                                      textAlign: TextAlign.center,
                                      style: TextStyle (
                                        //'Roboto',
                                        fontSize: 16*ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5*ffem/fem,
                                        letterSpacing: 0.150000006*fem,
                                        color: const Color(0xfffef7ff),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                // textqK5 (I17:5449;52350:28191)
                                margin: EdgeInsets.fromLTRB(0*fem, 8*fem, 0*fem, 0*fem),
                                height: 48*fem,
                                child:
                                Text(
                                  'Paciente 2',
                                  style: TextStyle (
                                    //'Roboto',
                                    fontSize: 16*ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5*ffem/fem,
                                    letterSpacing: 0.150000006*fem,
                                    color: const Color(0xff1d1b20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // media9af (I17:5449;52350:28194)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1.5*fem),
                          width: 80*fem,
                          height: 69*fem,
                          decoration: BoxDecoration (
                            border: Border.all(color: const Color(0xffcac4d0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // frame8tHM (204:454)
              margin: EdgeInsets.fromLTRB(254*fem, 0*fem, 0*fem, 0*fem),
              width: 56*fem,
              height: 56*fem,
              child:
              Stack(
                children: [
                  // Positioned(
                  // // fabE6K (204:449)
                  // left: 0*fem,
                  // top: 0*fem,
                  // child:
                  // Align(
                  // child:
                  // SizedBox(
                  // width: 56*fem,
                  // height: 56*fem,
                  // child:
                  // TextButton(
                  // onPressed: () {},
                  // style: TextButton.styleFrom (
                  // padding: EdgeInsets.zero,
                  // ),
                  // // child:
                  // // Image.network(
                  // // [Image url]
                  // // width: 56*fem,
                  // // height: 56*fem,
                  // // ),
                  // ),
                  // ),
                  // ),
                  // ),
                  Positioned(
                    // jHy (1:804)
                    left: 18.5*fem,
                    top: 18*fem,
                    child:
                    Center(
                      child:
                      Align(
                        child:
                        SizedBox(
                          width: 19*fem,
                          height: 20*fem,
                          child:
                          Text(
                            '+',
                            textAlign: TextAlign.center,
                            style: TextStyle (
                              //'Roboto',
                              fontSize: 32*ffem,
                              fontWeight: FontWeight.w500,
                              height: 0.625*ffem/fem,
                              letterSpacing: 0.32*fem,
                              color: const Color(0xff552a7f),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
        ,
      )
      ,

    );
  }
}
