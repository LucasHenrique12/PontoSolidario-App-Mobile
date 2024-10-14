import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/DonationPlace.dart';
import 'auth_service.dart';

class DonationPlaceService {
  final String apiUrl = 'http://192.168.0.105:8080/DonationPlace';

  Future<List<DonationPlace>> fetchDonationPlaces() async {
    final token = await AuthService().getToken();

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

  Future<List<DonationPlace>> fetchDonationPlacesByType(String donationTypeId) async {
    final token = await AuthService().getToken();

    if (token == null) {
      throw Exception("Token JWT não encontrado. Por favor, faça login.");
    }
    final response = await http.get(
      Uri.parse('$apiUrl/filterType/$donationTypeId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Adicione aqui o token de autenticação
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((place) => DonationPlace.fromJson(place)).toList();
    } else {
      print('Erro ao buscar dados: ${response.statusCode}, ${response.body}'); // Adicione essa linha para depuração
      throw Exception('Erro ao buscar locais de doação:  ${response.statusCode}');
    }
  }

}

