import 'package:afia/models/app_theme.dart';
import 'package:flutter/material.dart';
import '../models/app_color.dart';
import '../models/app_data/meals_list_data.dart';
import '../models/date_display.dart';
import '../models/hexcolor.dart';
import '../widgets/signing_widgets/wave_clipper.dart';

class ViewAllMealsScreen extends StatelessWidget {
  final Map<DateTime, List<Meal>> mealsByDateTime =
      MealsListData.getMealsByDateTime();
  ViewAllMealsScreen({super.key});

  _getMealHour(DateTime mealTime) {
    DateDisplay.mealHour(mealTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryStartColor, primaryEndColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      onPressed: () {
                        //returnh
                        Navigator.of(context).pop();
                      },
                    ),
                    centerTitle: true,
                    title: const Text(
                      'جميع الوجبات',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: AppTheme.white,
                          fontFamily: AppTheme.fontName),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mealsByDateTime.length,
              itemBuilder: (context, index) {
                DateTime mealDateTime = mealsByDateTime.keys.elementAt(index);
                List<Meal> meals = mealsByDateTime.values.elementAt(index);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateDisplay.formateDateToArabic(
                            mealDateTime), // Replace with desired title format
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppTheme.fontName),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: meals.length,
                      itemBuilder: (context, index) {
                        Meal meal = meals[index];

                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                HexColor(meal.startColor),
                                HexColor(meal.endColor),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Card(
                            child: ListTile(
                              leading: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                      width:
                                          8), // Add some spacing between kcal number and image
                                  Image.asset(
                                    meal.imagePath,
                                    width: 60,
                                    height: 60,
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                meal.mealContent,
                                style: const TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
