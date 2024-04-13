import 'package:academic/controllers/authentication_controller.dart';
import 'package:academic/controllers/theme_controller.dart';
import 'package:academic/theme.dart';
import 'package:academic/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthController authController = Get.find<AuthController>();
  final ThemeController _themeController = Get.find<ThemeController>();
  final ColorController _colorController = Get.put(ColorController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(NavigationPage());
        return true;
      },
      child: Scaffold(
        backgroundColor: _colorController.getBackgroundColor(),
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: blueColor,
          title: Text(
            "Pengaturan",
            style: GoogleFonts.sora(
              color: whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
          flexibleSpace: SafeArea(
            child: Container(
              height: 65,
              color: Colors.transparent,
              padding: const EdgeInsets.only(right: 16),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _colorController.getContainerColor(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/icon/avatar.png',
                          width: 45,
                        ),
                        Text(
                          authController.user?.displayName ?? 'Tamu',
                          style: GoogleFonts.sora(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 4),
                        Text(
                          authController.user?.email ?? 'anonim',
                          style: GoogleFonts.sora(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: grayColor),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    AuthController.instance.logout();
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _colorController.getContainerColor(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/icon/out_icon.png',
                          width: 35,
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Keluar',
                          style: GoogleFonts.sora(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
