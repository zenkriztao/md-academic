import 'package:academic/controllers/navigation_controller.dart';
import 'package:academic/controllers/theme_controller.dart';
import 'package:academic/theme.dart';
import 'package:academic/views/article/behavior_dictionary.dart';
import 'package:academic/views/calendar/calendar_screen.dart';
import 'package:academic/views/home_screen.dart';
import 'package:academic/views/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

  final screen = [
    const HomeScreen(),
    const CalendarScreen(),
    const BehaviorDictionaryPage(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeController _themeController = Get.find<ThemeController>();
    final ColorController _colorController = Get.put(ColorController());
    return Obx(
      () => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            hoverColor: blueColor,
            onPressed: () => Get.to(const CalendarScreen()),
            child: Image.asset("assets/images/icon/sos.png"),
          ),
        ),
        backgroundColor: bottomNavigationController.selectedIndex.value == 0 ||
                bottomNavigationController.selectedIndex.value == 1
            ? _colorController.getActivityBackgroundColor()
            : _colorController.getBackgroundColor(),
        body: IndexedStack(
          index: bottomNavigationController.selectedIndex.value,
          children: screen,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Color(0x26000000), spreadRadius: 0, blurRadius: 15),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Obx(
              () => SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
                child: BottomNavigationBar(
                  elevation: 0.0,
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/icon/home.png',
                        width: 28,
                      ),
                      activeIcon: Image.asset(
                        'assets/images/icon/home_active.png',
                        width: 28,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/images/icon/calendar.png',
                          width: 28),
                      activeIcon: Image.asset(
                          'assets/images/icon/calendar_active.png',
                          width: 28),
                      label: 'Calendar',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/images/icon/activities.png',
                          width: 28),
                      activeIcon: Image.asset(
                          'assets/images/icon/activities_active.png',
                          width: 28),
                      label: 'Activity',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                          'assets/images/icon/settings_active.png',
                          width: 28),
                      activeIcon: Image.asset('assets/images/icon/settings.png',
                          width: 28),
                      label: 'Settings',
                    ),
                  ],
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  currentIndex: bottomNavigationController.selectedIndex.value,
                  selectedItemColor: const Color(0xff157FFB),
                  onTap: (index) =>
                      bottomNavigationController.changeIndex(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
