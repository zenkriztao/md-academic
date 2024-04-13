import 'dart:convert';
import 'package:academic/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import the Google Fonts package
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final CollectionReference _profileCollection =
      FirebaseFirestore.instance.collection("Profile");

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  Map<String, List> mySelectedEvents = {};

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final String day = DateTime.now().day.toString();
  final int numDay = DateTime.now().weekday;
  final int numMonth = DateTime.now().month;
  final int years = DateTime.now().year;

  void _loadPreviousEvents() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('Profile')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (doc.exists) {
        final eventsMap =
            Map<String, dynamic>.from(doc.data()!['events'] as Map);
        setState(() {
          mySelectedEvents = eventsMap.cast<String, List<dynamic>>();
        });
      }
    } catch (e) {
      print('Error loading previous events: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;
    _loadPreviousEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5), // Set background color
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20), // Add some top spacing
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Catat Tugasmu!",
                      style: GoogleFonts.sora(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color:
                            Color.fromARGB(255, 89, 89, 89), // Set text color
                      ),
                    ),
                    const SizedBox(width: 20), // Add some spacing
                    // Tambahkan gambar GIF di sini
                  ],
                ),
              ),
              const SizedBox(height: 20), // Add some spacing
              TableCalendar(
                firstDay: DateTime(2022),
                lastDay: DateTime(2025),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDate, selectedDay)) {
                    setState(() {
                      _selectedDate = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                selectedDayPredicate: (day) {
                  bool hasEvents =
                      mySelectedEvents[DateFormat('yyyy-MM-dd').format(day)] !=
                          null;
                  return isSameDay(_selectedDate, day) || hasEvents;
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Color(0xFFC6D3FF),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: redColor,
                    shape: BoxShape.circle,
                  ),
                  // Tambahkan dekorasi untuk hari yang memiliki event
                  markerDecoration: BoxDecoration(
                    color: Colors.white, // Warna untuk hari yang memiliki event
                    shape: BoxShape.circle,
                  ),
                  outsideDaysVisible: false,
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: GoogleFonts.sora(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: blueColor, // Set header text color
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ..._listOfDayEvents(_selectedDate!).map(
                (myEvents) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white, // Set event background color
                      borderRadius:
                          BorderRadius.circular(20), // Set border radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.adjust,
                        color: Color(0xff392AAB), // Set event icon color
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Tugas: " + myEvents['eventTitle'],
                          style: GoogleFonts.sora(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: blueColor // Set event title color
                              ),
                        ),
                      ),
                      subtitle: Text(
                        "Deskripsi: " + myEvents['description'],
                        style: GoogleFonts.sora(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: blackColor, // Set event description color
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEventDialog(),
        child: const Icon(
          Icons.add,
          color: whiteColor,
        ),
        backgroundColor: blueColor, // Set FAB background color
      ),
    );
  }

  // Rest of the code...

  _showAddEventDialog() async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Tambahkan Tugas",
          style: GoogleFonts.sora(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Judul Tugas",
                hintStyle: GoogleFonts.sora(),
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: "Deskripsi",
                hintStyle: GoogleFonts.sora(),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Batal",
              style: GoogleFonts.sora(
                color: Colors.red,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final eventTitle = titleController.text.trim();
              final description = descriptionController.text.trim();

              if (eventTitle.isEmpty || description.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Judul Tugas dan Deskripsi diperlukan.",
                    style: GoogleFonts.sora(),
                  ),
                  duration: Duration(seconds: 2),
                ));
                return;
              }

              final String formattedDate =
                  DateFormat('yyyy-MM-dd').format(_selectedDate!);
              if (mySelectedEvents[formattedDate] != null) {
                mySelectedEvents[formattedDate]!.add({
                  "eventTitle": eventTitle,
                  "description": description,
                });
              } else {
                mySelectedEvents[formattedDate] = [
                  {
                    "eventTitle": eventTitle,
                    "description": description,
                  }
                ];
              }

              try {
                await _profileCollection.doc(auth.currentUser!.uid).update({
                  "events": mySelectedEvents
                      .map((key, value) => MapEntry(key, value.toList())),
                });
                setState(() {});
              } catch (e) {
                print(e);
              }

              Navigator.of(context).pop();
            },
            child: Text(
              "Simpan",
              style: GoogleFonts.sora(
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  String _showWeekDay(int numDay) {
    Map<int, String> weekday = {
      1: "Senin",
      2: "Selasa",
      3: "Rabu",
      4: "Kamis",
      5: "Jumat",
      6: "Sabtu",
      7: "Minggu"
    };
    return weekday[numDay].toString();
  }

  String _showMonth(int numMonth) {
    Map<int, String> months = {
      1: "Januari",
      2: "Februari",
      3: "Maret",
      4: "April",
      5: "Mei",
      6: "Juni",
      7: "Juli",
      8: "Agustus",
      9: "September",
      10: "Oktober",
      11: "November",
      12: "Desember"
    };
    return months[numMonth].toString();
  }
}
