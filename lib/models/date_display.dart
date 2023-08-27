import 'package:intl/intl.dart';

class DateDisplay {
  DateDisplay();
  

static String formateDateToArabicNoYear(DateTime dateTime) {
  final formatter = DateFormat('dd - MMMM', 'ar');
  String formattedDate = formatter.format(dateTime);

  // Convert Arabic numerals to English numerals
  formattedDate = formattedDate.replaceAll('٠', '0')
                               .replaceAll('١', '1')
                               .replaceAll('٢', '2')
                               .replaceAll('٣', '3')
                               .replaceAll('٤', '4')
                               .replaceAll('٥', '5')
                               .replaceAll('٦', '6')
                               .replaceAll('٧', '7')
                               .replaceAll('٨', '8')
                               .replaceAll('٩', '9');

  return formattedDate;
}

static String formateDateToArabic(DateTime dateTime) {
  final formatter = DateFormat('dd - MMMM - yyyy', 'ar');
  String formattedDate = formatter.format(dateTime);

  // Convert Arabic numerals to English numerals
  formattedDate = formattedDate.replaceAll('٠', '0')
                               .replaceAll('١', '1')
                               .replaceAll('٢', '2')
                               .replaceAll('٣', '3')
                               .replaceAll('٤', '4')
                               .replaceAll('٥', '5')
                               .replaceAll('٦', '6')
                               .replaceAll('٧', '7')
                               .replaceAll('٨', '8')
                               .replaceAll('٩', '9');

  return formattedDate;
}
  static String mealHour(DateTime dateTime) {
    // Format the time in 12-hour clock format with AM/PM indicator
    final time = DateFormat.jm().format(dateTime);

    // Extract the hours and minutes from the formatted time
    final parts = time.split(':');
    var hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1].split(' ')[0]);

    // Determine if it's AM or PM based on the indicator
    final indicator = parts[1].split(' ')[1];

    // Adjust the hours if it's PM
    if (indicator == 'مساء' && hours != 12) {
      hours += 12;
    } else if (indicator == 'صباحًا' && hours == 12) {
      hours = 0;
    }

    // Format the hours and minutes as a string
    final formattedHours = hours.toString().padLeft(2, '0');
    final formattedMinutes = minutes.toString().padLeft(2, '0');

    // Return the formatted time as 'hh:mm' string with the indicator
    return '$formattedHours:$formattedMinutes $indicator';
  }
}

  // String get todayDate {
  //   String day = DateTime.now().day.toString();

  //   int currentMonth = DateTime.now().month;
  //   late String monthInAR;

  //   switch (currentMonth) {
  //     case DateTime.january:
  //       monthInAR = 'يناير';
  //       break;
  //     case DateTime.february:
  //       monthInAR = 'فبراير';
  //       break;
  //     case DateTime.march:
  //       monthInAR = 'مارس';
  //       break;
  //     case DateTime.april:
  //       monthInAR = 'ابريل';
  //       break;
  //     case DateTime.may:
  //       monthInAR = 'مايو';
  //       break;
  //     case DateTime.june:
  //       monthInAR = 'يونيو';
  //       break;
  //     case DateTime.july:
  //       monthInAR = 'يوليو';
  //       break;
  //     case DateTime.august:
  //       monthInAR = 'آغسطس';
  //       break;
  //     case DateTime.september:
  //       monthInAR = 'سبتمبر';
  //       break;
  //     case DateTime.october:
  //       monthInAR = 'أكتوبر';
  //       break;
  //     case DateTime.november:
  //       monthInAR = 'نوفمبر';
  //       break;
  //     case DateTime.december:
  //       monthInAR = 'ديسمبر';
  //       break;
  //   }
  //   return '$day $monthInAR';
  // }
 
  // static String formatDate(DateTime inputDate) {
  //   String day = inputDate.day.toString().padLeft(2, '0');
  //   String month = inputDate.month.toString().padLeft(2, '0');
  //   String year = inputDate.year.toString();

  //   return '$day/$month/$year';
  // }
  //---------