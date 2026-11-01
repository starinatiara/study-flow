import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../pages/add_task_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/history_page.dart';

/// current: 0 = Tambah, 1 = Home, 2 = Riwayat
class AppBottomNav extends StatelessWidget {
  final int current;
  const AppBottomNav({super.key, required this.current});

  void _go(BuildContext context, int i) {
    if (i == current) return;
    final pages = [const AddTaskPage(), const DashboardPage(), const HistoryPage()];
    Navigator.pushReplacement(context, PageRouteBuilder(
      pageBuilder: (_, __, ___) => pages[i],
      transitionDuration: Duration.zero,
    ));
  }

  Widget _item(BuildContext context, int i, IconData icon, String label) {
    final active = i == current;
    final home = i == 1;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _go(context, i),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: home ? 40 : 28, height: home ? 40 : 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: home ? (active ? AppColors.button : AppColors.yellow.withOpacity(.5)) : Colors.transparent,
            ),
            child: Icon(icon, size: 20, color: AppColors.dark),
          ),
          Text(label, style: TextStyle(fontSize: 9, fontWeight: active ? FontWeight.w800 : FontWeight.w400)),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      decoration: const BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, -2))],
      ),
      child: SafeArea(
        top: false,
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          _item(context, 0, Icons.add_circle_outline, 'Tambah'),
          _item(context, 1, Icons.home_rounded, 'Home'),
          _item(context, 2, Icons.check_circle_outline, 'Riwayat'),
        ]),
      ),
    );
  }
}