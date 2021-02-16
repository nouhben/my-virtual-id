import 'package:best_starter_architecture/auth_widget.dart';
import 'package:best_starter_architecture/auth_widget_builder.dart';
import 'package:best_starter_architecture/services/auth_service.dart';
import 'package:best_starter_architecture/services/image_picker_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/error.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
//This works but i prefer more control
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialisation = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialisation,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(strokeWidth: 5.0);
        } else {
          if (snapshot.hasError) {
            return ErrorShow(error: snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                Provider<AuthService>(create: (_) => AuthService()),
                Provider<ImagePickerService>(
                  create: (_) => ImagePickerService(),
                ),
              ],
              builder: (context, child) {
                return AuthWidgetBuilder(
                  builder: (context, userSnapshot) {
                    return MaterialApp(
                      theme: ThemeData(primarySwatch: Colors.indigo),
                      home: AuthWidget(userSnapshot: userSnapshot),
                    );
                  },
                );
              },
              child: AuthWidgetBuilder(
                builder: (context, userSnapshot) {
                  return MaterialApp(
                    home: AuthWidget(userSnapshot: userSnapshot),
                  );
                },
              ),
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
