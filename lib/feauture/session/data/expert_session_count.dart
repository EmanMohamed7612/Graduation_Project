class ExpertSessionsCountModel {
  final int sessionsCount;

  ExpertSessionsCountModel({required this.sessionsCount});

  factory ExpertSessionsCountModel.fromJson(Map<String, dynamic> json) {
    return ExpertSessionsCountModel(
      sessionsCount: json['data']['sessionsCount'] ??json['data']['SessionsCount'] ?? 0,
    );
  }
}