import 'package:best_starter_architecture/providers/theme_provider.dart';
import 'package:best_starter_architecture/shared/constants.dart';
import 'package:best_starter_architecture/shared/custom_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Card(
            margin: EdgeInsets.all(30),
            elevation: 3.0,
            child: Text(
              snapshot.error.toString(),
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider(
            create: (context) => MyThemeProvider(),
            child: Consumer<MyThemeProvider>(
              builder: (_, theme, __) => MaterialApp(
                title: 'Flutter Demo',
                theme: themeData(context),
                darkTheme: darkThemeData(context),
                themeMode:
                    theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
                home: ChangeNotifierProvider<ValueNotifier<int>>(
                  create: (context) => ValueNotifier(0),
                  builder: (context, child) =>
                      MyHomePage(title: 'Flutter Provider Starter'),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<ValueNotifier<int>>(context, listen: false);
    // ignore: unused_local_variable
    final theme = Provider.of<MyThemeProvider>(context);
    print('re-building...');
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<ValueNotifier<int>>(
              builder: (_, _counter, __) => Text(
                '${_counter.value}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            StreamBuilder(
              stream: Stream.fromIterable([100, 1, 10, 30, 50]),
              builder: (context, snapshot) => Card(
                child: Text(snapshot.data.toString()),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () => counter.value++,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

/**
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyThemeProvider(),
      child: Consumer<MyThemeProvider>(
        builder: (_, theme, __) => MaterialApp(
          title: 'Flutter Demo',
          theme: themeData(context),
          darkTheme: darkThemeData(context),
          themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
          home: ChangeNotifierProvider<ValueNotifier<int>>(
            create: (context) => ValueNotifier(0),
            builder: (context, child) =>
                MyHomePage(title: 'Flutter Provider Starter'),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<ValueNotifier<int>>(context, listen: false);
    // ignore: unused_local_variable
    final theme = Provider.of<MyThemeProvider>(context);
    print('re-building...');
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<ValueNotifier<int>>(
              builder: (_, _counter, __) => Text(
                '${_counter.value}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            StreamBuilder(
              stream: Stream.fromIterable([100, 1, 10, 30, 50]),
              builder: (context, snapshot) => Card(
                child: Text(snapshot.data.toString()),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () => counter.value++,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

 * 
 * 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyThemeProvider(),
      child: Consumer<MyThemeProvider>(
        builder: (_, theme, __) => MaterialApp(
          title: 'Flutter Demo',
          theme: themeData(context),
          darkTheme: darkThemeData(context),
          themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
          home: ChangeNotifierProvider<CounterProvider>(
            create: (context) => CounterProvider(),
            builder: (context, child) =>
                MyHomePage(title: 'Flutter Provider Starter'),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterProvider>(context, listen: false);
    final theme = Provider.of<MyThemeProvider>(context);
    print('re-building...');
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<CounterProvider>(
              builder: (_, _counter, __) => Text(
                '${_counter.count}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () => counter.increment(),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () => theme.toggleTheme(),
            tooltip: 'Increment',
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

 */
