import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import '../../models/app_logic/measurment_validation.dart';
import '../../models/app_theme.dart';
import '../../models/app_color.dart';
import '../../models/user/new_user.dart';
import '../../widgets/wave_clipper.dart';
import 'sign_up_four.dart';

class SignUpThree extends StatefulWidget {
  const SignUpThree({super.key});

  @override
  _SignUpThreeState createState() => _SignUpThreeState();
}

class _SignUpThreeState extends State<SignUpThree> {
  double _selectedHeight = 170.0;
  double _selectedWeight = 70.0;

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
                      'متابعة إنشاء حساب',
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
                      onPressed: () {
                        if (Validation.isValidWeight(_selectedWeight) &&
                            Validation.isValidHeight(_selectedHeight)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('يرجى ملء الحقول المطلوبة'),
                            ),
                          );
                        } else {
                          print('height = $_selectedHeight');
                          print('width = $_selectedWeight');

                          UserData.height = _selectedHeight;
                          UserData.weight = _selectedWeight;

                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const SignUpFour(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.easeOutCubic;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        'تأكيد',
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
}
