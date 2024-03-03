// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CustomItem {
  final String type;
  final String id;
  final String title;
  final String description;
  final String userId;
  final String? link;
  CustomItem({
    required this.type,
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    this.link,
  });

  CustomItem copyWith({
    String? type,
    String? id,
    String? title,
    String? description,
    String? userId,
    String? link,
  }) {
    return CustomItem(
      type: type ?? this.type,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'id': id,
      'title': title,
      'description': description,
      'user_id': userId,
      'link': link,
    };
  }

  factory CustomItem.fromMap(Map<String, dynamic> map) {
    return CustomItem(
      type: map['type'] as String,
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      userId: map['user_id'] as String,
      link: map['link'] != null ? map['link'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomItem.fromJson(String source) =>
      CustomItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomItem(type: $type, id: $id, title: $title, description: $description, userId: $userId, link: $link)';
  }

  @override
  bool operator ==(covariant CustomItem other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.userId == userId &&
        other.link == link;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        userId.hashCode ^
        link.hashCode;
  }
}
