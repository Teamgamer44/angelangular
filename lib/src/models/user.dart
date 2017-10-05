import 'package:angel_model/angel_model.dart';

class User extends Model {
  @override
  String id;
  @override
  DateTime createdAt, updatedAt;
  String username, password;

  User({this.id, this.username, this.password, this.createdAt, this.updatedAt});

  static User parse(Map map) => new User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      createdAt:
      map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
      map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String()
    };
  }
}