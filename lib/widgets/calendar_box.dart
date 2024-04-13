import 'package:academic/controllers/calendar_mood_controller.dart';
import 'package:academic/theme.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:academic/services/date.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/rating.dart';

class CalendarBox extends StatefulWidget {
  final MonthCellDetails details;
  final ColorGridController controller;

  const CalendarBox({
    super.key,
    required this.details,
    required this.controller,
  });

  @override
  State<CalendarBox> createState() => _CalendarBoxState();
}

class _CalendarBoxState extends State<CalendarBox> {
  @override
  Widget build(BuildContext context) {
    final Rating? rating = widget.controller.getRating(widget.details.date);

    return Container(
      decoration: BoxDecoration(
        color: rating != null
            ? rating.value.color
            : !widget.details.date.isAfter(DateTime.now())
                ? brownColor
                : greenColor,
        border: Border.all(
          color: whiteColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: DateService.isSameDay(widget.details.date, DateTime.now()) &&
                    rating == null
                ? blueColor
                : Colors.transparent,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Center(
          child: Text(
            widget.details.date.day.toString(),
            style: GoogleFonts.sora(
              color: whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
