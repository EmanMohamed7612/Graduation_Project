class TimeSlotModel {
  final String date; 
  final String startTime; 

  TimeSlotModel({required this.date, required this.startTime});

  // إضافة الجزء ده
  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      date: json['date'] ??json['Date'] ?? '',
      startTime: json['startTime'] ??json['StartTime']?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "startTime": startTime,
    };
  }
}