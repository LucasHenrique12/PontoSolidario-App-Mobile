class Donation {
  final String id;
  final String userId;
  final String donationPlaceId;
  final DateTime dataHora;
  final String donationType;

  Donation({
    required this.id,
    required this.userId,
    required this.donationPlaceId,
    required this.dataHora,
    required this.donationType,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      userId: json['userId'],
      donationPlaceId: json['donationPlaceId'],
      dataHora: DateTime.parse(json['dataHora']),
      donationType: json['donationType'],
    );
  }
}