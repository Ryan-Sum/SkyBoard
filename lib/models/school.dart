import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class School {
  final String schoolId;
  final String name;
  final String address;
  School({
    required this.schoolId,
    required this.name,
    required this.address,
  });

  School copyWith({
    String? schoolId,
    String? name,
    String? address,
  }) {
    return School(
      schoolId: schoolId ?? this.schoolId,
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'school_id': schoolId,
      'name': name,
      'address': address,
    };
  }

  factory School.fromMap(Map<String, dynamic> map) {
    return School(
      schoolId: map['school_id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory School.fromJson(String source) =>
      School.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'School(schoolId: $schoolId, name: $name, address: $address)';

  @override
  bool operator ==(covariant School other) {
    if (identical(this, other)) return true;

    return other.schoolId == schoolId &&
        other.name == name &&
        other.address == address;
  }

  @override
  int get hashCode => schoolId.hashCode ^ name.hashCode ^ address.hashCode;
}
