import 'package:flutter/material.dart';
import '../models/DonationPlace.dart';


class DonationPlaceDetails extends StatelessWidget {
  final DonationPlace donationPlace;

  DonationPlaceDetails({required this.donationPlace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(donationPlace.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Endereço: ${donationPlace.address}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Latitude: ${donationPlace.latitude}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Longitude: ${donationPlace.longitude}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Tipos de Doação:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            for (var type in donationPlace.donationTypes)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  type,
                  style: TextStyle(fontSize: 14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
