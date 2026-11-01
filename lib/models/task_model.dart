import 'package:flutter/material.dart';

class Task {
  final String title, course, date;
  final bool done, urgent;
  final Color tagBg, tagFg;
  const Task(this.title, this.course, this.date, this.done, this.tagBg, this.tagFg, {this.urgent = false});
}

// DATA DUMMY
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