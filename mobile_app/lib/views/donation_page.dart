import 'package:flutter/material.dart';
import '../models/donation.dart';
import '../services/DonationService.dart';
import '../services/auth_service.dart';


class DonationPage extends StatefulWidget {
  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  Future<List<Donation>>? futureDonations;

  @override
  void initState() {
    super.initState();
    _fetchDonations();
  }

  Future<void> _fetchDonations() async {
    String? userId = await AuthService().getUserIdFromToken();
    if (userId != null) {
      futureDonations = DonationService().getDonationsByUserId();
      setState(() {});
    } else {
      // Lidar com o caso em que o userId é nulo
      futureDonations = Future.error("Usuário não autenticado");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Doações'),
      ),
      body: FutureBuilder<List<Donation>>(
        future: futureDonations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar doações: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma doação encontrada.'));
          }

          // Exibindo as doações
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Donation donation = snapshot.data![index];
              return ListTile(
                title: Text('Data: ${donation.dataHora}'), // Exibe a data
                subtitle: Text('Tipo: ${donation.donationType} - Local: ${donation.donationPlaceId}'),
              );
            },
          );
        },
      ),
    );
  }
}
