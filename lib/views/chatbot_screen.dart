// ignore_for_file: prefer_const_constructors
import 'package:academic/theme.dart';
import 'package:academic/views/chatbot/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({Key? key, this.color}) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: blackColor),
          onPressed: () {
            Navigator.pop(context); // Navigasi kembali ke halaman sebelumnya
          },
        ),
      ),
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
              'assets/images/robot.gif',
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
              child: SingleChildScrollView(
                // Menambahkan SingleChildScrollView
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 40, left: 34, right: 34, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Asisten Cerdas Kamu',
                        style: GoogleFonts.sora(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Kamu juga bisa tanya seputar permasalahan akademis dan psikologis bareng Amy',
                        style: GoogleFonts.sora(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: grayColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ChatScreenBot());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: blueColor,
                                  borderRadius: BorderRadius.circular(36)),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 13.0, horizontal: 100.0),
                                child: Center(
                                  child: Text(
                                    'Mulai',
                                    style: GoogleFonts.sora(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: whiteColor),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ]),
    );
  }
}
