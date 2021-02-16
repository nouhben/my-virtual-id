import 'dart:io';
import 'package:best_starter_architecture/services/firestore_path_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageService {
  final String uid;

  FirebaseStorageService({@required this.uid}) : assert(uid != null);

  /// Generic file upload for any [path] and [contentType]
  Future<String> upload({
    @required File file,
    @required String path,
    @required String contentType,
  }) async {
    print('uploading to: $path');

    final storageReference = FirebaseStorage.instance.ref().child(path);
    final metadata = SettableMetadata(contentType: contentType);
    final uploadTask = storageReference.putFile(file, metadata);
    final snapshot = await uploadTask.whenComplete(() {
      print('upload complete');
    });

    // Url used to download file/image
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print('downloadUrl: $downloadUrl');
    return downloadUrl;
  }

  /// Upload an avatar from file
  Future<String> uploadAvatar({
    @required File file,
  }) async =>
      await upload(
        file: file,
        path: FirestorePath.avatar(uid) + '/avatar.png',
        contentType: 'image/png',
      );
}
