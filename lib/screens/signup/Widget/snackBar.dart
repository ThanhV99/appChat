import 'package:flutter/material.dart';

void showSnackBar(context, value, color){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(value, style: TextStyle(fontSize: 14)),
    backgroundColor: color,
    duration: const Duration(seconds: 4),
    action: SnackBarAction(label: "OK", onPressed: (){}, textColor: Colors.white),
  ));
}