import 'package:afia/models/user/user_class.dart';
import 'package:age_calculator/age_calculator.dart';

import '../../widgets/floating_message.dart';
import '../app_logic/calory_plan.dart';
import '../app_logic/nutrition_plan.dart';

late String currenUserEmail;
late String currenUserId;


// String getUserNameByEmail(String userEmail) {
//   // User user = getUserByEmail(userEmail);
//   return currentuser!.username;
// }

String getUserGenderByEmail() {
  // User user = getUserByEmail(userEmail);
  return currentuser.gender;
}

String getUserEmail() {
  if (currentuser.email != '') {
    return currentuser.email;
  } else {
    const FloatingMessage(
        message: 'هناك مشكلة في جلب البيانات', durationInSeconds: 2);
    return '';
  }
}

String getUserId() {
  if (currentuser.userId != '') {
    return currentuser.userId;
  } else {
    const FloatingMessage(
        message: 'هناك مشكلة في جلب البيانات', durationInSeconds: 2);
    return '';
  }
}
String getUserName() {
  if (currentuser.username != '') {
    return currentuser.username;
  } else {
    throw Exception("No user found with email ${currentuser.email}");
  }
}
 getUserMaesurmentDate() {
  if (currentuser.username != '') {
    return currentuser.bodyMeasurements.last.date;
  } else {
    throw Exception("No user found with email ${currentuser.email}");
  }
}
double getUserHeight() {
  if (currentuser.username != '') {
    return currentuser.bodyMeasurements.last.height;
  } else {
    throw Exception("No user found with email ${currentuser.email}");
  }
}
double getUserWeight() {
  if (currentuser.username != '') {
    return currentuser.bodyMeasurements.last.weight;
  } else {
    throw Exception("No user found with email ${currentuser.email}");
  }
}

int getAge() {
  return AgeCalculator.age(currentuser.birthday).years;
}

String getUserGoalByEmail() {
  // User user = getUserByEmail(userEmail);
  return currentuser.weightGoals.last.weightGoal;
}

int getUserCaloryplan() {
  try {
    double height = currentuser.bodyMeasurements.last.height;
    double weight = currentuser.bodyMeasurements.last.weight;
    String weightGoal = currentuser.weightGoals.last.weightGoal;

    int userAge = getAge();
    return calculateCalories(
        userAge, weight, height, currentuser.gender, weightGoal);
  } catch (e) {
    throw Exception("No user found with email ${currentuser.email}");
  }
}

double getUserFatData() {
  try {
    double weight = currentuser.bodyMeasurements.last.weight;
    String weightGoal = currentuser.weightGoals.last.weightGoal;

    return calculateFat(weight, weightGoal);
  } catch (e) {
    throw Exception("No user found with email ${currentuser.email}");
  }
}

double getUserCarbData() {
  try {
    double weight = currentuser.bodyMeasurements.last.weight;
    String weightGoal = currentuser.weightGoals.last.weightGoal;

    return calculateCarb(weight, weightGoal);
  } catch (e) {
    throw Exception("No user found with email ${currentuser.email}");
  }
}

double getUserProteinData() {
  try {
    double weight = currentuser.bodyMeasurements.last.weight;
    String weightGoal = currentuser.weightGoals.last.weightGoal;

    return calculateProtein(weight, weightGoal);
  } catch (e) {
    throw Exception("No user found with email ${currentuser.email}");
  }
}

double getUserBmi() {
  double heightInCentimeters = currentuser.bodyMeasurements.last.height;
  double weightInKilograms = currentuser.bodyMeasurements.last.weight;

  // Convert height from centimeters to meters
  double heightInMeters = heightInCentimeters / 100.0;

  double bmi = weightInKilograms / (heightInMeters * heightInMeters);

  var result = double.parse(bmi.toStringAsFixed(2));

  return result;
}

// int calculateBMR(String userEmail) {
double calculateHealthyWeight() {
  // Convert height from centimeters to meters
  double heightInMeters = currentuser.bodyMeasurements.last.height / 100;

  // Define BMI ranges for different genders
  final maleBMI = [20.7, 26.4];
  final femaleBMI = [19.1, 25.8];

  // Calculate healthy weight range based on gender
  List<double> bmiRange = [];
  if (currentuser.gender == 'ذكر') {
    bmiRange = maleBMI;
  } else if (currentuser.gender == 'انثى') {
    bmiRange = femaleBMI;
  }

  // Calculate the healthy weight range
  double lowerWeight = bmiRange[0] * heightInMeters * heightInMeters;
  double upperWeight = bmiRange[1] * heightInMeters * heightInMeters;

  // Return the healthy weight range
  return (lowerWeight + upperWeight) / 2;
}

int calculateHealthySleepDuration() {
  int age = getAge();
  // Define age ranges and corresponding healthy sleep durations
  final ageRanges = [0, 3, 12, 18, 65];
  final sleepDurations = [14, 12, 8, 7, 7];

  // Find the appropriate sleep duration based on the user's age
  int index = ageRanges.indexWhere((range) => age < range);
  if (index == -1) {
    index = ageRanges.length - 1;
  }

  // Return the healthy sleep duration in hours
  return sleepDurations[index];
}
