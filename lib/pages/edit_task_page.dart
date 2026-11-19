import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/task_form.dart';
import '../models/task_model.dart';
import '../services/tugas_service.dart';

class EditTaskPage extends StatelessWidget {
  final Task task;
  const EditTaskPage({super.key, required this.task});

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 40, height: 40,
              decoration: const BoxDecoration(color: Color(0xFFFFE0DC), shape: BoxShape.circle),
              child: const Icon(Icons.delete_outline, size: 20, color: AppColors.red),
            ),
            const SizedBox(height: 12),
            const Text('Hapus tugas ini?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Text(
              'Tugas "${task.title}" akan dihapus dan tidak dapat dikembalikan.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: AppColors.grey),
            ),
            const SizedBox(height: 18),
            Row(children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.dark, minimumSize: const Size.fromHeight(40),
                    side: const BorderSide(color: Color(0xFFDDDDDD)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Batal', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    await TugasService.hapus(task.id);
                    if (!ctx.mounted) return;
                    Navigator.pop(ctx);
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red, foregroundColor: Colors.white, elevation: 0,
                    minimumSize: const Size.fromHeight(40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Hapus', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const BackHeader('Edit Tugas'),
        Expanded(
          child: TaskForm(
            title: task.title,
            course: task.course,
            deadline: Task.formatPanjang(task.deadline),
            catatan: task.catatan,
            done: task.done,
            saveText: 'Simpan Perubahan',
            onSave: (data) async {
              await TugasService.ubah(task, data);
              if (!context.mounted) return;
              Navigator.pop(context);
            },
              onDelete: () => _confirmDelete(context),
          ),
        ),
      ]),
    );
  }
}