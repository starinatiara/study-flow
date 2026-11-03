import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';
import '../widgets/task_form.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const BackHeader('Edit Profil'),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const AppTextField(label: 'Sandi Lama', hint: 'Masukkan sandi lama', icon: Icons.lock, obscure: true),
              const AppTextField(label: 'Sandi Baru', hint: 'Minimal 8 karakter', icon: Icons.lock, obscure: true),
              const AppTextField(label: 'Konfirmasi Sandi Baru', hint: 'Ulangi sandi baru', icon: Icons.lock, obscure: true),
              AppTextField(
                label: 'Ubah Nama',
                hint: 'Masukkan nama baru',
                icon: Icons.person,
                controller: TextEditingController(text: 'Nama Pengguna'),
              ),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: PrimaryButton(text: 'Simpan Perubahan', onPressed: () => Navigator.pop(context)),
        ),
      ]),
    );
  }
}
