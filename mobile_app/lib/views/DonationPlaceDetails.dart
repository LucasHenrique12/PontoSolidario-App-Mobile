import 'package:flutter/material.dart';
import 'package:mobile_app/views/createdonation_page.dart';
import '../models/DonationPlace.dart';


class DonationPlaceDetails extends StatelessWidget {
  final DonationPlace donationPlace;

  DonationPlaceDetails({required this.donationPlace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(donationPlace.name),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Endereço:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              donationPlace.address,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Text(
              'Coordenadas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Latitude: ${donationPlace.latitude}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 4),
            Text(
              'Longitude: ${donationPlace.longitude}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Text(
              'Tipos de Doação:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            for (var type in donationPlace.donationTypes)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Icon(Icons.check, color: Colors.teal),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        type,
                        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateDonationPage(donationPlace: donationPlace),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Doar',
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
