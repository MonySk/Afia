class Validation {
  static bool isValidWeight(double weight) {
    // Define acceptable weight range
    const double minWeight = 20;
    const double maxWeight = 200;

    return weight >= minWeight && weight <= maxWeight;
  }

  static bool isValidHeight(double height) {
    // Define acceptable height range
    const double minHeight = 55;
    const double maxHeight = 272;

    return height >= minHeight && height <= maxHeight;
  }
  static bool isSameDayMonthYear(DateTime date1, DateTime date2) {
    int day1 = date1.day;
    int month1 = date1.month;
    int year1 = date1.year;

    int day2 = date2.day;
    int month2 = date2.month;
    int year2 = date2.year;

    return (day1 == day2 && month1 == month2 && year1 == year2);
  }
}
