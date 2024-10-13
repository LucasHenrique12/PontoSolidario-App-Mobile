import 'package:flutter/material.dart';
import '../models/DonationPlace.dart';
import '../services/DonationPlaceService.dart';
import '../services/auth_service.dart';
import 'DonationPlaceDetails.dart';
// Supondo que esse é o seu serviço de autenticação para o logout

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<DonationPlace>> futureDonationPlaces;

  @override
  void initState() {
    super.initState();
    futureDonationPlaces = DonationPlaceService().fetchDonationPlaces(); // Busca os locais de doação
  }

  // Função que atualiza os locais de doação
  Future<void> _refreshDonationPlaces() async {
    setState(() {
      futureDonationPlaces = DonationPlaceService().fetchDonationPlaces();
    });
  }

  // Função para fazer logout
  void _logout() async {
    await AuthService().logout(); // Função de logout no seu AuthService
    Navigator.of(context).pushReplacementNamed('/'); // Navegar para a tela de login após o logout
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locais de Doação'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pop(); // Fechar o drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              onTap: _logout, // Chama a função de logout
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<DonationPlace>>(
        future: futureDonationPlaces,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum local de doação encontrado.'));
          } else if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: _refreshDonationPlaces,  // Função para atualizar os dados
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final donationPlace = snapshot.data![index];
                  return ListTile(
                    title: Text(donationPlace.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DonationPlaceDetails(
                            donationPlace: donationPlace,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return Center(child: Text('Algo deu errado.'));
          }
        },
      ),
    );
  }
}
