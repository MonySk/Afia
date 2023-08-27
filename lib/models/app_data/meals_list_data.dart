import 'package:afia/models/user/current_user.dart';
import 'package:afia/models/user/user_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Meal {
  String userId;
  String imagePath;
  String mealType;
  String mealContent;
  String startColor;
  String endColor;
  DateTime mealTime;

  Meal({
    required this.imagePath,
    required this.startColor,
    required this.endColor,
    required this.mealType,
    required this.userId,
    required this.mealTime,
    required this.mealContent,
  });

  // ... additional methods or functionality ...
}

class MealsListData {
  static List<Meal> mealsList = <Meal>[];

  static Future<bool> fetchUserMealsFromFirestore(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('meals')
          .where('userId', isEqualTo: userId)
          .get();

      List<Meal> updatedMealsList = [];

      for (var doc in querySnapshot.docs) {
        Meal mealData = createMealFromDocument(doc);
        updatedMealsList.add(mealData);
      }

      mealsList = updatedMealsList;
      return true; // Return true to indicate success
    } catch (e) {
      print('Error fetching user meals: $e');
      return false; // Return false to indicate failure
    }
  }

  static Meal createMealFromDocument(
    DocumentSnapshot doc,
  ) {
    String userId = getUserId();
    String mealType = doc['mealType'];
    String imagePath;
    String startColor;
    String endColor;
    DateTime mealTime = (doc['mealTime'] as Timestamp).toDate();
    String mealContent = doc['mealContent'];

    // Assign the appropriate values based on the mealType
    if (mealType == 'افطار') {
      imagePath = 'assets/images/breakfast.png';
      startColor = '#FA7D82';
      endColor = '#FFB295';
    } else if (mealType == 'غذاء') {
      imagePath = 'assets/images/lunch.png';
      startColor = '#738AE6';
      endColor = '#5C5EDD';
    } else if (mealType == 'عشاء') {
      imagePath = 'assets/images/dinner.png';
      startColor = '#6F72CA';
      endColor = '#1E1466';
    } else if (mealType == 'وجبة خفيفة') {
      imagePath = 'assets/images/snack.png';
      startColor = '#FE95B6';
      endColor = '#FF5287';
    } else {
      // Handle any other meal types as needed
      imagePath = 'assets/images/default.png';
      startColor = '#000000';
      endColor = '#000000';
    }

    Meal mealData = Meal(
      imagePath: imagePath,
      startColor: startColor,
      endColor: endColor,
      mealType: mealType,
      userId: userId,
      mealTime: mealTime,
      mealContent: mealContent,
    );

    return mealData;
  }

  static Future<bool> addMealToFirestore(
    String mealType,
    String mealContent,
    String userId,
    DateTime mealTime,
  ) async {
    // Calculate startColor, endColor, and imagePath based on mealType
    Meal newMeal;
    if (mealType == 'افطار') {
      newMeal = breakfastMeal(mealContent);
    } else if (mealType == 'غذاء') {
      newMeal = lunchMeal(mealContent);
    } else if (mealType == 'وجبة خفيفة') {
      newMeal = snackMeal(mealContent);
    } else if (mealType == 'عشاء') {
      newMeal = dinnerMeal(mealContent);
    } else {
      // Invalid mealType
      return false;
    }     
    // Create a new meal document
    Map<String, dynamic> mealData = {
      'userId': userId,
      'mealType': mealType,
      'mealContent': mealContent,
      // 'userEmail': userEmail,
      'mealTime': mealTime,
    };

    try {
      // Add the meal document to the Firestore collection
      await FirebaseFirestore.instance.collection('meals').add(mealData);
      mealsList.add(newMeal);
      // Return true to indicate success
      return true;
    } catch (e) {
      // Return false to indicate failure
      return false;
    }
  }

  static Future<bool> updateMealInFirestore(
    String mealType,
    DateTime mealTime,
    String userId,
    String updatedMealContent,
  ) async {
    try {
      // Query the meals collection based on mealType, mealTime, and userEmail
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('meals')
          .where('mealType', isEqualTo: mealType)
          .where('mealTime', isEqualTo: mealTime)
          .where('userId', isEqualTo: userId)
          .get();

      // Check if any matching documents are found
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first matching document
        DocumentSnapshot mealDocSnapshot = querySnapshot.docs[0];

        // Update the mealContent field of the document
        await mealDocSnapshot.reference
            .update({'mealContent': updatedMealContent});

        // Return true to indicate success
        return true;
      } else {
        // No matching documents found
        return false;
      }
    } catch (e) {
      // Return false to indicate failure
      return false;
    }
  }

  static Meal breakfastMeal(String mealContent) {
    return Meal(
      userId: currentuser.userId,
      imagePath: 'assets/images/breakfast.png',
      mealType: 'افطار',
      mealContent: mealContent,
      startColor: '#FA7D82',
      endColor: '#FFB295',
      mealTime: DateTime.now(),
    );
  }

  static Meal lunchMeal(String mealContent) {
    return Meal(
      userId: currentuser.userId,
      imagePath: 'assets/images/lunch.png',
      mealType: 'غذاء',
      mealContent: mealContent,
      startColor: '#738AE6',
      endColor: '#5C5EDD',
      mealTime: DateTime.now(),
    );
  }

  static Meal snackMeal(String mealContent) {
    return Meal(
      userId: currentuser.userId,
      imagePath: 'assets/images/snack.png',
      mealType: 'وجبة خفيفة',
      mealContent: mealContent,
      startColor: '#FE95B6',
      endColor: '#FF5287',
      mealTime: DateTime.now(),
    );
  }

  static Meal dinnerMeal(String mealContent) {
    return Meal(
      userId: currentuser.userId,
      imagePath: 'assets/images/dinner.png',
      mealType: 'عشاء',
      mealContent: mealContent,
      startColor: '#6F72CA',
      endColor: '#1E1466',
      mealTime: DateTime.now(),
    );
  }

  static List<Meal> getMealsFromToday() {
    DateTime today = DateTime.now();

    List<Meal> mealsFromToday = [];

    // Filtering meals with today's date and matching user email
    mealsFromToday = MealsListData.mealsList.where((meal) {
      // return meal.userEmail == currentuser.email &&
      return meal.mealTime.year == today.year &&
          meal.mealTime.month == today.month &&
          meal.mealTime.day == today.day;
    }).toList();

    List<String> mealTypes = ['افطار', 'غذاء', 'وجبة خفيفة', 'عشاء'];

    // Check if any meal types are missing
    for (String mealType in mealTypes) {
      bool isMealTypePresent = false;
      for (Meal meal in mealsFromToday) {
        if (meal.mealType == mealType) {
          isMealTypePresent = true;
          break;
        }
      }

      if (!isMealTypePresent) {
        switch (mealType) {
          case 'افطار':
            mealsFromToday.add(breakfastMeal('لم تتم الاضافة'));
            break;
          case 'غذاء':
            mealsFromToday.add(lunchMeal('لم تتم الاضافة'));
            break;
          case 'وجبة خفيفة':
            mealsFromToday.add(snackMeal('لم تتم الاضافة'));
            break;
          case 'عشاء':
            mealsFromToday.add(dinnerMeal('لم تتم الاضافة'));
            break;
        }
      }
    }

    return mealsFromToday;
  }

  static List<Meal> getMealsFromUser() {
    return mealsList;
  }

  static Map<DateTime, List<Meal>> getMealsByDateTime() {
    List<Meal> mealsFromUser = getMealsFromUser();
    Map<DateTime, List<Meal>> mealsByDateTime = {};

    for (Meal meal in mealsFromUser) {
      DateTime mealDateTime = DateTime(
        meal.mealTime.year,
        meal.mealTime.month,
        meal.mealTime.day,
      );

      if (!mealsByDateTime.containsKey(mealDateTime)) {
        mealsByDateTime[mealDateTime] = [];
      }

      mealsByDateTime[mealDateTime]!.add(meal);
    }

    return mealsByDateTime;
  }
}
 //   MealsListData(
    //     email: "moniafm.ms@gmail.com",
    //     imagePath: 'assets/images/breakfast.png',
    //     mealType: 'افطار',
    //     kacl: 0,
    //     mealContent: <String>['عصير', 'شريحة توست,', 'تفاحة'],
    //     startColor: '#FA7D82',
    //     endColor: '#FFB295',
    //     mealTime: DateTime(2023, 8, 10),
    //   ),
    //   MealsListData(
    //     email: "moniafm.ms@gmail.com",
    //     imagePath: 'assets/images/lunch.png',
    //     startColor: '#738AE6',
    //     endColor: '#5C5EDD',
    //     mealType: 'غذاء',
    //     kacl: 0,
    //     mealContent: <String>['اللحم,', 'بالخضار,', 'كسكسي'],
    //     mealTime: DateTime(2023, 8, 10),
    //   ),
    //   MealsListData(
    //     email: "moniafm.ms@gmail.com",
    //     imagePath: 'assets/images/snack.png',
    //     startColor: '#FE95B6',
    //     endColor: '#FF5287',
    //     mealType: 'وجبة خفيفة',
    //     kacl: 0,
    //     mealContent: <String>['لم تتم الاضافة'],
    //     mealTime: DateTime(2023, 8, 10),
    //   ),
    //   MealsListData(
    //     email: "moniafm.ms@gmail.com",
    //     imagePath: 'assets/images/dinner.png',
    //     startColor: '#6F72CA',
    //     endColor: '#1E1466',
    //     mealType: 'عشاء',
    //     kacl: 0,
    //     mealContent: <String>['لم تتم الاضافة'],
    //     mealTime: DateTime(2023, 8, 10),
    //   ),
    //   MealsListData(
    //     email: "moniafm.ms@gmail.com",
    //     imagePath: 'assets/images/breakfast.png',
    //     mealType: 'افطار',
    //     kacl: 0,
    //     mealContent: <String>['عصير', 'شريحة توست,', 'تفاحة'],
    //     startColor: '#FA7D82',
    //     endColor: '#FFB295',
    //     mealTime: DateTime(2023, 8, 9),
    //   ),
    //   MealsListData(
    //     email: "moniafm.ms@gmail.com",
    //     imagePath: 'assets/images/lunch.png',
    //     mealType: 'غذاء',
    //     kacl: 0,
    //     mealContent: <String>['و اللحم,', 'بالخضار,', 'كسكسي'],
    //     startColor: '#738AE6',
    //     endColor: '#5C5EDD',
    //     mealTime: DateTime(2023, 8, 9),
    //   ),
    //   MealsListData(
    //     email: "moniafm.ms@gmail.com",
    //     imagePath: 'assets/images/snack.png',
    //     mealType: 'وجبة خفيفة',
    //     kacl: 0,
    //     mealContent: <String>['لم تتم الاضافة'],
    //     startColor: '#FE95B6',
    //     endColor: '#FF5287',
    //     mealTime: DateTime(2023, 8, 9),
    //   ),
    //   MealsListData(
    //     email: "moniafm.ms@gmail.com",
    //     imagePath: 'assets/images/dinner.png',
    //     mealType: 'عشاء',
    //     kacl: 0,
    //     mealContent: <String>['لم تتم الاضافة'],
    //     startColor: '#6F72CA',
    //     endColor: '#1E1466',
    //     mealTime: DateTime(2023, 8, 9),
    //   ),