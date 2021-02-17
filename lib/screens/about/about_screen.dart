import 'package:best_starter_architecture/models/avatar_reference.dart';
import 'package:best_starter_architecture/services/firestore_service.dart';
import 'package:best_starter_architecture/shared/constants.dart';
import 'package:best_starter_architecture/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130.0),
          child: Column(
            children: [
              //CustomUserInfo(),
              _buildUserInfo(context: context),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Advanced Provider Tutorials',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 32),
            Text(
              'by Andrea Bizzotto',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 32),
            Text(
              'codingwithflutter.com',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
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
      );
    },
  );
}

class CustomUserInfo extends StatelessWidget {
  final Function onPress;

  const CustomUserInfo({Key key, this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _databaseService =
        Provider.of<FirestoreService>(context, listen: false);
    return StreamBuilder<AvatarReference>(
      stream: _databaseService.avatarReferenceStream(),
      builder: (context, snapshot) => !snapshot.hasData
          ? CircleAvatar(
              child: CircularProgressIndicator(),
              radius: 40,
            )
          : Avatar(
              photoUrl: snapshot.data.downloadUrl ?? null,
              radius: 50.0,
              borderColor: kPrimaryColor,
              borderWidth: 2.0,
              onPressed: this.onPress ?? null,
            ),
    );
  }
}
