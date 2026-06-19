class BeginnerPastSessionModel {
  final int sessionId;
  final String expertId;
  final String expertName;
  final String expertImageUrl;
  final String serviceName;
  final DateTime date;
  final String timeAndDuration;
  final String status;
  final double amountPaid;

  BeginnerPastSessionModel({
    required this.sessionId,
    required this.expertId,
    required this.expertName,
    required this.expertImageUrl,
    required this.serviceName,
    required this.date,
    required this.timeAndDuration,
    required this.status,
    required this.amountPaid,
  });

  factory BeginnerPastSessionModel.fromJson(Map<String, dynamic> json) {
    return BeginnerPastSessionModel(
      sessionId: json['sessionId'] ??json['SessionId'] ?? 0,
      expertId: json['expertId'] ??json['ExpertId'] ?? '',
      expertName: json['expertName'] ??json['ExpertName'] ?? '',
      expertImageUrl: json['expertImageUrl'] ??json['ExpertImageUrl'] ??  '',
      serviceName: json['serviceName'] ??json['ServiceName'] ?? '',
      date: DateTime.parse(json['date']??json['Date']),
      timeAndDuration: json['timeAndDuration'] ??json['TimeAndDuration'] ?? '',
      status: json['status'] ??json['Status'] ?? '',
      amountPaid: (json['amountPaid']??json['AmountPaid'] as num).toDouble(),
    );
  }
}