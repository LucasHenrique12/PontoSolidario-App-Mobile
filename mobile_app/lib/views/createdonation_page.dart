import 'package:flutter/material.dart';
import '../models/DonationPlace.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_page.dart';

class CreateDonationPage extends StatefulWidget {
  final DonationPlace donationPlace;

  CreateDonationPage({required this.donationPlace});

  @override
  _CreateDonationPageState createState() => _CreateDonationPageState();
}

class _CreateDonationPageState extends State<CreateDonationPage> {
  String? selectedDonationType;

  List<String> donationTypes = ['Roupa', 'Alimento', 'Ração'];

  // Função para realizar a doação
  Future<void> _donate() async {
   /*  if (selectedDonationType == null) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Por favor, selecione um tipo de doação."),
      ));
      return;
    }


    var donationData = {
      "donationPlaceId": widget.donationPlace.id,
      "donationType": selectedDonationType,

      "userId": "id_do_usuario_autenticado"
    };

    var response = await http.post(
      Uri.parse('https://suaapi.com/donations/createDonations'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(donationData),
    );

    if (response.statusCode == 201) {
      // Doação bem-sucedida: exibir popup e redirecionar para homepage
      _showSuccessDialog();
    } else {
      // Exibir mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Erro ao registrar doação."),
      ));
    }*/
  }


  Future<void> _showSuccessDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sucesso!"),
          content: Text("Doação realizada com sucesso."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToHomePage();
              },
            ),
          ],
        );
      },
    );
  }

  // Redirecionar para a homepage
  void _navigateToHomePage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Realizar Doação"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selecione o tipo de doação:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            for (var type in donationTypes)
              RadioListTile<String>(
                title: Text(type),
                value: type,
                groupValue: selectedDonationType,
                onChanged: (value) {
                  setState(() {
                    selectedDonationType = value;
                  });
                },
              ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _donate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Confirmar Doação',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
