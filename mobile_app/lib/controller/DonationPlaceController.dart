import 'package:flutter/material.dart';

import '../models/DonationPlace.dart';
import '../services/DonationPlaceService.dart';


class DonationPlaceController {
  final DonationPlaceService donationPlaceService;

  DonationPlaceController(this.donationPlaceService);

  Future<List<DonationPlace>> fetchDonationPlaces() async {
    return await donationPlaceService.fetchDonationPlaces();
  }

  Future<List<DonationPlace>> filterDonationPlaces(String donationTypeId) async {
    return await donationPlaceService.fetchDonationPlacesByType(donationTypeId);
  }

  Future<void> refreshDonationPlaces(Function setState) async {
    setState(() {
      fetchDonationPlaces();
    });
  }
}