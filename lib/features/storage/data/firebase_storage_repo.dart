import 'dart:io';
import 'dart:typed_data';

import 'package:qol_ber/features/storage/repo/storage_repo.dart';

class FirebaseStorageRepo implements StorageRepo{
  @override
  Future<String?> uploadProfileImageMob(String path, String fileName) {
    final file = File(path);

    throw UnimplementedError();
  }

  @override
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String path) {

    throw UnimplementedError();
  }
}