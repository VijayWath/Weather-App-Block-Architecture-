import 'dart:convert';

class ForcastModel {
  final double hourlyTemp;
  final String hourlysky;
  final DateTime time;

  ForcastModel({
    required this.hourlyTemp,
    required this.hourlysky,
    required this.time,
  });

  ForcastModel copyWith({
    double? hourlyTemp,
    String? hourlysky,
    DateTime? time,
  }) {
    return ForcastModel(
      hourlyTemp: hourlyTemp ?? this.hourlyTemp,
      hourlysky: hourlysky ?? this.hourlysky,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hourlyTemp': hourlyTemp,
      'hourlysky': hourlysky,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory ForcastModel.fromMap(Map<String, dynamic> map) {
    return ForcastModel(
      hourlyTemp: map['hourlyTemp'] as double,
      hourlysky: map['hourlysky'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ForcastModel.fromJson(String source) =>
      ForcastModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ForcastModel(hourlyTemp: $hourlyTemp, hourlysky: $hourlysky, time: $time)';

  @override
  bool operator ==(covariant ForcastModel other) {
    if (identical(this, other)) return true;

    return other.hourlyTemp == hourlyTemp &&
        other.hourlysky == hourlysky &&
        other.time == time;
  }

  @override
  int get hashCode => hourlyTemp.hashCode ^ hourlysky.hashCode ^ time.hashCode;
}
