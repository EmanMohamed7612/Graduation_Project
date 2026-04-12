class SessionRequestModel {
  final int sessionId;
  final String beginnerName;
  final String beginnerImage;
  final String serviceName;
  final String date;
  final String startTime;
  final String endTime;

  SessionRequestModel({
    required this.sessionId,
    required this.beginnerName,
    required this.beginnerImage,
    required this.serviceName,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  factory SessionRequestModel.fromJson(Map<String, dynamic> json) {
    return SessionRequestModel(
      sessionId: json['sessionId'] ??json['SessionId']?? 0,
      beginnerName: json['beginnerName'] ??json['BeginnerName'] ?? '',
      beginnerImage: json['beginnerImage'] ??json['BeginnerImage'] ?? '',
      serviceName: json['serviceName'] ??json['ServiceName'] ?? '',
      date: json['date'] ??json['Date'] ?? '',
      startTime: json['startTime'] ??json['StartTime'] ?? '',
      endTime: json['endTime'] ??json['EndTime'] ?? '',
    );
  }
}