import 'package:afia/models/app_theme.dart';
import 'package:flutter/material.dart';

class FloatingMessage extends StatelessWidget {
  final String message;
  final int durationInSeconds;

  const FloatingMessage({super.key, required this.message, required this.durationInSeconds});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return ElevatedButton(
          child: const Text('Show Floating Message'),
          onPressed: () {
            final snackBar = SnackBar(
              content: Text(message, style: const TextStyle(fontFamily: AppTheme.fontName, fontSize: 10,),),
              backgroundColor: AppTheme.nearlyDarkGreen.withOpacity(0.7),
              duration: Duration(seconds: durationInSeconds),
              behavior: SnackBarBehavior.floating,
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        );
      },
    );
  }
}
