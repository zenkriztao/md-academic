import 'package:academic/size_config.dart';
import 'package:academic/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturesAppBar extends StatelessWidget {
  final String title;

  const FeaturesAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(
        context); // Initialize SizeConfig before using screenWidth and screenHeight
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(0.04)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.sora(
                    color: blueColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
