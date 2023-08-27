import 'package:afia/screens/navigator_drawer_screens/user_profile.dart';
import 'package:flutter/material.dart';

import '../models/app_theme.dart';
import '../models/app_data/tabIcon_data.dart';

import '../widgets/bottom_navigation_view/bottom_bar_view.dart';
import '../widgets/fitness_main_widgets/my_diary_screen.dart';
import 'training/training_screen.dart';

class FitnessAppHomeScreen extends StatefulWidget {
  const FitnessAppHomeScreen({super.key});

  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.white,
  );

  @override
  void initState() {
    //tabIconsList.reversed;
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }

    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    // if (await NewUser.fetchUsersFromFirestore(currenUserEmail)) {
    //   MealsListData.fetchUserMealsFromFirestore(currenUserEmail);
    //   print('done==');
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text('لم ننجح'),
    //     backgroundColor: Colors.red,
    //   ));
    // }
    return true;
  }

  Widget bottomBar() {
    return Column(
      textDirection: TextDirection.ltr,
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0 || index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyDiaryScreen(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      TrainingScreen(animationController: animationController);
                });
              });
            } else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = const ProfileScreen();
                });
              });
            }
          },
        ),
      ],
    );
  }
}
