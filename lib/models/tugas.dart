class Tugas {
  final int id;
  String judul;
  String mataKuliah;
  String deadline;
  String catatan;
  bool selesai;

  Tugas({
    required this.id,
    required this.judul,
    required this.mataKuliah,
    required this.deadline,
    this.catatan = '',
    this.selesai = false,
  });
}