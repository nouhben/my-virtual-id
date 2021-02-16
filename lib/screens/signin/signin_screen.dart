import 'package:best_starter_architecture/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        centerTitle: true,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: RaisedButton.icon(
            label: Text('Sign in'),
            icon: Icon(Icons.login),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () async {
              final usr = await _auth.signInAnon();
              print('user: ${usr.uid}');
            },
          ),
        ),
      ),
    );
  }
}
