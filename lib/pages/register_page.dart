import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';
import '../services/api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _namaC = TextEditingController();
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  final _konfirmC = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _namaC.dispose();
    _emailC.dispose();
    _passC.dispose();
    _konfirmC.dispose();
    super.dispose();
  }

  void _pesan(String teks) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(teks)));
  }

  Future<void> _daftar() async {
    if (_loading) return;

    final nama = _namaC.text.trim();
    final email = _emailC.text.trim();
    final pass = _passC.text;
    final konfirm = _konfirmC.text;

    if (nama.isEmpty || email.isEmpty || pass.isEmpty || konfirm.isEmpty) {
      _pesan('Semua kolom wajib diisi');
      return;
    }
    if (!email.contains('@')) {
      _pesan('Format email tidak valid');
      return;
    }
    if (pass.length < 8) {
      _pesan('Kata sandi minimal 8 karakter');
      return;
    }
    if (pass != konfirm) {
      _pesan('Kata sandi dan konfirmasi tidak sama');
      return;
    }

    setState(() => _loading = true);
    final hasil = await ApiService.register(nama, email, pass);
    if (!mounted) return;
    setState(() => _loading = false);

    _pesan(hasil['message']?.toString() ?? 'Terjadi kesalahan');
    if (hasil['status'] == true) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Daftar Akun',
      subtitle: 'Buat akun baru untuk mulai mengelola\ntugasmu dengan lebih mudah',
      topSpace: 50,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppTextField(label: 'Nama Lengkap', hint: 'Masukkan nama lengkap', icon: Icons.person, controller: _namaC),
        AppTextField(label: 'Email', hint: 'nama@gmail.com', icon: Icons.mail, controller: _emailC),
        AppTextField(label: 'Kata Sandi', hint: 'Minimal 8 karakter', icon: Icons.lock, obscure: true, controller: _passC),
        AppTextField(label: 'Konfirmasi Kata Sandi', hint: 'Ulangi kata sandi', icon: Icons.lock, obscure: true, controller: _konfirmC),
        const SizedBox(height: 10),
        PrimaryButton(
          text: _loading ? 'Memproses...' : 'Daftar',
          onPressed: _daftar,
        ),
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