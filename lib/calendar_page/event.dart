// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Event {
  DateTime dtstart;
  DateTime? dtend;
  final String summary;
  final String? description;
  final String? location;
  Event({
    required this.dtstart,
    this.dtend,
    required this.summary,
    required this.description,
    required this.location,
  });

  Event copyWith({
    DateTime? dtstart,
    DateTime? dtend,
    String? summary,
    String? description,
    String? location,
  }) {
    return Event(
      dtstart: dtstart ?? this.dtstart,
      dtend: dtend ?? this.dtend,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dtstart': dtstart.millisecondsSinceEpoch,
      'dtend': dtend == null ? "null" : dtend!.millisecondsSinceEpoch,
      'summary': summary,
      'description': description,
      'location': location,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      dtstart: DateTime.parse(map['dtstart']['dt']),
      dtend: map['dtend'] == null ? null : DateTime.parse(map['dtend']['dt']),
      summary: map['summary'] as String,
      description:
          map["description"] == null ? null : map['description'] as String,
      location: map["location"] == null ? null : map['location'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Event(dtstart: $dtstart, dtend: $dtend, summary: $summary, description: $description, location: $location)';
  }

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;

    return other.dtstart == dtstart &&
        other.dtend == dtend &&
        other.summary == summary &&
        other.description == description &&
        other.location == location;
  }

  @override
  int get hashCode {
    return dtstart.hashCode ^
        dtend.hashCode ^
        summary.hashCode ^
        description.hashCode ^
        location.hashCode;
  }
}
