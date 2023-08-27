import 'package:afia/models/user/user_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/floating_message.dart';

class UserData {
  static String usernme = '';
  static String userEmail = '';
  static String userId = '';
  static String gender = '';
  static DateTime birthday = DateTime.now();
  static double height = 0.0;
  static double weight = 0.0;
  static String weightGoal = '';

  static Future<void> addUserToFirestore() async {
    try {
      // Get a reference to the "users" collection
      final usersCollection = FirebaseFirestore.instance.collection('Users');

      // Create a new user document
      final newUser = {
        'userId': userId,
        'username': usernme,
        'email': userEmail,
        'gender': gender,
        'birthday': birthday,
        'bodyMeasurements': [
          {
            'height': height,
            'weight': weight,
            'date': DateTime.now(),
          },
        ],
        'weightGoals': [
          {
            'weightGoal': weightGoal,
            'date': DateTime.now(),
          },
        ],
      };

      // Add the new user document to the "users" collection
      final docRef = await usersCollection.add(newUser);

      print('User added with ID: ${docRef.id}');
    } catch (error) {
      print('Error adding user: $error');
      rethrow; // Throw the error to be handled by the caller
    }
  }

  static Future<void> addMeasurementToFirestore(
      String userId, double height, double weight) async {
    try {
      // Get a reference to the specific user document
      final userDocument =
          FirebaseFirestore.instance.collection('Users').doc(userId);

      // Create a new measurement object
      final newMeasurement = {
        'height': height,
        'weight': weight,
        'date': DateTime.now(),
      };

      // Update the "bodyMeasurements" array in the user document
      await userDocument.update({
        'bodyMeasurements': FieldValue.arrayUnion([newMeasurement]),
      });

      print('Measurement added to user with ID: $userId');
    } catch (error) {
      print('Error adding measurement: $error');
      rethrow; // Throw the error to be handled by the caller
    }
  }

  static Future<void> updateMeasurementInFirestore(String userId, double height,
      double weight, int year, int month, int day) async {
    try {
      // Get a reference to the specific user document
      final userDocument =
          FirebaseFirestore.instance.collection('Users').doc(userId);

      // Create a new measurement object with updated values
      final updatedMeasurement = {
        'height': height,
        'weight': weight,
        'date': DateTime(year, month, day),
      };

      // Update the "bodyMeasurements" array in the user document
      await userDocument.update({
        'bodyMeasurements': FieldValue.arrayRemove([
          {
            'date': DateTime(year, month, day),
          },
        ]),
      });

      await userDocument.update({
        'bodyMeasurements': FieldValue.arrayUnion([updatedMeasurement]),
      });

      print('Measurement updated for user with ID: $userId');
    } catch (error) {
      print('Error updating measurement: $error');
      rethrow; // Throw the error to be handled by the caller
    }
  }

  static Future<bool> fetchUsersFromFirestore(String id) async {
    try {
      // Fetch user data from Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('userId', isEqualTo: id)
          .get();

      List<CurrentUser> users =
          await Future.wait(querySnapshot.docs.map((doc) async {
        Map<String, dynamic>? userData = doc.data() as Map<String, dynamic>?;

        String userId = doc.id; // Save the user ID
        return CurrentUser(
          userId: userId,
          username: userData!['username'],
          email: userData['email'],
          gender: userData['gender'],
          birthday: userData['birthday'].toDate(),
          bodyMeasurements: List<BodyMeasurement>.from(
            userData['bodyMeasurements'].map(
              (measurement) => BodyMeasurement(
                height: measurement['height'],
                weight: measurement['weight'],
                date: measurement['date'].toDate(),
              ),
            ),
          ),
          weightGoals: List<WeightGoal>.from(
            userData['weightGoals'].map(
              (goal) => WeightGoal(
                weightGoal: goal['weightGoal'],
                date: goal['date'].toDate(),
              ),
            ),
          ),
        );
      }));

      // Assign the first user from the list to currentuser
      if (users.isNotEmpty) {
        currentuser = users.first;
      }
      return true;
    } catch (e) {
      FloatingMessage(message: '$e', durationInSeconds: 4);
      return false;
    }
  }


}
