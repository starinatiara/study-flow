import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'pages/login_page.dart';

void main() => runApp(const StudyFlowApp());

class StudyFlowApp extends StatelessWidget {
  const StudyFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.cream,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.button),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}