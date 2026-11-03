  import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';
import 'register_page.dart';
import 'dashboard_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Study Flow',
      subtitle: 'Kelola tugas kuliahmu dalam satu tempat.',
      topSpace: 80,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Masuk', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        const AppTextField(label: 'Email', hint: 'nama@email.com'),
        const AppTextField(label: 'Kata Sandi', hint: 'Masukkan kata sandi', obscure: true),
        const SizedBox(height: 4),
        PrimaryButton(
          text: 'Masuk',
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardPage())),
        ),
        const SizedBox(height: 14),
        Center(
          child: GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())),
            child: const Text.rich(TextSpan(style: TextStyle(fontSize: 11), children: [
              TextSpan(text: 'Belum punya akun? '),
              TextSpan(text: 'Daftar', style: TextStyle(fontWeight: FontWeight.w800, decoration: TextDecoration.underline)),
            ])),
          ),
        ),
      ]),
    );
  }
}