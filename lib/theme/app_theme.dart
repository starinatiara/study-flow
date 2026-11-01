import 'package:flutter/material.dart';

class AppTheme {
  // Warna dari mockup (perkiraan, sesuaikan dengan kode warna di Figma)
  static const Color kuning = Color(0xFFF7C242);
  static const Color kuningMuda = Color(0xFFF8E07A);
  static const Color krem = Color(0xFFFFF9E8);
  static const Color hijau = Color(0xFF5B8A50);
  static const Color oranye = Color(0xFFFF8A65);
  static const Color merah = Color(0xFFC62828);
  static const Color teks = Color(0xFF2B2B2B);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: krem,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kuning,
          primary: kuning,
          onPrimary: teks,
          surface: krem,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: kuningMuda,
          foregroundColor: teks,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kuning,
            foregroundColor: teks,
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      );
}