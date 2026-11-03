import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =  'http://localhost/study_flow_api';

  static Future<Map<String, dynamic>> _post(
      String endpoint, Map<String, dynamic> body) async {
    try {
      final res = await http
          .post(
            Uri.parse('$baseUrl/$endpoint'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));
      return jsonDecode(res.body) as Map<String, dynamic>;
    } catch (e) {
      return {'status': false, 'message': 'Tidak bisa terhubung ke server'};
    }
  }

  static Future<Map<String, dynamic>> login(String email, String password) =>
      _post('login.php', {'email': email, 'password': password});

  static Future<Map<String, dynamic>> register(
          String nama, String email, String password) =>
      _post('register.php',
          {'nama': nama, 'email': email, 'password': password});
}
