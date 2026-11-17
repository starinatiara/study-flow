import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<Map<String, dynamic>> register(
      String nama, String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await cred.user?.updateDisplayName(nama);
      // Daftar otomatis membuat pengguna login, jadi keluarkan dulu
      // supaya alurnya kembali ke halaman Login.
      await _auth.signOut();
      return {'status': true, 'message': 'Registrasi berhasil'};
    } on FirebaseAuthException catch (e) {
      return {'status': false, 'message': _pesan(e.code)};
    } catch (e) {
      return {'status': false, 'message': 'Terjadi kesalahan, coba lagi'};
    }
  }

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {
        'status': true,
        'message': 'Login berhasil',
        'data': {
          'id': cred.user?.uid,
          'nama': cred.user?.displayName,
          'email': cred.user?.email,
        },
      };
    } on FirebaseAuthException catch (e) {
      return {'status': false, 'message': _pesan(e.code)};
    } catch (e) {
      return {'status': false, 'message': 'Terjadi kesalahan, coba lagi'};
    }
  }

  static Future<void> logout() => _auth.signOut();

  static String _pesan(String kode) {
    switch (kode) {
      case 'email-already-in-use':
        return 'Email sudah terdaftar';
      case 'invalid-email':
        return 'Format email tidak valid';
      case 'weak-password':
        return 'Kata sandi terlalu lemah';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Email atau kata sandi salah';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan, coba lagi nanti';
      case 'network-request-failed':
        return 'Tidak ada koneksi internet';
      case 'operation-not-allowed':
        return 'Login email/sandi belum diaktifkan di Firebase';
      default:
        return 'Terjadi kesalahan ($kode)';
    }
  }
}