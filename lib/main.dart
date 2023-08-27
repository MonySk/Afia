import 'package:afia/screens/logo_screen.dart';
// import 'package:afia/screens/logo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// import 'screens/login_screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'), // English
        // Locale('en'), // Spanish
      ],
      title: 'عافية',
      debugShowCheckedModeBanner: false,
      home: LogoScreen(),
    );
  }
}
