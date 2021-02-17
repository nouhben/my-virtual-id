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
      // 1. Get image from picker
      final imagePickerService =
          Provider.of<ImagePickerService>(context, listen: false);
      final img =
          await imagePickerService.pickImage(source: ImageSource.gallery);
      if (img != null) {
        // 2. Upload to storage
        //User user = FirebaseAuth.instance.currentUser;
        // final user = Provider.of<CustomUser>(context, listen: false);
        final storage =
            Provider.of<FirebaseStorageService>(context, listen: false);
        final downloadUrl = await storage.uploadAvatar(file: img);
        print(downloadUrl);
        //3. Save url to Firestore
        final databaseService = Provider.of<FirestoreService>(
          context,
          listen: false,
        );
        databaseService.setAvatarReference(
          avatarReference: AvatarReference(downloadUrl: downloadUrl),
        );
        // 4. (optional) delete local file as no longer needed
        await img.delete();
      }
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
    // TODO: disable the button when the image is uploading and show progress bar
    final databaseService = Provider.of<FirestoreService>(context);
    //final user = Provider.of<CustomUser>(context, listen: false);
    // We do not want the homepage to rebuild there is already a stream builder responsible for that
    return StreamBuilder<AvatarReference>(
        stream: databaseService.avatarReferenceStream(),
        builder: (context, snapshot) {
          print('loading the user info...');
          final avatarReference = snapshot.data;
          return Avatar(
            photoUrl: avatarReference?.downloadUrl,
            radius: 50,
            borderColor: Colors.black54,
            borderWidth: 2.0,
            onPressed: () => _chooseAvatar(context),
          );
        });
  }
}
