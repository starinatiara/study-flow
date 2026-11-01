import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'common_widgets.dart';

/// Form dipakai bersama oleh halaman Tambah & Edit Tugas
class TaskForm extends StatefulWidget {
  final String title, course, deadline;
  final bool done;
  final String saveText;
  final VoidCallback onSave;
  final VoidCallback? onDelete;
  const TaskForm({
    super.key, this.title = '', this.course = '', this.deadline = '', this.done = false,
    required this.saveText, required this.onSave, this.onDelete,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late bool done = widget.done;
  late final _title = TextEditingController(text: widget.title);
  late final _course = TextEditingController(text: widget.course);
  late final _deadline = TextEditingController(text: widget.deadline);

  Widget _status(String text, bool value) {
    final active = done == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => done = value),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? AppColors.button : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: active ? AppColors.button : AppColors.border),
          ),
          child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AppTextField(label: 'Judul Tugas', hint: 'Contoh: Laporan Praktikum', controller: _title),
            AppTextField(label: 'Mata Kuliah', hint: 'Pilih mata kuliah', controller: _course),
            AppTextField(label: 'Deadline', hint: 'Pilih tanggal', controller: _deadline),
            const AppTextField(label: 'Catatan', hint: 'Opsional', multiline: true),
            const Text('Status Pengerjaan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Row(children: [_status('Belum Selesai', false), const SizedBox(width: 10), _status('Selesai', true)]),
          ]),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Column(children: [
          PrimaryButton(text: widget.saveText, onPressed: widget.onSave),
          if (widget.onDelete != null) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity, height: 44,
              child: OutlinedButton(
                onPressed: widget.onDelete,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.red, backgroundColor: Colors.white,
                  side: const BorderSide(color: AppColors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Hapus Tugas', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
              ),
            ),
          ],
        ]),
      ),
    ]);
  }
}

/// Header kuning dengan tombol kembali
class BackHeader extends StatelessWidget {
  final String title;
  const BackHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12, MediaQuery.of(context).padding.top + 14, 12, 18),
      decoration: const BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Row(children: [
        GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: const Padding(padding: EdgeInsets.all(6), child: Icon(Icons.chevron_left, size: 24)),
        ),
        const SizedBox(width: 4),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
      ]),
    );
  }
}