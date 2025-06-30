import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String email;
  final String name;
  final Timestamp createdAt;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.createdAt,
  });

  /// Конвертация в JSON (для отправки в Firestore)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'created_at': createdAt,
    };
  }

  /// Конвертация из JSON (из Firestore)
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      createdAt: json['created_at'] ?? Timestamp.now(),
    );
  }
}
