class BeginnerUpcomingSessionModel {
  final int sessionId;
  final String expertId;
  final String expertName;
  final String serviceName;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String status;
  final double amountPaid;
  final String? meetingLink;
  final String joinStatus;

  BeginnerUpcomingSessionModel({
    required this.sessionId,
    required this.expertId,
    required this.expertName,
    required this.serviceName,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.amountPaid,
    this.meetingLink,
    required this.joinStatus,
  });

  factory BeginnerUpcomingSessionModel.fromJson(Map<String, dynamic> json) {
    return BeginnerUpcomingSessionModel(
      sessionId: json['sessionId']??json['SessionId'],
      expertId: json['expertId']??json['ExpertId'],
      expertName: json['expertName']??json['ExpertName'],
      serviceName: json['serviceName']??json['ServiceName'],
      date: DateTime.parse(json['date']??json['Date']),
      startTime: json['startTime']??json['StartTime'],
      endTime: json['endTime']??json['EndTime'],
      status: json['status']??json['Status'],
      amountPaid: (json['amountPaid']??json['AmountPaid'] as num).toDouble(),
      meetingLink: json['meetingLink']??json['MeetingLink'],
      joinStatus: json['joinStatus']??json['JoinStatus'],
    );
  }
}