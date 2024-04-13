import 'package:academic/views/mood/advanced_settings.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:google_fonts/google_fonts.dart';
import 'package:academic/controllers/settings_controller.dart';
import 'package:academic/models/color_palette.dart';
import 'package:academic/models/theme_mode_extension.dart';
import 'package:academic/services/settings.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsController settingsController = SettingsController();

  @override
  Widget build(BuildContext context) {
    bool pengingatenable = SettingsService.getReminderEnabled();
    ThemeMode tema = SettingsService.getThemeMode();
    ColorPalette palette = SettingsService.getColorPalette();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengaturan',
          style: GoogleFonts.sora(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context, settingsController.didChangePalette);
          },
        ),
        backgroundColor: const Color(0xFF4285F4), // Warna biru
      ),
      body: ListView(
        children: [
          // pengaturan pengingat harian
          ExpansionTile(
            title: Text(
              'Pengingat Harian',
              style: GoogleFonts.sora(
                color: const Color(0xFF4285F4), // Warna biru
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              pengingatenable == true
                  ? settingsController.formatTime(context)
                  : 'Nonaktif',
              style: GoogleFonts.sora(
                color: const Color(0xFF4285F4), // Warna biru
              ),
            ),
            children: [
              // sakelar pengaktif pengingat
              ListTile(
                title: Text(
                  'Aktifkan Pengingat',
                  style: GoogleFonts.sora(),
                ),
                trailing: Switch(
                  value: pengingatenable,
                  activeColor: const Color(0xFF34A853), // Warna hijau
                  onChanged: (value) {
                    setState(() {
                      settingsController.setReminderEnabled(value);
                    });
                  },
                ),
              ),
              // pemilihan waktu pengingat
              ListTile(
                title: Text(
                  'Waktu Pengingat',
                  style: GoogleFonts.sora(),
                ),
                trailing: Text(
                  settingsController.formatTime(context),
                  style: GoogleFonts.sora(
                    color: const Color(0xFF4285F4), // Warna biru
                  ),
                ),
                enabled: pengingatenable,
                onTap: () {
                  setState(() {
                    settingsController.selectReminderTime(context, setState);
                  });
                },
              ),
            ],
          ),
          // pemilihan palet warna
          ExpansionTile(
            title: Text(
              'Palet Warna',
              style: GoogleFonts.sora(
                color: const Color(0xFF4285F4), // Warna biru
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              palette.name,
              style: GoogleFonts.sora(
                color: const Color(0xFF4285F4), // Warna biru
              ),
            ),
            children: [
              // palet klasik
              RadioListTile(
                title: Text(
                  'Klasik',
                  style: GoogleFonts.sora(),
                ),
                value: ColorPalette.classic,
                groupValue: palette,
                onChanged: (value) {
                  setState(() {
                    settingsController.setPalette(value!);
                  });
                },
              ),
              // palet terang
              RadioListTile(
                title: Text(
                  'Terang',
                  style: GoogleFonts.sora(),
                ),
                value: ColorPalette.light,
                groupValue: palette,
                onChanged: (value) {
                  setState(() {
                    settingsController.setPalette(value!);
                  });
                },
              ),
              // palet gelap
              RadioListTile(
                title: Text(
                  'Gelap',
                  style: GoogleFonts.sora(),
                ),
                value: ColorPalette.dark,
                groupValue: palette,
                onChanged: (value) {
                  setState(() {
                    settingsController.setPalette(value!);
                  });
                },
              ),
              // palet hijau
              RadioListTile(
                title: Text(
                  'Hijau',
                  style: GoogleFonts.sora(),
                ),
                value: ColorPalette.green,
                groupValue: palette,
                onChanged: (value) {
                  setState(() {
                    settingsController.setPalette(value!);
                  });
                },
              ),
              // palet biru
              RadioListTile(
                title: Text(
                  'Biru',
                  style: GoogleFonts.sora(),
                ),
                value: ColorPalette.blue,
                groupValue: palette,
                onChanged: (value) {
                  setState(() {
                    settingsController.setPalette(value!);
                  });
                },
              ),
              // palet ungu
              RadioListTile(
                title: Text(
                  'Ungu',
                  style: GoogleFonts.sora(),
                ),
                value: ColorPalette.purple,
                groupValue: palette,
                onChanged: (value) {
                  setState(() {
                    settingsController.setPalette(value!);
                  });
                },
              ),
            ],
          ),
          // pemilihan tema
          ExpansionTile(
            title: Text(
              'Tema',
              style: GoogleFonts.sora(
                color: const Color(0xFF4285F4), // Warna biru
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              tema.prettyName,
              style: GoogleFonts.sora(
                color: const Color(0xFF4285F4), // Warna biru
              ),
            ),
            children: [
              // tema default sistem
            ],
          ),
          const SizedBox(height: 20),
          // tombol kirim umpan balik -> membuka aplikasi email
        ],
      ),
    );
  }
}
