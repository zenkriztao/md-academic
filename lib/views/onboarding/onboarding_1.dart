// ignore_for_file: prefer_const_constructors
import 'package:academic/theme.dart';
import 'package:academic/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class Onboarding1Screen extends StatelessWidget {
  const Onboarding1Screen({Key? key, this.color}) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xffffff),
                Color(0xffffff),
              ],
              stops: [
                0.0,
                1.0,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: Image.asset(
              'assets/images/student.gif',
              height: 440,
              width: 500,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 34, right: 34, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Pemantauan Aktivitas Siswa',
                      style: GoogleFonts.sora(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: blackColor,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Kami memungkinkan siswa untuk mencatat pengalaman harian mereka dan menganalisis sentimen yang terkait akademis .',
                      style: GoogleFonts.sora(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: grayColor,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ]),
    );
  }
}
