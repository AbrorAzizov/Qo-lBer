class AppUser {
  final String uid;
  final String name;
  final String photoUrl;

  AppUser({
    required this.uid,
    required this.name,
    required this.photoUrl,
  });

  // fromJson
  factory AppUser.fromJson(String uid, Map<String, dynamic> json) {
    return AppUser(
      uid: uid,
      name: json['name'] ?? '',
      photoUrl: json['photo_url'] ?? '',
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'photo_url': photoUrl,
    };
  }
}
