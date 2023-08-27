import 'package:afia/models/app_theme.dart';
import 'package:flutter/material.dart';

import '../../models/app_data/meals_list_data.dart';
import '../../models/user/current_user.dart';
import '../../widgets/floating_message.dart';

// ignore: must_be_immutable
class EditMealScreen extends StatefulWidget {
  late String mealType;
  late String mealOldContent;
  late DateTime mealTime;
  EditMealScreen({
    Key? key,
    required this.mealType,
    required this.mealTime,
    required this.mealOldContent,
  }) : super(key: key);

  @override
  _EditMealScreenState createState() => _EditMealScreenState();
}

class _EditMealScreenState extends State<EditMealScreen> {
  late String selectedMeal;
  late String mealOldContent;
  String mealNewContent = '';
  late DateTime mealTime;

  @override
  void initState() {
    super.initState();
    selectedMeal = widget.mealType;
    mealOldContent = widget.mealOldContent;
    mealTime = widget.mealTime;
  }

  Future<void> submitMeal() async {
    try {
      if (await MealsListData.updateMealInFirestore(
        selectedMeal,
        mealTime,
        getUserId(),
        mealNewContent,
      )) {
        const FloatingMessage(
            message: 'تمت تعديل الوجبة بنجاح', durationInSeconds: 2);
        MealsListData.fetchUserMealsFromFirestore(getUserId());
        _popScreen();
      }
    } catch (e) {
      print(e);
    }
  }

  _popScreen() {
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).padding.top,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                color: Colors.white,
                // Add your content for the top area here
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 180,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    100 -
                    MediaQuery.of(context).padding.top,
                decoration: const BoxDecoration(
                  color: Color(0xFFCBECA5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 100.0, left: 40, right: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.,
                        children: [
                          const Text(
                            'نوع الوجبة',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppTheme.nearlyDarkGreen,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppTheme.fontName,
                            ),
                          ),
                          const SizedBox(width: 20),
                          //? this is the meal type feils
                          SizedBox(
                            width: 200,
                            height: 50,
                            child: TextFormField(
                              onChanged: (value) {},
                              textAlign: TextAlign.center, // Center the text
                              enabled: false, // Make the text unchangeable
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                hintText: selectedMeal,
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    color: Colors.green,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // the content of meal
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'محتويات الوجبة',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppTheme.nearlyDarkGreen,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppTheme.fontName,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            constraints: const BoxConstraints(
                                maxWidth: 400), // Adjust the width as needed
                            height: 150,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  mealNewContent = value;
                                });
                              },
                              textAlign: TextAlign.center,
                              enabled: true,
                              maxLines: null, // Allow multiple lines of text
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                hintText: mealOldContent,
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    color: Colors.green,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle button tap here
                          // Add your desired functionality or navigation
                          if (mealOldContent == mealNewContent || mealNewContent.isEmpty) {
                            const FloatingMessage(
                              message: 'لم يتغير شيء',
                              durationInSeconds: 2,
                            );
                            return;
                          }
                          submitMeal();
                        },
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppTheme.nearlyDarkGreen,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Center(
                            child: Text(
                              "اضافة الوجبة",
                              style: TextStyle(
                                color: AppTheme.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: AppTheme.fontName,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height : 50),
                      GestureDetector(
                        onTap: () {
                          // Handle button tap here
                          // Add your desired functionality or navigation
                          _popScreen();
                        },
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.nearlyDarkGreen,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Center(
                            child: Text(
                              "الغاء",
                              style: TextStyle(
                                color: AppTheme.nearlyDarkGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: AppTheme.fontName,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 50,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  300, // Adjust the value to position the image vertically
              child: Center(
                child: Container(
                  width: 150, // Adjust the width of the picture container
                  height: 150, // Adjust the height of the picture container
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    image: const DecorationImage(
                      image: AssetImage(
                          'assets/images/meal.png'), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
