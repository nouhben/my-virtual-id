import 'package:best_starter_architecture/models/custom_user.dart';
import 'package:best_starter_architecture/screens/home/home_screen.dart';
import 'package:best_starter_architecture/screens/signin/signin_screen.dart';
import 'package:best_starter_architecture/shared/constants.dart';
import 'package:flutter/material.dart';

/// Builds the signed-in or non signed-in UI, depending on the user snapshot.
/// This widget should be below the [MaterialApp].
/// An [AuthWidgetBuilder] ancestor is required for this widget to work.

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<CustomUser> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? HomeScreen() : SignInScreen();
    }
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
