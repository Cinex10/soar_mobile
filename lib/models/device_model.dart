class DeviceModel {
  String name;
  String status;
  String ip;
  DeviceModel({
    required this.name,
    required this.status,
    required this.ip,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'status': status,
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      name: map['name'] as String,
      status: map['status'] as String,
      ip: map['ip'] as String,
    );
  }

  @override
  String toString() => 'DeviceModel(name: $name, status: $status)';

  @override
  bool operator ==(covariant DeviceModel other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode ^ status.hashCode;
}
