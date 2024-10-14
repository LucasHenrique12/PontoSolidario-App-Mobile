import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_app/models/user.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
class AuthService {
  final String _baseUrl = 'http://192.168.0.105:8080';


  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];


      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return true;
    } else {
      return false;
    }
  }


  Future<bool> register(User user) async {
    var url = Uri.parse('$_baseUrl/auth/register');

    try {
      var response = await http.post(
        url,
        body: jsonEncode(user.toJson()),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final token = responseBody['token'];


        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Erro ao registrar: $e');
      return false;
    }
  }


  Future<String?> getUserIdFromToken() async {
    String? token = await getToken();
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return decodedToken['id'];
    }
    return null;
  }


  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }


  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}
