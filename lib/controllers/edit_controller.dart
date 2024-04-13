import 'package:academic/main.dart';
import 'package:academic/models/rating.dart';
import 'package:academic/models/rating_value.dart';
import 'package:academic/services/db.dart';
import 'package:academic/theme.dart';
import 'package:academic/views/mood/edit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewRatingController {
  DateTime selectedDate = DateTime.now();
  List<bool> selected = [false, false, false, false, false];
  TextEditingController noteController = TextEditingController();
  bool isComplete = false;

  void setValue(int index) {
    if (index < 0 || index > 4) return;
    selected = [false, false, false, false, false];
    selected[index] = true;
  }

  int getValue() {
    return selected.indexWhere((element) => element == true) + 1;
  }

  RatingValue? getRatingValue() {
    if (getValue() <= 0) return null;
    return RatingValue.values[getValue()];
  }

  bool isSelected(RatingValue value) {
    return selected[value.index - 1];
  }

  DateTime getDate() {
    return selectedDate;
  }

  void setDate(DateTime date) {
    selectedDate = date;
  }

  void updateRating(DateTime? initDate) {
    if (initDate != null && initDate != getDate())
      DatabaseService.deleteRating(initDate);
    Rating rating = Rating(
      date: selectedDate,
      value: RatingValue.values[getValue()],
      note: noteController.text,
    );
    DatabaseService.setRating(rating);
    isComplete = true;
  }

  void showUnsavedAlert(
      Function refresher, DateTime? date, RatingValue? rating, String? note) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: Text(
          'Buang perubahan?',
          style: GoogleFonts.sora(
            color: brownColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Anda memiliki perubahan yang belum disimpan. Apakah Anda yakin ingin membuangnya?',
          style: GoogleFonts.sora(color: whiteColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Buang',
              style: GoogleFonts.sora(color: whiteColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              showEditPopupHelper(this, refresher, date, rating, note);
            },
            child: Text(
              'Lanjutkan Mengedit',
              style: GoogleFonts.sora(color: whiteColor),
            ),
          ),
        ],
        backgroundColor: blueColor,
      ),
    );
  }

  void saveRating(DateTime? initDate, Function refresher) {
    void saveRating() {
      updateRating(initDate);
      Navigator.pop(navigatorKey.currentContext!);
      refresher(() {});
    }

    if (initDate != getDate() &&
        DatabaseService.getRatingFromDay(getDate()) != null) {
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
          title: Text(
            'Overwrite rating?',
            style: GoogleFonts.sora(
              color: brownColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Anda telah menilai hari ini. Apakah Anda yakin ingin menimpa rating sebelumnya?',
            style: GoogleFonts.sora(color: whiteColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Batal',
                style: GoogleFonts.sora(color: whiteColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                saveRating();
              },
              child: Text(
                'Timpa',
                style: GoogleFonts.sora(color: whiteColor),
              ),
            ),
          ],
          backgroundColor: blueColor,
        ),
      );
    } else {
      saveRating();
    }
  }
}
