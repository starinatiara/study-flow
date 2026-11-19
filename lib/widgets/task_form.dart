import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/app_colors.dart';
import 'common_widgets.dart';

/// Form dipakai bersama oleh halaman Tambah & Edit Tugas
class TaskForm extends StatefulWidget {
  final String title, course, deadline, catatan;
  final bool done;
  final String saveText;
  final Future<void> Function(TaskFormData data) onSave;
  final VoidCallback? onDelete;
  const TaskForm({
    super.key, this.title = '', this.course = '', this.deadline = '', this.catatan = '', this.done = false,
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
  late final _catatan = TextEditingController(text: widget.catatan);
  DateTime? _date;
  bool _saving = false;

  static const _bulan = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];

  @override
  void initState() {
    super.initState();
    // Baca tanggal awal (contoh: "25 Oktober 2026") untuk halaman Edit
    final parts = widget.deadline.split(' ');
    if (parts.length == 3) {
      final m = _bulan.indexOf(parts[1]);
      final d = int.tryParse(parts[0]);
      final y = int.tryParse(parts[2]);
      if (m != -1 && d != null && y != null) _date = DateTime(y, m + 1, d);
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _course.dispose();
    _deadline.dispose();
    _catatan.dispose();
    super.dispose();
  }

  void _pesan(String teks) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(teks)));
  }

  Future<void> _simpan() async {
    if (_saving) return;
    final judul = _title.text.trim();
    final course = _course.text.trim();
    if (judul.isEmpty || course.isEmpty || _date == null) {
      _pesan('Judul, mata kuliah, dan deadline wajib diisi');
      return;
    }
    setState(() => _saving = true);
    try {
      await widget.onSave(TaskFormData(
        judul: judul,
        mataKuliah: course,
        deadline: _date!,
        catatan: _catatan.text.trim(),
        selesai: done,
      ));
    } catch (e) {
      if (mounted) _pesan('Gagal menyimpan: $e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    DateTime temp = _date ?? now;
    final picked = await showDialog<DateTime>(
      context: context,
      builder: (ctx) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.button, onPrimary: AppColors.dark, onSurface: AppColors.dark),
        ),
        child: Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                height: 300,
                child: CalendarDatePicker(
                  initialDate: temp,
                  firstDate: DateTime(now.year - 1),
                  lastDate: DateTime(now.year + 5),
                  onDateChanged: (d) => temp = d,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Batal', style: TextStyle(color: AppColors.dark)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, temp),
                    child: const Text('Pilih', style: TextStyle(color: AppColors.dark, fontWeight: FontWeight.w800)),
                  ),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
    if (picked != null) {
      setState(() {
        _date = DateTime(picked.year, picked.month, picked.day);
        _deadline.text = '${picked.day} ${_bulan[picked.month - 1]} ${picked.year}';
      });
    }
  }

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
            AppTextField(
              label: 'Deadline',
              hint: 'Pilih tanggal',
              controller: _deadline,
              readOnly: true,
              onTap: _pickDate,
              suffixIcon: Icons.calendar_today_outlined,
            ),
            AppTextField(label: 'Catatan', hint: 'Opsional', multiline: true, controller: _catatan),
            const Text('Status Pengerjaan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Row(children: [_status('Belum Selesai', false), const SizedBox(width: 10), _status('Selesai', true)]),
          ]),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Column(children: [
          PrimaryButton(text: _saving ? 'Menyimpan...' : widget.saveText, onPressed: _simpan),
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