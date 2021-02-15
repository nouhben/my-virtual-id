import 'package:flutter/material.dart';

@immutable
class CustomUser {
  const CustomUser({
    this.name,
    this.email,
    @required this.uid,
  });
  final String name, email, uid;
}
