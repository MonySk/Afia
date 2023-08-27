class BodyMeasurement {
  final double height;
  final double weight;
  final DateTime date;

  BodyMeasurement({
    required this.height,
    required this.weight,
    required this.date,
  });
  Map<String, dynamic> toMap() {
    return {
      'height': height,
      'weight': weight,
      'date': date,
    };
  }
}

class WeightGoal {
  final String weightGoal;
  final DateTime date;

  WeightGoal({
    required this.weightGoal,
    required this.date,
  });
  Map<String, dynamic> toMap() {
    return {
      'weightGoal': weightGoal,
      'date': date,
    };
  }
}

class CurrentUser {
  final String userId;
  final String username;
  final String email;
  final String gender;
  final DateTime birthday;
  final List<BodyMeasurement> bodyMeasurements;
  final List<WeightGoal> weightGoals;

  CurrentUser({
    required this.userId,
    required this.username,
    required this.email,
    required this.gender,
    required this.birthday,
    required this.bodyMeasurements,
    required this.weightGoals,
  });
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'gender': gender,
      'birthday': birthday,
      'bodyMeasurements':
          bodyMeasurements.map((measurement) => measurement.toMap()).toList(),
      'weightGoals': weightGoals.map((goal) => goal.toMap()).toList(),
    };
  }
}

CurrentUser currentuser = CurrentUser(
  userId: '',
  username: '',
  email: ' ',
  gender: ' ',
  birthday: DateTime(1990, 1, 1),
  bodyMeasurements: [
    BodyMeasurement(
      height: 0.0,
      weight: 0.0,
      date: DateTime.now(),
    ),
  ],
  weightGoals: [
    WeightGoal(
      weightGoal: '',
      date: DateTime.now(),
    ),
  ],
);

  // static List<User> users = [];

  // User(
  //   username: "منية",
  //   email: "moniafm.ms@gmail.com",
  //   gender: "انثى",
  //   birthday: DateTime(1990, 5, 15),
  //   bodyMeasurements: [
  //     BodyMeasurement(
  //       height: 1.75,
  //       weight: 70.0,
  //       date: DateTime(2023, 1, 1),
  //     ),
  //     BodyMeasurement(
  //       height: 1.73,
  //       weight: 68.5,
  //       date: DateTime(2023, 2, 1),
  //     ),
  //   ],
  //   weightGoals: [
  //     WeightGoal(
  //       weightGoal: 'lose',
  //       date: DateTime(2023, 1, 15),
  //     ),
  //     WeightGoal(
  //       weightGoal: 'gain',
  //       date: DateTime(2023, 3, 1),
  //     ),
  //   ],
  // ),
  // User(
  //   username: "مونا",
  //   email: "mona1999@gmail.com",
  //   gender: "انثى",
  //   birthday: DateTime(1999, 11, 2),
  //   bodyMeasurements: [
  //     BodyMeasurement(
  //       height: 1.60,
  //       weight: 60.0,
  //       date: DateTime(2023, 8, 13),
  //     ),
  //   ],
  //   weightGoals: [
  //     WeightGoal(
  //       weightGoal: 'gain',
  //       date: DateTime(2023, 8, 13),
  //     ),
  //   ],
  // ),

  // User(
  //   username: "جهاد",
  //   email: "janesmith@gmail.com",
  //   gender: "ذكر",
  //   birthday: DateTime(1988, 9, 20),
  //   bodyMeasurements: [
  //     BodyMeasurement(
  //       height: 1.65,
  //       weight: 58.0,
  //       date: DateTime(2023, 1, 1),
  //     ),
  //     BodyMeasurement(
  //       height: 1.63,
  //       weight: 57.2,
  //       date: DateTime(2023, 2, 1),
  //     ),
  //   ],
  //   weightGoals: [
  //     WeightGoal(
  //       weightGoal: 'maintain',
  //       date: DateTime(2023, 1, 15),
  //     ),
  //     WeightGoal(
  //       weightGoal: 'lose',
  //       date: DateTime(2023, 3, 1),
  //     ),
  //   ],
  // ),
