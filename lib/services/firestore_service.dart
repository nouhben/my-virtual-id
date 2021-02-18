import 'package:best_starter_architecture/models/avatar_reference.dart';
import 'package:best_starter_architecture/services/firestore_path_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final String uid;

  FirestoreService({@required this.uid}) : assert(uid != null);

  // Sets the avatar download url
  Future<void> setAvatarReference({
    @required AvatarReference avatarReference,
  }) async {
    final path = FirestorePath.avatar(uid);
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(avatarReference.toMap());
  }

  // Reads the current avatar download url
  Stream<AvatarReference> avatarReferenceStream() {
    final path = FirestorePath.avatar(uid);
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (snapshot) => AvatarReference.fromMap(
        snapshot.data(),
      ),
    );
  }

  List<AvatarReference> _avatarListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.toList().map(
          (doc) => AvatarReference(
            downloadUrl: doc.get('downloadUrl'),
          ),
        );
  }

  Stream<List<AvatarReference>> avatars() {
    final reference = FirebaseFirestore.instance.collection('avatar');
    final snapshots = reference.snapshots();
    return snapshots.map(_avatarListFromSnapshot);
  }
}
