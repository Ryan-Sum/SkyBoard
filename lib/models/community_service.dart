// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CommunityService {
  final String id;
  final String studentId;
  final String organizationName;
  final String description;
  final int hours;
  final bool brightFuturesEligible;
  CommunityService({
    required this.id,
    required this.studentId,
    required this.organizationName,
    required this.description,
    required this.hours,
    required this.brightFuturesEligible,
  });

  CommunityService copyWith({
    String? id,
    String? studentId,
    String? organizationName,
    String? description,
    int? hours,
    bool? brightFuturesEligible,
  }) {
    return CommunityService(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      organizationName: organizationName ?? this.organizationName,
      description: description ?? this.description,
      hours: hours ?? this.hours,
      brightFuturesEligible:
          brightFuturesEligible ?? this.brightFuturesEligible,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'student_id': studentId,
      'organization_name': organizationName,
      'description': description,
      'hours': hours,
      'bright_futures_eligible': brightFuturesEligible,
    };
  }

  factory CommunityService.fromMap(Map<String, dynamic> map) {
    return CommunityService(
      id: map['id'] as String,
      studentId: map['student_id'] as String,
      organizationName: map['organization_name'] as String,
      description: map['description'] as String,
      hours: map['hours'],
      brightFuturesEligible: map['bright_futures_eligible'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommunityService.fromJson(String source) =>
      CommunityService.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommunityService(id: $id, studentId: $studentId, organizationName: $organizationName, description: $description, hours: $hours, brightFuturesEligible: $brightFuturesEligible)';
  }

  @override
  bool operator ==(covariant CommunityService other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.studentId == studentId &&
        other.organizationName == organizationName &&
        other.description == description &&
        other.hours == hours &&
        other.brightFuturesEligible == brightFuturesEligible;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        studentId.hashCode ^
        organizationName.hashCode ^
        description.hashCode ^
        hours.hashCode ^
        brightFuturesEligible.hashCode;
  }
}
