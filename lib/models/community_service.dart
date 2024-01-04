// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CommunityService {
  final String id;
  final String studentId;
  final String organizationName;
  final String description;
  final double hours;
  final bool brightFuturesEligible;
  final bool isVerified;
  final DateTime date;
  CommunityService({
    required this.id,
    required this.studentId,
    required this.organizationName,
    required this.description,
    required this.hours,
    required this.brightFuturesEligible,
    required this.isVerified,
    required this.date,
  });

  CommunityService copyWith({
    String? id,
    String? studentId,
    String? organizationName,
    String? description,
    double? hours,
    bool? brightFuturesEligible,
    bool? isVerified,
    DateTime? date,
  }) {
    return CommunityService(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId,
        organizationName: organizationName ?? this.organizationName,
        description: description ?? this.description,
        hours: hours ?? this.hours,
        brightFuturesEligible:
            brightFuturesEligible ?? this.brightFuturesEligible,
        isVerified: isVerified ?? this.isVerified,
        date: date ?? this.date);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'student_id': studentId,
      'organization_name': organizationName,
      'description': description,
      'hours': hours,
      'bright_futures_eligible': brightFuturesEligible,
      'is_verified': isVerified,
      'date': date.toString(),
    };
  }

  factory CommunityService.fromMap(Map<String, dynamic> map) {
    return CommunityService(
      id: map['id'] as String,
      studentId: map['student_id'] as String,
      organizationName: map['organization_name'] as String,
      description: map['description'] as String,
      hours: map['hours'] as double,
      brightFuturesEligible: map['bright_futures_eligible'] as bool,
      isVerified: map['is_verified'] as bool,
      date: DateTime.parse(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommunityService.fromJson(String source) =>
      CommunityService.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommunityService(id: $id, studentId: $studentId, organizationName: $organizationName, description: $description, hours: $hours, brightFuturesEligible: $brightFuturesEligible, isVerified: $isVerified, date: $date)';
  }

  @override
  bool operator ==(covariant CommunityService other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.studentId == studentId &&
        other.organizationName == organizationName &&
        other.description == description &&
        other.hours == hours &&
        other.brightFuturesEligible == brightFuturesEligible &&
        other.isVerified == isVerified;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        studentId.hashCode ^
        organizationName.hashCode ^
        description.hashCode ^
        hours.hashCode ^
        brightFuturesEligible.hashCode ^
        isVerified.hashCode;
  }
}
