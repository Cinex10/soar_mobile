import 'dart:convert';

import 'package:soar_mobile/models/date_model.dart';
import 'package:soar_mobile/models/incident_model.dart';

class WarningsModel extends IncidentModel {
  String status;

  WarningsModel(
      {required super.protocol,
      required super.description,
      required super.date,
      required this.status});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'protocol': protocol,
      'description': description,
      'date': date.toMap(),
      'status': status,
    };
  }

// {protocol: SNMP, description: somthing, date: {year: 2023, month: 6, day: 10, time: 20:19:48}, status: not seen}
  factory WarningsModel.fromMap(Map<String, dynamic> map) {
    return WarningsModel(
      protocol: map['protocol'] as String,
      description: map['description'] as String,
      date: DateModel.fromMap(map['date']),
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WarningsModel.fromJson(String source) =>
      WarningsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WarningsModel(status: $status)';
}
