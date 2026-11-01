import 'package:flutter/material.dart';

class TambahTugasScreen extends StatelessWidget {
  const TambahTugasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tugas')),
      body: const Center(child: Text('Tambah Tugas (belum dikerjakan)')),
    );
  }
}