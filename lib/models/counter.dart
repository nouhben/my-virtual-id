import 'package:flutter/foundation.dart';

class CounterProvider with ChangeNotifier {
  int count = 0;
  void increment() {
    this.count++;
    notifyListeners();
  }

  void decrement() {
    this.count--;
    notifyListeners();
  }
}
