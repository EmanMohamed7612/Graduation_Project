class UpcomingSessionModel {
  final int sessionId;
  final String beginnerName;
  final String serviceName;
  final String date; // بييجي 2026-04-01T00:00:00
  final String startTime; // بييجي 14:00:00
  final String? meetingLink;
  final bool needsAction;
 // داخل ملف up_coming_session_model.dart تأكدي من وجود:
final String endTime; 
  UpcomingSessionModel({
    required this.sessionId,
    required this.beginnerName,
    required this.serviceName,
    required this.date,
    required this.startTime,
    this.meetingLink,
    required this.needsAction,
    required this.endTime,
  });

  factory UpcomingSessionModel.fromJson(Map<String, dynamic> json) {
    return UpcomingSessionModel(
      sessionId: json['sessionId']?? json['SessionId'],
      beginnerName: json['beginnerName']??json['BeginnerName'],
      serviceName: json['serviceName']??json['ServiceName'],
      date: json['date']??json['Date'],
      startTime: json['startTime']??json['StartTime'],
      meetingLink: json['meetingLink']??json['MeetingLink'],
      needsAction: json['needsAction']??json['NeedsAction'],
      endTime: json['endTime']??json['EndTime'],
    );
  }
}