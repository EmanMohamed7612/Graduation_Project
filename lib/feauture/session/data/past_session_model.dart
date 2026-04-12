class PastSessionModel {
  final int sessionId;
  final String beginnerName;
  final String serviceName;
  final String date;
  final String duration;
  final String status;
  final double amountPaid;

  PastSessionModel({
    required this.sessionId,
    required this.beginnerName,
    required this.serviceName,
    required this.date,
    required this.duration,
    required this.status,
    required this.amountPaid,
  });

  factory PastSessionModel.fromJson(Map<String, dynamic> json) {
    return PastSessionModel(
      sessionId: json['sessionId']??json['SessionId'],
      beginnerName: json['beginnerName']??json['BeginnerName'],
      serviceName: json['serviceName']??json['ServiceName'],
      date: json['date']??json['Date'],
      duration: json['duration']??json['Duration'],
      status: json['status']??json['Status'],
      amountPaid: (json['amountPaid']??json['AmountPaid']  as num).toDouble(),
    );
  }
}