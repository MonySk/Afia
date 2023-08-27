int calculateCalories(
  int userAge,
  double weight,
  double height,
  String gender,
  String goal,
) {
  double bmr;

  if (gender == 'ذكر') {
    bmr = (10 * weight) + (6.25 * height) - (5 * userAge) + 5;
  } else if (gender == 'انثى') {
    bmr = (10 * weight) + (6.25 * height) - (5 * userAge) - 161;
  } else {
    throw Exception('Invalid gender. Please specify "male" or "female".');
  }

  double calorieIntake = 0.0;

  switch (goal) {
    case 'lose':
      calorieIntake = bmr * 0.8; // Decrease intake by 20%
      break;
    case 'gain':
      calorieIntake = bmr;
      break;
    case 'maintain':
      calorieIntake = bmr * 1.2; // Increase intake by 20%
      break;
  }

  return calorieIntake.toInt();
}
