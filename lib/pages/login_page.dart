import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';
import '../services/api_service.dart';
import 'register_page.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }

  void _pesan(String teks) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(teks)));
  }

  Future<void> _masuk() async {
    if (_loading) return;

    final email = _emailC.text.trim();
    final pass = _passC.text;

    if (email.isEmpty || pass.isEmpty) {
      _pesan('Email dan kata sandi wajib diisi');
      return;
    }

    setState(() => _loading = true);
    final hasil = await ApiService.login(email, pass);
    if (!mounted) return;
    setState(() => _loading = false);

    if (hasil['status'] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      );
    } else {
      _pesan(hasil['message']?.toString() ?? 'Login gagal');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Study Flow',
      subtitle: 'Kelola tugas kuliahmu dalam satu tempat.',
      topSpace: 80,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Masuk', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        AppTextField(label: 'Email', hint: 'nama@email.com', controller: _emailC),
        AppTextField(label: 'Kata Sandi', hint: 'Masukkan kata sandi', obscure: true, controller: _passC),
        const SizedBox(height: 4),
        PrimaryButton(
          text: _loading ? 'Memproses...' : 'Masuk',
          onPressed: _masuk,
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