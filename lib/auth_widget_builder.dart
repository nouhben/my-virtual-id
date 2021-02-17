import 'package:best_starter_architecture/models/custom_user.dart';
import 'package:best_starter_architecture/services/auth_service.dart';
import 'package:best_starter_architecture/services/firebase_storage_service.dart';
import 'package:best_starter_architecture/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Used to create user-dependant objects that need to be accessible by all widgets.
/// This widget should live above the [MaterialApp].
/// See [AuthWidget], a descendant widget that consumes the snapshot generated by this builder.

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<CustomUser>) builder;

  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<AuthService>(context, listen: false);
    print('AuthWidgetBuilder: build');
    return StreamBuilder<CustomUser>(
      stream: _authService.onAuthStateChanges,
      builder: (context, snapshot) {
        final CustomUser user = snapshot.data;
        if (user != null) {
          return MultiProvider(
            providers: [
              Provider<CustomUser>.value(value: user),
              Provider<FirestoreService>(
                create: (_) => FirestoreService(uid: user.uid),
              ),
              Provider<FirebaseStorageService>(
                create: (_) => FirebaseStorageService(uid: user.uid),
              ),
            ],
            child: builder(context, snapshot), //HomeScreen(),
          );
        }
        return builder(context, snapshot); //SignInScreen();
      },
    );
  }
}
