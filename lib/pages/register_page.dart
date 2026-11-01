import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Daftar Akun',
      subtitle: 'Buat akun baru untuk mulai mengelola\ntugasmu dengan lebih mudah',
      topSpace: 50,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const AppTextField(label: 'Nama Lengkap', hint: 'Masukkan nama lengkap', icon: Icons.person),
        const AppTextField(label: 'Email', hint: 'nama@gmail.com', icon: Icons.mail),
        const AppTextField(label: 'Kata Sandi', hint: 'Minimal 8 karakter', icon: Icons.lock, obscure: true),
        const AppTextField(label: 'Konfirmasi Kata Sandi', hint: 'Ulangi kata sandi', icon: Icons.lock, obscure: true),
        const SizedBox(height: 10),
        PrimaryButton(text: 'Daftar', onPressed: () => Navigator.pop(context)),
        const SizedBox(height: 14),
        Center(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Text.rich(TextSpan(style: TextStyle(fontSize: 11), children: [
              TextSpan(text: 'Sudah punya akun? '),
              TextSpan(text: 'Masuk', style: TextStyle(fontWeight: FontWeight.w800, decoration: TextDecoration.underline)),
            ])),
          ),
        ),
      ]),
    );
  }
}