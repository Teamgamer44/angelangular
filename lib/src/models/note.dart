import 'package:angel_model/angel_model.dart';

class Note extends Model {
  @override
  String id;
  @override
  DateTime createdAt, updatedAt;
  String userId, title, text;

  Note(
      {this.id,
        this.userId,
        this.title,
        this.text,
        this.createdAt,
        this.updatedAt});

  static Note parse(Map map) => new Note(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      text: map['text'],
      createdAt:
      map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
      map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'text': text,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String()
    };
  }
}
