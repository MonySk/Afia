import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/app_theme.dart';

import '../../models/app_color.dart';
import '../../models/user/new_user.dart';
import '../../widgets/wave_clipper.dart';
import 'sign_up_three.dart';

class SignUpTwo extends StatefulWidget {
  const SignUpTwo({super.key});

  @override
  _SignUpTwoState createState() => _SignUpTwoState();
}

class _SignUpTwoState extends State<SignUpTwo> {
  String _selectedSex = '';
  DateTime _selectedDate = DateTime.now();

  final _formKey = GlobalKey<FormState>();
  bool _isAllValid = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

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
                    const Text(
                      'الجنس',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSex = 'انثى';
                            });
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/signup/female.png',
                                height: 60.0,
                                width: 60.0,
                                color: _selectedSex == 'انثى'
                                    ? girl_color
                                    : Colors.grey,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'أنثى',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedSex == 'انثى'
                                      ? girl_color
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSex = 'ذكر';
                            });
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/signup/male.png',
                                height: 60.0,
                                width: 60.0,
                                color: _selectedSex == 'ذكر'
                                    ? boy_color
                                    : Colors.grey,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'ذكر',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedSex == 'ذكر'
                                      ? boy_color
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100.0),
                    const Text(
                      'تاريخ الميلاد',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('yyyy-MM-dd').format(_selectedDate),
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    ElevatedButton(
                      onPressed: () {
                        _isAllValid = _formKey.currentState!.validate();
                        if (_selectedSex.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('يرجى اختيار الجنس'),
                            ),
                          );
                          _isAllValid = false;
                        } else if (_calculateAge(_selectedDate) < 13) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('يجب أن يكون عمرك أكبر من 13 عامًا'),
                            ),
                          );
                          _isAllValid = false;
                        }
                        if (!_isAllValid) {
                          return;
                        }
                        print('selected sex$_selectedSex');
                        print('selected bday$_selectedDate');
                        UserData.gender = _selectedSex;
                        UserData.birthday = _selectedDate;
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const SignUpThree(),
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

                        //done
                      },
                      //...
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

  int _calculateAge(DateTime date) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - date.year;
    if (currentDate.month < date.month ||
        (currentDate.month == date.month && currentDate.day < date.day)) {
      age--;
    }
    return age;
  }

  void _showIncompleteFormPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text(
          ' اكمل استيفاء جميع المتطلبات',
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            child: const Text('حسنا'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
