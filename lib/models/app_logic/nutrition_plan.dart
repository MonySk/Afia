double calculateFat(double userWeight, String userWeightPlan) {
  double fatIntake;

  if (userWeightPlan == "loose") {
    // Calculation for weight loss plan
    // Example: fat intake = 0.25 * userWeight (in grams)
    fatIntake = 0.25 * userWeight;
  } else if (userWeightPlan == "maintain") {
    // Calculation for weight maintenance plan
    // Example: fat intake = 0.3 * userWeight (in grams)
    fatIntake = 0.3 * userWeight;
  } else if (userWeightPlan == "gain") {
    // Calculation for weight gain plan
    // Example: fat intake = 0.35 * userWeight (in grams)
    fatIntake = 0.35 * userWeight;
  } else {
    // Default value if weight plan is not specified
    fatIntake = 0.3 * userWeight;
  }

  // Ensure that the fat intake is within acceptable range (e.g., 20% - 35% of total daily calories)
  double maxFatIntake = 0.35 * userWeight;
  double minFatIntake = 0.2 * userWeight;
  fatIntake = fatIntake.clamp(minFatIntake, maxFatIntake);

  return fatIntake;
}

double calculateCarb(double userWeight, String userWeightPlan) {
  // Carbohydrate calculation logic based on user information
  // Replace with your own calculation formula
  // Example: carbohydrate intake = 3.5 * userWeight (in grams)
  double carbIntake = 3.5 * userWeight;

  // Ensure that the carbohydrate intake is within acceptable range (e.g., 45% - 65% of total daily calories)
  double maxCarbIntake = 0.65 * userWeight;
  double minCarbIntake = 0.45 * userWeight;
  carbIntake = carbIntake.clamp(minCarbIntake, maxCarbIntake);

  return carbIntake;
}

double calculateProtein(double userWeight, String userWeightPlan) {
  // Protein calculation logic based on user information
  // Replace with your own calculation formula
  // Example: protein intake = 1.8 * userWeight (in grams)
  double proteinIntake = 1.8 * userWeight;

  // Ensure that the protein intake is within acceptable range (e.g., 10% - 35% of total daily calories)
  double maxProteinIntake = 0.35 * userWeight;
  double minProteinIntake = 0.1 * userWeight;
  proteinIntake = proteinIntake.clamp(minProteinIntake, maxProteinIntake);

  return proteinIntake;
}
