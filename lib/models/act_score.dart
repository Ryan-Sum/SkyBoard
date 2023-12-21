import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ACTScore {
  final String id;
  final String studentId;
  final int math;
  final int english;
  final int science;
  final int reading;
  final DateTime dateTaken;

  ACTScore({
    required this.id,
    required this.studentId,
    required this.math,
    required this.english,
    required this.science,
    required this.reading,
    required this.dateTaken,
  });

  ACTScore copyWith({
    String? id,
    String? studentId,
    int? math,
    int? english,
    int? science,
    int? reading,
    DateTime? dateTaken,
  }) {
    return ACTScore(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      math: math ?? this.math,
      english: english ?? this.english,
      science: science ?? this.science,
      reading: reading ?? this.reading,
      dateTaken: dateTaken ?? this.dateTaken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'student_id': studentId,
      'math': math,
      'english': english,
      'science': science,
      'reading': reading,
      'date_taken': dateTaken.toString(),
    };
  }

  factory ACTScore.fromMap(Map<String, dynamic> map) {
    return ACTScore(
      id: map['id'] as String,
      studentId: map['student_id'] as String,
      math: map['math'] as int,
      english: map['english'] as int,
      science: map['science'] as int,
      reading: map['reading'] as int,
      dateTaken: DateTime.parse(map['date_taken']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ACTScore.fromJson(String source) =>
      ACTScore.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ACTScore(id: $id, studentId: $studentId, math: $math, english: $english, science: $science, reading: $reading, dateTaken: $dateTaken)';
  }

  @override
  bool operator ==(covariant ACTScore other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.studentId == studentId &&
        other.math == math &&
        other.english == english &&
        other.science == science &&
        other.reading == reading &&
        other.dateTaken == dateTaken;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        studentId.hashCode ^
        math.hashCode ^
        english.hashCode ^
        science.hashCode ^
        reading.hashCode ^
        dateTaken.hashCode;
  }
}
