import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:qol_ber/features/domain/entity/app_user.dart';

import '../repository/profile_repo.dart';

class FireBaseProfileRepo extends ProfileRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> fetchUserProfile(String uid) async {
    try {
      final doc = await firebaseFirestore.collection('users').doc(uid).get();

      if (!doc.exists || doc.data() == null) {
        debugPrint('🔍 No user profile found for UID: $uid');
        return null;
      }

      final data = doc.data()!;
      final createdAt = data['created_at'];
      if (createdAt == null || createdAt is! Timestamp) {
        debugPrint('⚠️ Invalid or missing created_at for UID: $uid');
        return null;
      }

      return AppUser(
        uid: data['uid'] ?? uid,
        email: data['email'] ?? '',
        name: data['name'] ?? '',
        createdAt: data['created_at'],
        bio: data['bio']?? ''


      );
    } catch (e, stackTrace) {
      debugPrint('❌ Error fetching profile for UID $uid: $e');
      debugPrintStack(stackTrace: stackTrace);
      return null;
    }
  }

  @override
  Future<void> updateProfile(AppUser updateUser) async{
  await firebaseFirestore.collection('users').doc(updateUser.uid).update({
    'name' : updateUser.name,
    'bio' :updateUser.bio,
    'photoUrl': updateUser.photoUrl
  });
  }
}
