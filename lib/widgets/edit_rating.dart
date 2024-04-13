import 'package:academic/widgets/color_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:google_fonts/google_fonts.dart';
import 'package:academic/controllers/edit_controller.dart';
import 'package:academic/models/rating_value.dart';

class EditRating extends StatefulWidget {
  final NewRatingController controller;
  final Function refresher;
  final DateTime? date;
  final RatingValue? rating;
  final String? note;
  const EditRating(
      {Key? key,
      required this.controller,
      required this.refresher,
      this.date,
      this.rating,
      this.note})
      : super(key: key);

  @override
  State<EditRating> createState() => _EditRatingState();
}

class _EditRatingState extends State<EditRating> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Nilai Harimu',
                style: GoogleFonts.sora(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4285F4), // Warna biru
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ToggleButtons(
                isSelected: widget.controller.selected,
                color: const Color(0xFFF5F5F5), // Warna putih
                selectedColor: const Color(0xFF34A853), // Warna hijau
                fillColor: Colors.transparent,
                splashColor: Colors.transparent,
                renderBorder: false,
                children: [
                  ColorBox(
                      value: RatingValue.one, controller: widget.controller),
                  ColorBox(
                      value: RatingValue.two, controller: widget.controller),
                  ColorBox(
                      value: RatingValue.three, controller: widget.controller),
                  ColorBox(
                      value: RatingValue.four, controller: widget.controller),
                  ColorBox(
                      value: RatingValue.five, controller: widget.controller),
                ],
                onPressed: (int index) {
                  setState(() {
                    widget.controller.setValue(index);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                maxLines: 5,
                controller: widget.controller.noteController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF4285F4), // Warna biru
                    ),
                  ),
                  labelText: 'Catatan',
                  labelStyle: GoogleFonts.sora(
                    color: Color.fromARGB(255, 0, 0, 0), // Warna biru
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 130,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: GoogleFonts.sora(
                        fontSize: 16,
                        color: const Color(0xFF4285F4), // Warna biru
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: widget.controller.getDate(),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (DateTime newDate) {
                      widget.controller.setDate(newDate);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: widget.controller.getValue() == 0
                    ? null
                    : () {
                        widget.controller
                            .saveRating(widget.date, widget.refresher);
                      },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF34A853), // Warna hijau
                  textStyle: GoogleFonts.sora(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Simpan'),
              ),
            ),
            const SizedBox(height: 10),
          ]),
    );
  }
}
