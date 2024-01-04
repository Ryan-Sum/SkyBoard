import 'dart:convert';

import 'package:sky_board/models/course_type.dart';
import 'package:sky_board/models/grade.dart';
import 'package:sky_board/models/subject.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Course {
  final String id;
  final String studentId;
  final String courseName;
  final CourseType? courseType;
  final Subject? subject;
  final DateTime? yearTaken;
  final bool isOneSemester;
  final Grade? semesterOneGrade;
  final Grade? semesterTwoGrade;
  final Grade finalGrade;
  Course({
    required this.id,
    required this.studentId,
    required this.courseName,
    required this.courseType,
    required this.subject,
    required this.yearTaken,
    required this.isOneSemester,
    required this.semesterOneGrade,
    required this.semesterTwoGrade,
    required this.finalGrade,
  });

  Course copyWith({
    String? id,
    String? studentId,
    String? courseName,
    CourseType? courseType,
    Subject? subject,
    DateTime? yearTaken,
    bool? isOneSemester,
    Grade? semesterOneGrade,
    Grade? semesterTwoGrade,
    Grade? finalGrade,
  }) {
    return Course(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      courseName: courseName ?? this.courseName,
      courseType: courseType ?? this.courseType,
      subject: subject ?? this.subject,
      yearTaken: yearTaken ?? this.yearTaken,
      isOneSemester: isOneSemester ?? this.isOneSemester,
      semesterOneGrade: semesterOneGrade ?? this.semesterOneGrade,
      semesterTwoGrade: semesterTwoGrade ?? this.semesterTwoGrade,
      finalGrade: finalGrade ?? this.finalGrade,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'student_id': studentId,
      'course_name': courseName,
      'course_type': courseType!.index,
      'subject': subject!.index,
      'year_taken': yearTaken.toString(),
      'is_one_semester': isOneSemester,
      'semester_one_grade': semesterOneGrade!.index,
      'semester_two_grade':
          // ignore: prefer_null_aware_operators
          semesterTwoGrade == null ? null : semesterTwoGrade!.index,
      'final_grade': finalGrade.index,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'] as String,
      studentId: map['student_id'] as String,
      courseName: map['course_name'] as String,
      courseType: CourseType.values[map['course_type']],
      subject: Subject.values[map['subject']],
      yearTaken: DateTime.parse(map['year_taken']),
      isOneSemester: map['is_one_semester'] as bool,
      semesterOneGrade: Grade.values[map['semester_one_grade']],
      semesterTwoGrade: map['semester_two_grade'] == null
          ? null
          : Grade.values[map['semester_two_grade']],
      finalGrade: Grade.values[map['final_grade']],
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) =>
      Course.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Course(id: $id, studentId: $studentId, courseName: $courseName, courseType: $courseType, subject: $subject, yearTaken: $yearTaken, isOneSemester: $isOneSemester, semesterOneGrade: $semesterOneGrade, semesterTwoGrade: $semesterTwoGrade, finalGrade: $finalGrade)';
  }

  @override
  bool operator ==(covariant Course other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.studentId == studentId &&
        other.courseName == courseName &&
        other.courseType == courseType &&
        other.subject == subject &&
        other.yearTaken == yearTaken &&
        other.isOneSemester == isOneSemester &&
        other.semesterOneGrade == semesterOneGrade &&
        other.semesterTwoGrade == semesterTwoGrade &&
        other.finalGrade == finalGrade;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        studentId.hashCode ^
        courseName.hashCode ^
        courseType.hashCode ^
        subject.hashCode ^
        yearTaken.hashCode ^
        isOneSemester.hashCode ^
        semesterOneGrade.hashCode ^
        semesterTwoGrade.hashCode ^
        finalGrade.hashCode;
  }
}
