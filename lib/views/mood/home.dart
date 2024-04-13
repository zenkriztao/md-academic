import 'package:academic/theme.dart';
import 'package:academic/views/mood/edit.dart';
import 'package:academic/views/mood/settings.dart';
import 'package:academic/widgets/calendar.dart';
import 'package:academic/widgets/list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:academic/controllers/list_controller.dart';
import 'package:academic/models/rating.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  // pindahkan ke file terpisah
  RatingListController controller = RatingListController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      Calendar(),
      RatingList(controller: controller),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journaling',
          style: GoogleFonts.sora(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () async {
              bool refresh = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
              if (refresh == true) {
                setState(() {});
              }
            },
          ),
        ],
        backgroundColor: const Color(0xFF4285F4), // Warna biru
      ),
      body: children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          if (index == 1) {
            controller.pagingController = PagingController<int, Rating>(
              firstPageKey: 0,
            );
          }
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Kalender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: 'Daftar',
          ),
        ],
        selectedItemColor: const Color(0xFF4285F4), // Warna biru
        unselectedItemColor: const Color(0xFFBDBDBD), // Warna abu-abu
        backgroundColor: const Color(0xFFF5F5F5), // Warna putih
      ),
    );
  }
}
