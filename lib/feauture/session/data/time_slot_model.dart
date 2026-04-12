class TimeSlotModel {
  final String date;
  final String startTime;
  final int ?id;

  TimeSlotModel( {required this.date, required this.startTime,  this.id});

  // إضافة الجزء ده
  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      id: json['id'] ?? 0,
      date: json['date'] ?? json['Date'] ?? '',
      startTime: json['startTime'] ?? json['StartTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"date": date, "startTime": startTime};
  }
}
