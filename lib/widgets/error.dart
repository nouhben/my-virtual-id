import 'package:flutter/material.dart';

class ErrorShow extends StatelessWidget {
  final String error;
  const ErrorShow({
    Key key,
    @required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(30),
      elevation: 3.0,
      child: Text(
        this.error,
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
