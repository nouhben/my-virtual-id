import 'package:best_starter_architecture/providers/theme_provider.dart';
import 'package:best_starter_architecture/shared/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

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
