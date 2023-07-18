class DateModel {
  String year;
  String month;
  String day;
  String time;
  DateModel({
    required this.year,
    required this.month,
    required this.day,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'year': year,
      'month': month,
      'day': day,
      'time': time,
    };
  }

  factory DateModel.fromMap(Map<String, dynamic> map) {
    return DateModel(
      year: map['year'],
      month: map['month'],
      day: map['day'],
      time: map['time'],
    );
  }

  DateTime toDateTime() {
    return DateTime(int.parse(year), int.parse(month), int.parse(day));
  }

  @override
  String toString() {
    return '$year/$month/$day $time';
  }
}
