import 'package:flutter/material.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/task_form.dart';
import 'dashboard_page.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const BackHeader('Tambah Tugas'),
        Expanded(
          child: TaskForm(
            saveText: 'Simpan Tugas',
            onSave: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardPage())),
          ),
        ),
      ]),
      bottomNavigationBar: const AppBottomNav(current: 0),
    );
  }
}