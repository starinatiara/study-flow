import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';

class TugasService {
  static final _col = FirebaseFirestore.instance.collection('tugas');

  static Stream<List<Task>> daftar() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return Stream.value([]);
    return _col.where('user_id', isEqualTo: uid).snapshots().map((snap) {
      final list = snap.docs.map(Task.fromDoc).toList();
      list.sort((a, b) {
        if (a.deadline == null) return 1;
        if (b.deadline == null) return -1;
        return a.deadline!.compareTo(b.deadline!);
      });
      return list;
    });
  }

  static Future<void> tambah(TaskFormData d) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('Belum login');
    return _col.add({
      'user_id': uid,
      'judul': d.judul,
      'mata_kuliah': d.mataKuliah,
      'deadline': Timestamp.fromDate(d.deadline),
      'catatan': d.catatan.isEmpty ? null : d.catatan,
      'selesai': d.selesai,
      'tanggal_selesai': d.selesai ? Timestamp.now() : null,
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> ubah(Task lama, TaskFormData d) {
    final data = <String, dynamic>{
      'judul': d.judul,
      'mata_kuliah': d.mataKuliah,
      'deadline': Timestamp.fromDate(d.deadline),
      'catatan': d.catatan.isEmpty ? null : d.catatan,
      'selesai': d.selesai,
    };
    if (!d.selesai) {
      data['tanggal_selesai'] = null;
    } else if (!lama.done) {
      data['tanggal_selesai'] = Timestamp.now();
    }
    return _col.doc(lama.id).update(data);
  }

  static Future<void> hapus(String id) => _col.doc(id).delete();
}