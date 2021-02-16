import 'package:best_starter_architecture/auth_widget.dart';
import 'package:best_starter_architecture/screens/signin/signin_screen.dart';
import 'package:best_starter_architecture/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (_) => AuthService(),
      builder: (context, child) => MaterialApp(
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: AuthWidget(),
      ),
      // child: MaterialApp(
      //   theme: ThemeData(primarySwatch: Colors.indigo),
      //   home: AuthWidget(),
      // ),
    );
  }
}
