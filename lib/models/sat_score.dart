import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SATScore {
  final String id;
  final String studentId;
  final int math;
  final int english;
  final DateTime dateTaken;
  SATScore({
    required this.id,
    required this.studentId,
    required this.math,
    required this.english,
    required this.dateTaken,
  });

  SATScore copyWith({
    String? id,
    String? studentId,
    int? math,
    int? english,
    DateTime? dateTaken,
  }) {
    return SATScore(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      math: math ?? this.math,
      english: english ?? this.english,
      dateTaken: dateTaken ?? this.dateTaken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'student_td': studentId,
      'math': math,
      'english': english,
      'date_taken': dateTaken.toString(),
    };
  }

  factory SATScore.fromMap(Map<String, dynamic> map) {
    return SATScore(
      id: map['id'] as String,
      studentId: map['student_id'] as String,
      math: map['math'] as int,
      english: map['english'] as int,
      dateTaken: DateTime.parse(map['date_taken']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SATScore.fromJson(String source) =>
      SATScore.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SATScore(id: $id, studentId: $studentId, math: $math, english: $english, dateTaken: $dateTaken)';
  }

  @override
  bool operator ==(covariant SATScore other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.studentId == studentId &&
        other.math == math &&
        other.english == english &&
        other.dateTaken == dateTaken;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        studentId.hashCode ^
        math.hashCode ^
        english.hashCode ^
        dateTaken.hashCode;
  }
}
