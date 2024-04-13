import 'package:academic/size_config.dart';
import 'package:academic/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init;
    return AppBar(
      backgroundColor: blueColor,
      title: Text("Chat Amy", style: GoogleFonts.sora(color: whiteColor)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
