import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/app_colors.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/common_widgets.dart';
import 'edit_task_page.dart';
import 'profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int filter = 0; // 0 semua, 1 belum, 2 selesai
  final filters = const ['Semua', 'Belum Selesai', 'Selesai'];

  List<Task> get tasks => dummyTasks.where((t) => filter == 0 || (filter == 1 ? !t.done : t.done)).toList();

  Widget _progressCard() => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Progres', style: TextStyle(fontSize: 9, color: AppColors.grey)),
          const SizedBox(height: 2),
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('2 dari 5 tugas selesai', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
            Text('40%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          ]),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const LinearProgressIndicator(value: .4, minHeight: 6, backgroundColor: Color(0xFFF1EAD0), color: AppColors.button),
          ),
        ]),
      );

  Widget _chip(int i) {
    final active = filter == i;
    return GestureDetector(
      onTap: () => setState(() => filter = i),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.button : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: active ? AppColors.button : AppColors.border),
        ),
        child: Text(filters[i], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _taskCard(Task t) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditTaskPage())),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14),
          boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 6, offset: Offset(0, 2))],
        ),
        child: Row(children: [
          t.done
              ? Container(
                  width: 22, height: 22,
                  decoration: const BoxDecoration(color: AppColors.green, shape: BoxShape.circle),
                  child: const Icon(Icons.check, size: 14, color: Colors.white))
              : Container(
                  width: 22, height: 22,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.dark, width: 1.5))),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(t.title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, decoration: t.done ? TextDecoration.lineThrough : null)),
              const SizedBox(height: 4),
              Row(children: [
                TagChip(t.course, t.tagBg, t.tagFg),
                const SizedBox(width: 6),
                Text(t.date, style: TextStyle(fontSize: 9, fontWeight: t.urgent ? FontWeight.w700 : FontWeight.w400, color: t.urgent ? AppColors.red : AppColors.grey)),
              ]),
            ]),
          ),
          TagChip(t.done ? 'Selesai' : 'Belum', t.done ? const Color(0xFFCDEFD9) : const Color(0xFFEFE6CC), t.done ? AppColors.green : AppColors.dark),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 14, 20, 16),
          decoration: const BoxDecoration(color: AppColors.yellow, borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Study Flow', style: TextStyle(fontSize: 10)),
                  Text('Tugas Saya', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                ]),
              ),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage())),
                child: Container(
                  width: 38, height: 38,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.person, size: 22, color: AppColors.dark),
                ),
              ),
            ]),
            const SizedBox(height: 12),
            _progressCard(),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
          child: Row(children: List.generate(3, _chip)),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: tasks.map(_taskCard).toList(),
          ),
        ),
      ]),
      bottomNavigationBar: const AppBottomNav(current: 1),
    );
  }
}
