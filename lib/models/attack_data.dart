// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AttackData {
  final String value;
  final int attacks;

  AttackData(
    this.value,
    this.attacks,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'attacks': attacks,
    };
  }

  factory AttackData.fromMap(Map<String, dynamic> map) {
    return AttackData(
      map['value'] as String,
      map['attacks'] as int,
    );
  }

  @override
  String toString() => 'AttackData(value: $value, attacks: $attacks)';
}
