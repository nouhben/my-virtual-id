import 'package:best_starter_architecture/models/avatar_reference.dart';
import 'package:best_starter_architecture/models/custom_user.dart';
import 'package:best_starter_architecture/screens/about/about_screen.dart';
import 'package:best_starter_architecture/services/auth_service.dart';
import 'package:best_starter_architecture/services/firebase_storage_service.dart';
import 'package:best_starter_architecture/services/firestore_service.dart';
import 'package:best_starter_architecture/services/image_picker_service.dart';
import 'package:best_starter_architecture/widgets/avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthService>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onAbout(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => AboutScreen(),
      ),
    );
  }

  Future<void> _chooseAvatar(BuildContext context) async {
    try {
      final auth = Provider.of<AuthService>(context, listen: false);
      // 1. Get image from picker
      // final _imagePickerService = ImagePickerService();
      // final image =
      //     await _imagePickerService.pickImage(source: ImageSource.gallery);
      // // 2. Upload to storage
      //User user = FirebaseAuth.instance.currentUser;
      // final storage = FirebaseStorageService(uid: user.uid);
      // final downloadUrl = await storage.upload(
      //   file: image,
      //   path: AvatarReference(downloadUrl: image.path).downloadUrl,
      //   contentType: 'image/png',
      // );
      // // 3. Save url to Firestore
      // final firestoreService = FirestoreService(uid: user.uid);
      //firestoreService.setAvatarReference(avatarReference)
      // 4. (optional) delete local file as no longer needed
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.help),
          onPressed: () => _onAbout(context),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _signOut(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130.0),
          child: Column(
            children: <Widget>[
              _buildUserInfo(context: context),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo({BuildContext context}) {
    // TODO: Download and show avatar from Firebase storage
    return Avatar(
      photoUrl: null,
      radius: 50,
      borderColor: Colors.black54,
      borderWidth: 2.0,
      onPressed: () => _chooseAvatar(context),
    );
  }
}
