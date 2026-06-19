class AddAddressModel {
  final String? appUserId;
  final String fullName;
  final String phoneNumber;
  final String city;
  final String streetDetails;
  final String region;

  AddAddressModel({

    required this.fullName,
    required this.phoneNumber,
    required this.city,
    required this.streetDetails,
    required this.region,
    this.appUserId,
  });

  Map<String, dynamic> toJson() {
    return {
      "appUserId": appUserId,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "city": city,
      "streetDetails": streetDetails,
      "region": region,
    };
  }
}