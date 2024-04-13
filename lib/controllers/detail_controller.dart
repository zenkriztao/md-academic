import 'package:academic/models/rating.dart';
import 'package:academic/services/db.dart';
import 'package:academic/theme.dart';
import 'package:academic/views/mood/edit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPageController {
  void editRating(Function refresher, Rating rating) {
    showEditPopup(refresher, rating.date, rating.value, rating.note);
  }

  void deleteRating(DateTime date, Function refresher) {
    DatabaseService.deleteRating(date);
    refresher(() {});
  }

  void showDeleteAlert(
      BuildContext context, Function refresher, Rating rating) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Hapus Rating",
            style: GoogleFonts.sora(
              color: brownColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Apakah Anda yakin ingin menghapus rating ini?",
            style: GoogleFonts.sora(color: whiteColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Batal",
                style: GoogleFonts.sora(color: whiteColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                deleteRating(rating.date, refresher);
                Navigator.pop(context);
              },
              child: Text(
                "Hapus",
                style: GoogleFonts.sora(color: whiteColor),
              ),
            ),
          ],
          backgroundColor: blueColor,
        );
      },
    );
  }
}
