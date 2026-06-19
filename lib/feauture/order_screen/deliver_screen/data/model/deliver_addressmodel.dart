class AddressModel {
  final String fullName;
  final String appUserId;
  final String phoneNumber;
  final String city;
  final String streetDetails;
  final String region;

  AddressModel({
    required this.fullName,
    required this.appUserId,
    required this.phoneNumber,
    required this.city,
    required this.streetDetails,
    required this.region,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      fullName: json['fullName'] ?? '',
      appUserId: json['appUserId'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      city: json['city'] ?? '',
      streetDetails: json['streetDetails'] ?? '',
      region: json['region'] ?? '',
    );
  }
}