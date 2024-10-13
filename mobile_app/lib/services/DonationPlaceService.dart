import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/DonationPlace.dart';
import 'auth_service.dart'; // Certifique-se de que o modelo está implementado corretamente.

class DonationPlaceService {
  final String apiUrl = 'http://192.168.0.105:8080/DonationPlace'; // Coloque aqui o endpoint correto da sua API

  Future<List<DonationPlace>> fetchDonationPlaces() async {
    final token = await AuthService().getToken(); // Obtém o token JWT armazenado

    if (token == null) {
      throw Exception("Token JWT não encontrado. Por favor, faça login.");
    }

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Adiciona o token JWT no cabeçalho
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => DonationPlace.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar locais de doação: ${response.statusCode}');
    }
  }
}
