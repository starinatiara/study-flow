import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'edit_profile_page.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget _info(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.grey)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
        ]),
      );

  Widget _menu(IconData icon, String text, {Color color = AppColors.dark, bool chevron = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: TextStyle(fontSize: 14, color: color))),
          if (chevron) const Icon(Icons.chevron_left, size: 20, color: AppColors.grey),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(children: [
        // Latar kuning di atas
        Container(height: 300, color: AppColors.yellow),
        SafeArea(
          child: Column(children: [
            // Tombol kembali
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(Icons.chevron_left, size: 28),
              ),
            ),
            // Avatar + nama (DUMMY)
            Container(
              width: 84, height: 84,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.person, size: 46, color: AppColors.dark),
            ),
            const SizedBox(height: 10),
            const Text('Nama Pengguna', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 2),
            const Text('nama@gmail.com', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 22),
            // Kartu biodata
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 12, offset: Offset(0, 4))],
                ),
                child: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Data Akun', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 18),
                    _info('Nama', 'Nama Pengguna'),
                    _info('Email', 'nama@gmail.com'),
                    _info('Sandi', '••••••••'),
                    const Divider(height: 28, color: Color(0xFFEEEEEE)),
                    _menu(
                      Icons.edit_outlined,
                      'Edit Profil',
                      chevron: true,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfilePage())),
                    ),
                    _menu(
                      Icons.logout,
                      'Logout',
                      color: AppColors.red,
                      onTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                        (route) => false,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
