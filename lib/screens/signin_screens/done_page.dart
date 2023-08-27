import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../introduction_animation_screen.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});
  void signOutAndReturnToIntroductionAnimationScreen(
      BuildContext context) async {
    // Sign out from Firebase
    await FirebaseAuth.instance.signOut();

    // Navigate back to IntroductionAnimationScreen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => const IntroductionAnimationScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("مبروووك!")),
        body: InkWell(
          onTap: () {
            signOutAndReturnToIntroductionAnimationScreen(context);
          },
          child: const Text('hi'),
        ));
  }
}
