class DonationPlace {
  final String name;
  final String latitude;
  final String longitude;
  final String address;
  final List<String> donationTypes;

  DonationPlace({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.donationTypes,
  });

  factory DonationPlace.fromJson(Map<String, dynamic> json) {
    return DonationPlace(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      donationTypes: List<String>.from(json['listTypes'].map((type) => type['name'])),
    );
  }


}
