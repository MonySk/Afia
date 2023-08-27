import 'package:afia/screens/navigator_drawer_screens/share_app.dart';
import 'package:afia/screens/navigator_drawer_screens/user_profile.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_drawer/drawer_user_controller.dart';
import '../widgets/custom_drawer/home_drawer.dart';
import '../models/app_theme.dart';
import 'navigator_drawer_screens/about_us.dart';
import 'navigator_drawer_screens/feedback_screen.dart';
import 'navigator_drawer_screens/help_screen.dart';
import 'navigator_drawer_screens/home_screen.dart';

// class NavigationDrawer extends StatefulWidget {
//   const NavigationDrawer({super.key});

//   @override
//   State<NavigationDrawer> createState() => _NavigationDrawerState();
// }

// class _NavigationDrawerState extends State<NavigationDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({super.key});

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const HomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.notWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = const HomeScreen();
          });
          break;
        case DrawerIndex.Help:
          setState(() {
            screenView = const HelpScreen();
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            screenView = const FeedbackScreen();
          });
          break;
        case DrawerIndex.UserProfile:
          setState(() {
            screenView = const ProfileScreen();
          });
          break;
        case DrawerIndex.Share:
          setState(() {
            screenView = const ShareApp();
          });
          break;
        case DrawerIndex.About:
          setState(() {
            screenView = const AboutUs();
          });
          break;
        default:
          break;
      }
    }
  }
}
