import 'package:afia/screens/logo_screen.dart';
import 'package:flutter/material.dart';

import '../../models/app_color.dart';
import '../../models/app_logic/measurment_validation.dart';
import '../../models/app_theme.dart';
import '../../models/user/current_user.dart';
import '../../models/user/new_user.dart';
import '../../widgets/signing_widgets/wave_clipper.dart';

class UpdateMeasurmentScreen extends StatefulWidget {
  const UpdateMeasurmentScreen({super.key});

  @override
  _UpdateMeasurmentScreenState createState() => _UpdateMeasurmentScreenState();
}

class _UpdateMeasurmentScreenState extends State<UpdateMeasurmentScreen> {
  double _selectedHeight = getUserHeight();
  double _selectedWeight = getUserWeight();

  double newHeight = 0.0;
  double newWeight = 0.0;

  final _formKey = GlobalKey<FormState>();
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
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      onPressed: () {
                        //returnh
                        Navigator.of(context).pop();
                      },
                    ),
                    centerTitle: true,
                    title: const Text(
                      'إضافة قياسات جديدة',
                      style: TextStyle(fontSize: 18.0, color: AppTheme.white),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Rest of the screen content here...
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16.0),
                    Text(
                      'الطول (سم): ${_selectedHeight.round()}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16.0),
                    Slider(
                      value: _selectedHeight,
                      min: 100.0,
                      max: 220.0,
                      divisions: 120,
                      label: _selectedHeight.round().toString(),
                      activeColor: Colors.pink,
                      inactiveColor: Colors.grey[400],
                      onChanged: (double value) {
                        setState(() {
                          _selectedHeight = value;
                        });
                      },
                    ),
                    const SizedBox(height: 50.0),
                    Text(
                      'الوزن (كجم): ${_selectedWeight.round()}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16.0),
                    Slider(
                      value: _selectedWeight,
                      min: 30.0,
                      max: 150.0,
                      divisions: 120,
                      label: _selectedWeight.round().toString(),
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey[400],
                      onChanged: (double value) {
                        setState(() {
                          _selectedWeight = value;
                        });
                      },
                    ),
                    const SizedBox(height: 50.0),
                    ElevatedButton(
                      onPressed: () async {                     
                          newWeight = _selectedWeight;
                          newHeight = _selectedHeight;
                          showConfirmationDialog();
                        }
                      ,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        'اضافة',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// Method to show the dialog box
  void showConfirmationDialog() async{
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد'),
          content: const Text('هل أنت متأكد؟'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('لا'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog box
                Navigator.pop(context); // Pop the current context
              },
            ),
            ElevatedButton(
              child: const Text('نعم'),
              onPressed: () async {
                // Add your code here if the user picks Yes
                if (Validation.isSameDayMonthYear(
                    getUserMaesurmentDate(), DateTime.now())) {
                  try {
                    await UserData.addMeasurementToFirestore(
                        getUserId(), newHeight, newWeight);
                  } catch (e) {}
                } else {
                  try {
                    await UserData.updateMeasurementInFirestore(
                        getUserId(),
                        newHeight,
                        newWeight,
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day);
                  } catch (e) {}
                }
                PopAndPushScreen();
              },
            ),
          ],
        );
      },
    );
  }

  PopAndPushScreen() {
    Navigator.pop(context); // Close the dialog box
    // Push a new screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LogoScreen()),
      (route) => false,
    );
  }
}
