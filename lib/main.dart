import 'package:best_starter_architecture/auth_widget.dart';
import 'package:best_starter_architecture/auth_widget_builder.dart';
import 'package:best_starter_architecture/services/auth_service.dart';
import 'package:best_starter_architecture/services/image_picker_service.dart';
import 'package:best_starter_architecture/shared/custom_theme.dart';
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
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<ImagePickerService>(create: (_) => ImagePickerService()),
      ],
      builder: (context, child) => AuthWidgetBuilder(
        builder: (context, userSnapshot) => MaterialApp(
          //theme: ThemeData(primarySwatch: Colors.indigo),
          theme: themeData(context),
          home: AuthWidget(userSnapshot: userSnapshot),
        ),
      ),
    );
  }
}
