import 'package:flutter/material.dart';

class ReuseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const ReuseButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, height: 3),
      ),
    );
  }
}
