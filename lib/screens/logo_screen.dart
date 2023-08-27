import 'package:afia/models/app_data/meals_list_data.dart';
import 'package:afia/models/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../models/user/new_user.dart';
import 'introduction_animation_screen.dart';
import 'navigation_home_screen.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({Key? key}) : super(key: key);

  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  // ignore: unused_field
  late Animation<double> _animation;

  bool isLoading = true;
  bool isUserSignedIn = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    _animationController.forward();
    initializeFirebaseAndCheckUserSignedIn();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> initializeFirebaseAndCheckUserSignedIn() async {
    await Firebase.initializeApp(); // Initialize Firebase

    final firebaseAuth = FirebaseAuth.instance;
    final currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      setState(() {
        isUserSignedIn = true;
      });
      await fetchDataFromFirebase(currentUser.uid);
    } else {
      setState(() {
        isLoading = false;
      });
      navigateToIntroScreen();
    }
  }

  Future<void> fetchDataFromFirebase(String userid) async {
    await MealsListData.fetchUserMealsFromFirestore(userid);
    await UserData.fetchUsersFromFirestore(userid);

    // Simulate loading delay
    await Future.delayed(const Duration(seconds: 2));

    // Once fetching is done, navigate to the appropriate screen
    if (mounted) {
      navigateToNextScreen();
    }
  }

  void navigateToIntroScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const IntroductionAnimationScreen(),
        ),
      );
    });
  }

  void navigateToNextScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const NavigationHomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLoading ? AppTheme.greenLight : AppTheme.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/colored_logo.png',
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.white),
            ),
          ],
        ),
      ),
    );
  }
}
