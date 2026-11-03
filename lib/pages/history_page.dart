import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/app_colors.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/common_widgets.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  // Semua tugas selesai dalam satu daftar (terbaru di atas), tanpa pengelompokan
  List<Task> get _items => [...historyThisWeek, ...historyBefore];

  Widget _item(Task t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Row(children: [
        Container(
          width: 20, height: 20,
          decoration: const BoxDecoration(color: AppColors.green, shape: BoxShape.circle),
          child: const Icon(Icons.check, size: 13, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t.title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Row(children: [
              TagChip(t.course, t.tagBg, t.tagFg),
              const SizedBox(width: 6),
              Text(t.date, style: const TextStyle(fontSize: 8, color: AppColors.green, fontWeight: FontWeight.w600)),
            ]),
          ]),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 14, 20, 22),
          decoration: const BoxDecoration(color: AppColors.yellow, borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))),
          child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Study Flow', style: TextStyle(fontSize: 10)),
            Text('Riwayat Tugas', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            Text('Tugas yang sudah kamu selesaikan', style: TextStyle(fontSize: 10)),
          ]),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            children: _items.map(_item).toList(),
          ),
        ),
      ]),
      bottomNavigationBar: const AppBottomNav(current: 2),
    );
  }
}