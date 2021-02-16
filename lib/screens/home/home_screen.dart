import 'package:best_starter_architecture/models/avatar_reference.dart';
import 'package:best_starter_architecture/screens/about/about_screen.dart';
import 'package:best_starter_architecture/services/auth_service.dart';
import 'package:best_starter_architecture/services/firebase_storage_service.dart';
import 'package:best_starter_architecture/services/firestore_service.dart';
import 'package:best_starter_architecture/services/image_picker_service.dart';
import 'package:best_starter_architecture/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _onAbout(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => AboutScreen(),
      ),
    );
  }

  Future<void> _chooseAvatar(BuildContext context) async {
    // 1. Get image from picker
    final _imagePicker =
        Provider.of<ImagePickerService>(context, listen: false);
    final file = await _imagePicker.pickImage(source: ImageSource.gallery);
    // 2. Upload to storage
    if (file != null) {
      final storage =
          Provider.of<FirebaseStorageService>(context, listen: false);
      final downloadUrl = await storage.uploadAvatar(file: file);
      // 3. Save url to Firestore
      final database = Provider.of<FirestoreService>(context, listen: false);
      await database.setAvatarReference(
        AvatarReference(downloadUrl: downloadUrl),
      );
      // 4. (optional) delete local file as no longer needed
      await file.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context, listen: false);

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
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(280.0),
          child: Column(
            children: <Widget>[
              _buildUserInfo(context: context),
              //CustomUserInfo(onPress: _chooseAvatar),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo({BuildContext context}) {
    final database = Provider.of<FirestoreService>(context, listen: false);
    return StreamBuilder<AvatarReference>(
      stream: database.avatarReferenceStream(),
      builder: (context, snapshot) {
        final avatarReference = snapshot.data;
        return Avatar(
          photoUrl: avatarReference?.downloadUrl,
          radius: 50,
          borderColor: Colors.black54,
          borderWidth: 2.0,
          onPressed: () async {
            await _chooseAvatar(context);
          },
        );
      },
    );
  }
}
