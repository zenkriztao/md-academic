// <<<<<<< HEAD
import 'package:academic/size_config.dart';
import 'package:academic/views/calendar/calendar_screen.dart';
import 'package:academic/views/chatbot/chat_screen.dart';
import 'package:academic/views/chatbot_screen.dart';
import 'package:academic/views/comingsoon_scree.dart';
import 'package:academic/views/flashcards/screens/subject_screen.dart';
import 'package:academic/views/videos/video_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/images/icon/game.png", "text": "Permainan"},
      {"icon": "assets/images/icon/books.png", "text": "Baca Buku"},
      {"icon": "assets/images/icon/videos.png", "text": "Video"},
      {"icon": "assets/images/icon/bot.png", "text": "Chat Amy"},
    ];
    return Padding(
      padding: EdgeInsets.all(getScreenWidth(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              categories.length,
              (index) => CategoryCard(
                icon: categories[index]["icon"],
                text: categories[index]["text"],
                press: () {
                  if (categories[index]["text"] == "Permainan") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SubjectScreen()),
                    );
                  } else if (categories[index]["text"] == "Baca Buku") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComingSoonScreen(),
                      ),
                    );
                  } else if (categories[index]["text"] == "Video") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPage(),
                      ),
                    );
                  } else if (categories[index]["text"] == "Chat Amy") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatBotScreen(),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getScreenWidth(60), // Mengubah lebar container
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getScreenWidth(5)), // Mengubah padding
              height: getScreenWidth(50), // Mengubah tinggi container
              width: getScreenWidth(70), // Mengubah lebar container
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 234, 234, 234),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Color.fromARGB(255, 226, 233, 239),
                    width: 1,
                  )),
              child: Image.asset(
                icon!,
                height: 40,
              ),
            ),
            SizedBox(height: 10), // Mengubah jarak antara ikon dan teks
            Text(
              text!,
              style: GoogleFonts.sora(
                color: Color.fromARGB(255, 113, 113, 113),
                fontSize: 10, // Mengubah ukuran teks
                fontWeight: FontWeight.bold, // Menambah tebal pada teks
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
