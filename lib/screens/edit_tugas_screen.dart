import 'package:flutter/material.dart';

class EditTugasScreen extends StatelessWidget {
  const EditTugasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Tugas')),
      body: const Center(child: Text('Edit Tugas (belum dikerjakan)')),
    );
  }
}