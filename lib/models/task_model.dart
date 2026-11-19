import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Data yang diisi pengguna di form Tambah/Edit
class TaskFormData {
  final String judul, mataKuliah, catatan;
  final DateTime deadline;
  final bool selesai;
  const TaskFormData({
    required this.judul,
    required this.mataKuliah,
    required this.deadline,
    required this.catatan,
    required this.selesai,
  });
}

class Task {
  final String title, course, date;
  final bool done, urgent;
  final Color tagBg, tagFg;
  final String id, catatan;
  final DateTime? deadline;
  const Task(this.title, this.course, this.date, this.done, this.tagBg, this.tagFg,
      {this.urgent = false, this.id = '', this.deadline, this.catatan = ''});

  static const _palet = [
    [Color(0xFFDCE8FF), Color(0xFF2F5FB3)],
    [Color(0xFFFFD9E0), Color(0xFFC2185B)],
    [Color(0xFFCDEFF5), Color(0xFF0E7490)],
    [Color(0xFFE3D9FF), Color(0xFF6A3FC4)],
    [Color(0xFFCDEFD9), Color(0xFF2E7D5B)],
  ];

  static const _bulan = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
  static const _bulanPanjang = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];

  static String formatTanggal(DateTime? d) =>
      d == null ? '-' : '${d.day} ${_bulan[d.month - 1]}';

  // Format "25 November 2026", dibaca oleh TaskForm untuk halaman Edit
  static String formatPanjang(DateTime? d) =>
      d == null ? '' : '${d.day} ${_bulanPanjang[d.month - 1]} ${d.year}';

  factory Task.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data();
    final done = d['selesai'] == true;
    final deadline = (d['deadline'] as Timestamp?)?.toDate();
    final course = (d['mata_kuliah'] ?? '').toString();
    final warna = _palet[course.hashCode.abs() % _palet.length];
    final urgent = !done &&
        deadline != null &&
        deadline.difference(DateTime.now()).inDays <= 2;
    return Task(
      (d['judul'] ?? '').toString(),
      course,
      formatTanggal(deadline),
      done,
      warna[0],
      warna[1],
      urgent: urgent,
      id: doc.id,
      deadline: deadline,
      catatan: (d['catatan'] ?? '').toString(),
    );
  }
}

// DATA DUMMY (masih dipakai history_page)
const dummyTasks = [
  Task('Laporan Praktikum Basis Data', 'Basis Data', '23 Okt', false, Color(0xFFDCE8FF), Color(0xFF2F5FB3), urgent: true),
  Task('Proposal Project Flutter', 'Pemrograman Mobile', '25 Okt', false, Color(0xFFFFD9E0), Color(0xFFC2185B)),
  Task('Rangkuman Jurnal Keamanan', 'Keamanan Siber', '27 Okt', false, Color(0xFFCDEFF5), Color(0xFF0E7490)),
  Task('Tugas Analisis Dataset', 'Data Science', '19 Okt', true, Color(0xFFCDEFD9), Color(0xFF2E7D5B)),
];

const historyThisWeek = [
  Task('Tugas Analisis Dataset', 'Data Science', 'Selesai 19 Okt', true, Color(0xFFCDEFD9), Color(0xFF2E7D5B)),
  Task('Laporan Praktikum Cloud', 'Cloud Computing', 'Selesai 17 Okt', true, Color(0xFFE3D9FF), Color(0xFF6A3FC4)),
];

const historyBefore = [
  Task('Makalah Jaringan Komputer', 'Jaringan Komputer', 'Selesai 12 Okt', true, Color(0xFFCDEFD9), Color(0xFF2E7D5B)),
  Task('Kuis Pemrograman Web', 'Pemrograman Web', 'Selesai 8 Okt', true, Color(0xFFFFD9E0), Color(0xFFC2185B)),
];