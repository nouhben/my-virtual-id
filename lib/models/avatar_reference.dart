import 'package:flutter/foundation.dart';

class AvatarReference {
  AvatarReference({@required this.downloadUrl});
  final String downloadUrl;

  factory AvatarReference.fromMap(Map<String, dynamic> data) =>
      (data == null || data['downloadUrl'] == null)
          ? null
          : AvatarReference(
              downloadUrl: data['downloadUrl'],
            );
  //   factory AvatarReference.fromMap(Map<String, dynamic> data) {
  //   if (data == null) {
  //     return null;
  //   }
  //   final String downloadUrl = data['downloadUrl'];
  //   if (downloadUrl == null) {
  //     return null;
  //   }
  //   return AvatarReference(downloadUrl);
  // }

  Map<String, dynamic> toMap() {
    return {'downloadUrl': downloadUrl};
  }
}
