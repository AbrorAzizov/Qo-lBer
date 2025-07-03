import 'dart:typed_data';

abstract class StorageRepo {
  Future<String?> uploadProfileImageMob (String path,String fileName );
  Future<String?> uploadProfileImageWeb (Uint8List fileBytes,String path);
}