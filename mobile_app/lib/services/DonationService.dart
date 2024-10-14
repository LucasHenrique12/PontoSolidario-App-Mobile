import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/donation.dart';

class DonationService {
  final String apiUrl = 'http://192.168.0.105:8080/donations';

  Future<List<Donation>> fetchDonationsByUserId(String userId, String token) async {

    final response = await http.get(
      Uri.parse('$apiUrl/user/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((donation) => Donation.fromJson(donation)).toList();
    } else {
      throw Exception('Failed to load donations');
    }
  }

  Future<List<Donation>> getDonationsByUserId() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token JWT não encontrado.');
    }


    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String userId = decodedToken['userId'];

    // Fazendo a chamada para o endpoint
    final response = await http.get(
      Uri.parse('$apiUrl/user/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((donation) => Donation.fromJson(donation)).toList();
    } else {
      throw Exception('Erro ao buscar as doações: ${response.statusCode}');
    }
  }
}