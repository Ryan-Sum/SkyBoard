import 'dart:convert';

class UserEvent {
  DateTime dtstart;
  DateTime? dtend;
  final String summary;
  final String? description;
  final String? location;
  final String studentId;
  final String id;
  UserEvent({
    required this.dtstart,
    this.dtend,
    required this.summary,
    this.description,
    this.location,
    required this.studentId,
    required this.id,
  });

  UserEvent copyWith({
    DateTime? dtstart,
    DateTime? dtend,
    String? summary,
    String? description,
    String? location,
    String? studentId,
    String? id,
  }) {
    return UserEvent(
      dtstart: dtstart ?? this.dtstart,
      dtend: dtend ?? this.dtend,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      location: location ?? this.location,
      studentId: studentId ?? this.studentId,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dtstart': dtstart.toString(),
      'dtend': dtend?.toString(),
      'summary': summary,
      'description': description,
      'location': location,
      'student_id': studentId,
      'id': id,
    };
  }

  factory UserEvent.fromMap(Map<String, dynamic> map) {
    return UserEvent(
      dtstart: DateTime.parse(map['dtstart']),
      dtend: map['dtend'] != null ? DateTime.parse(map['dtend']) : null,
      summary: map['summary'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      studentId: map['student_id'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEvent.fromJson(String source) =>
      UserEvent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserEvent(dtstart: $dtstart, dtend: $dtend, summary: $summary, description: $description, location: $location, student_id: $studentId, id: $id)';
  }

  @override
  bool operator ==(covariant UserEvent other) {
    if (identical(this, other)) return true;

    return other.dtstart == dtstart &&
        other.dtend == dtend &&
        other.summary == summary &&
        other.description == description &&
        other.location == location &&
        other.studentId == studentId &&
        other.id == id;
  }

  @override
  int get hashCode {
    return dtstart.hashCode ^
        dtend.hashCode ^
        summary.hashCode ^
        description.hashCode ^
        location.hashCode ^
        studentId.hashCode ^
        id.hashCode;
  }
}
