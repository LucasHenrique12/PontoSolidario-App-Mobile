import 'package:flutter/material.dart';
import '../components/drawer_custom.dart';
import '../models/DonationPlace.dart';
import '../services/DonationPlaceService.dart';
import '../services/auth_service.dart';
import '../services/filter_dialog.dart';
import 'DonationPlaceDetails.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<DonationPlace>> futureDonationPlaces;
  String? selectedDonationTypeId;

  @override
  void initState() {
    super.initState();
    futureDonationPlaces = DonationPlaceService().fetchDonationPlaces();
  }

  Future<void> _refreshDonationPlaces() async {
    setState(() {
      futureDonationPlaces = DonationPlaceService().fetchDonationPlaces();
    });
  }

  Future<void> _filterDonationPlaces(String donationTypeId) async {
    setState(() {
      selectedDonationTypeId = donationTypeId;
      futureDonationPlaces = DonationPlaceService().fetchDonationPlacesByType(donationTypeId);
    });
  }

  void _showFilterDialog() {
    FilterDialog.showFilterDialog(
      context,
      selectedDonationTypeId,
      _filterDonationPlaces,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locais de Doação', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.teal, // Cor personalizada
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, size: 30),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      drawer: CustomDrawer(),

      body: FutureBuilder<List<DonationPlace>>(
        future: futureDonationPlaces,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.teal),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}', style: TextStyle(fontSize: 18, color: Colors.red)));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum local de doação encontrado.', style: TextStyle(fontSize: 18)));
          } else if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: _refreshDonationPlaces,
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final donationPlace = snapshot.data![index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8), // Espaçamento entre os cartões
                    child: ListTile(
                      title: Text(donationPlace.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      subtitle: Text('Clique para detalhes', style: TextStyle(color: Colors.grey[600])),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DonationPlaceDetails(donationPlace: donationPlace),
                          ),
                        );
                      },
                    ),
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
