import 'package:academic/controllers/navigation_controller.dart';
import 'package:academic/controllers/theme_controller.dart';
import 'package:academic/size_config.dart';
import 'package:academic/theme.dart';
import 'package:academic/widgets/features_appbar.dart';
import 'package:academic/widgets/menu.dart';
import 'package:academic/widgets/mood_board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/authentication_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = Get.find<AuthController>();
  final ColorController _colorController = Get.put(ColorController());
  final BottomNavigationController _bottomNavigationController =
      Get.put(BottomNavigationController());
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: blueColor,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
                color: _colorController.getActivityBackgroundColor(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: edge),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.sora(
                        fontWeight: FontWeight.w600,
                        color: whiteColor,
                        fontSize: 26),
                    children: [
                      TextSpan(
                        text: 'Let`s strengthen our ',
                      ),
                      TextSpan(
                        text: 'mentality',
                        style: TextStyle(
                            color:
                                greenColor), // Mengubah warna menjadi greenColor
                      ),
                    ],
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
                const SizedBox(
                  height: 30,
                ),
                const MoodBoard(),
                const SizedBox(
                  height: 20,
                ),
                const FeaturesAppBar(
                  title: "Kategori",
                ),
                Menu(),
                const FeaturesAppBar(
                  title: "Fitur",
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Container(
                      child: Image.asset(
                        'assets/images/belajar.png',
                        width: 400,
                        height: 150,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Image.asset(
                      'assets/images/konsultasi.png',
                      width: 400,
                      height: 150,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ))),
    );
  }
}
