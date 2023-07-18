// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'date_model.dart';

class IncidentModel {
  String protocol;
  String description;
  DateModel date;
  IncidentModel({
    required this.protocol,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'protocol': protocol,
      'description': description,
      'date': date.toMap(),
    };
  }

  factory IncidentModel.fromMap(Map<String, dynamic> map) {
    return IncidentModel(
      protocol: map['protocol'],
      description: map['description'],
      date: DateModel.fromMap(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'IncidentModel(protocol: $protocol, description: $description, date: $date)';
  }

  @override
  bool operator ==(covariant IncidentModel other) {
    if (identical(this, other)) return true;

    return other.protocol == protocol &&
        other.description == description &&
        other.date == date;
  }

  @override
  int get hashCode {
    return protocol.hashCode ^ description.hashCode ^ date.hashCode;
  }
}
