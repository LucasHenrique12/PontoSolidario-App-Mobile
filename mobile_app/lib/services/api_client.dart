import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ApiClient {
  final String _baseUrl = 'http://192.168.0.105:8080';
  final AuthService _authService = AuthService();

  // Método para fazer requisições GET autenticadas
  Future<http.Response> get(String endpoint) async {
    final token = await _authService.getToken();
    final url = Uri.parse('$_baseUrl/$endpoint');

    return http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  // Método para fazer requisições POST autenticadas
  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final token = await _authService.getToken();
    final url = Uri.parse('$_baseUrl/$endpoint');

    return http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
  }
}
