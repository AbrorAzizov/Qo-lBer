import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:qol_ber/features/domain/entity/app_user.dart';

import '../repository/profile_repo.dart';

class FireBaseProfileRepo extends ProfileRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> fetchUserProfile(String uid) async {
    try {
      final userInfo = await firebaseFirestore.collection('users').doc(uid).get();

      if (userInfo.exists) {
        final data = userInfo.data();

        if (data == null) return null;

        return AppUser(
          uid: data['uid'] ?? '',
          email: data['email'] ?? '',
          name: data['name'] ?? '',
          createdAt: data['created_at'] .toDate(),
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  @override
  Future<void> updateProfile(AppUser updateUser) async{
  await firebaseFirestore.collection('users').doc(updateUser.uid).update({
    'name' : updateUser.name
  });
  }
}
