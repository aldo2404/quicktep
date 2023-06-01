import 'package:flutter/material.dart';

void showSnackBars(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
