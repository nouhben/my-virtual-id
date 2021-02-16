import 'package:best_starter_architecture/models/custom_user.dart';
import 'package:best_starter_architecture/screens/home/home_screen.dart';
import 'package:best_starter_architecture/screens/signin/signin_screen.dart';
import 'package:best_starter_architecture/services/auth_service.dart';
import 'package:best_starter_architecture/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Builds the signed-in or non signed-in UI, depending on the user snapshot.
/// This widget should be below the [MaterialApp].
/// An [AuthWidgetBuilder] ancestor is required for this widget to work.

class AuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<AuthService>(context, listen: false);
    print('should return one of the widgets: home or sign-in');
    return StreamBuilder<CustomUser>(
      stream: _authService.onAuthStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          return user != null ? HomeScreen() : SignInScreen();
        }
        return Scaffold(
          backgroundColor: kSecondaryColor,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
