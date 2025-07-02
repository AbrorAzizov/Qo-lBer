import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String email;
  final String name;
  final Timestamp createdAt;
  final String? bio;
  final String? photoUrl;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.createdAt,
    this.bio,
    this.photoUrl,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      createdAt: json['created_at'] ?? Timestamp.now(),
      bio: json['bio'],
      photoUrl: json['photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'created_at': createdAt,
      if (bio != null) 'bio': bio,
      if (photoUrl != null) 'photo_url': photoUrl,
    };
  }

  AppUser copyWith({
    String? name,
    String? bio,
    String? photoUrl,
  }) {
    return AppUser(
      uid: uid,
      email:  email,
      createdAt: createdAt,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
