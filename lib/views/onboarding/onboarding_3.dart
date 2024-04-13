// ignore_for_file: prefer_const_constructors
import 'package:academic/theme.dart';
import 'package:academic/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class Onboarding3Screen extends StatelessWidget {
  const Onboarding3Screen({Key? key, this.color}) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
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
          child: Image.asset(
            'assets/images/award.gif',
            height: 500,
            width: 300,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Evaluasi Stres Siswa & Gamifikasi dalam Pendidikan',
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
                      'Kami memberikan fitur evaluasi dan tes tingkat stres yang dialami siswa secara rutin dan dapat menyelesaikan tugas, ujian, dan tantangan belajar lainnya',
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
