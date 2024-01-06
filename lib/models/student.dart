import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Student {
  final String studentId;
  final String schoolId;
  final String firstName;
  final String lastName;
  final DateTime graduationYear;
  final String personalSummary;

  Student({
    required this.studentId,
    required this.schoolId,
    required this.firstName,
    required this.lastName,
    required this.graduationYear,
    required this.personalSummary,
  });

  Student copyWith({
    String? studentId,
    String? schoolId,
    String? firstName,
    String? lastName,
    DateTime? graduationYear,
    String? personalSummary,
  }) {
    return Student(
      studentId: studentId ?? this.studentId,
      schoolId: schoolId ?? this.schoolId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      graduationYear: graduationYear ?? this.graduationYear,
      personalSummary: personalSummary ?? this.personalSummary,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'student_id': studentId,
      'school_id': schoolId,
      'first_name': firstName,
      'last_name': lastName,
      'graduation_year': graduationYear.toString(),
      'personal_summary': personalSummary,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      studentId: map['student_id'] as String,
      schoolId: map['school_id'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      graduationYear: DateTime.parse(map['graduation_year']),
      personalSummary: map['personal_summary'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(studentId: $studentId, schoolId: $schoolId, firstName: $firstName, lastName: $lastName, graduationYear: $graduationYear, personalSummary: $personalSummary)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.studentId == studentId &&
        other.schoolId == schoolId &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.graduationYear == graduationYear &&
        other.personalSummary == personalSummary;
  }

  @override
  int get hashCode {
    return studentId.hashCode ^
        schoolId.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        graduationYear.hashCode ^
        personalSummary.hashCode;
  }
}
