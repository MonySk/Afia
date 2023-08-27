import 'package:afia/screens/logo_screen.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../models/app_color.dart';
import '../../models/app_theme.dart';
import '../../models/user/new_user.dart';
import '../../widgets/floating_message.dart';
import '../../widgets/wave_clipper.dart';

class SignUpFour extends StatefulWidget {
  const SignUpFour({super.key});

  @override
  _SignUpFourState createState() => _SignUpFourState();
}

class _SignUpFourState extends State<SignUpFour> {
  String weightGoal = '';

// Define a global reference to the progress dialog
  ProgressDialog? _progressDialog;

// Function to show the loading indicator
  void showLoadingIndicator(BuildContext context) {
    _progressDialog = ProgressDialog(context);
    _progressDialog!.style(
      message: 'جاري التحميل...',
      progressWidget: const CircularProgressIndicator(),
    );
    _progressDialog!.show();
  }

// Function to hide the loading indicator
  void hideLoadingIndicator() {
    if (_progressDialog != null && _progressDialog!.isShowing()) {
      _progressDialog!.hide();
      _progressDialog = null;
    }
  }

  void selectWeightGoal(String goal) {
    setState(() {
      weightGoal = goal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SingleChildScrollView(
        child: Column(children: [
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
                      style: TextStyle(
                          fontSize: 18.0,
                          color: AppTheme.white,
                          fontFamily: AppTheme.fontName),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'اخيرا رجاء اختر هدفك ',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    selectWeightGoal('lose');
                  },
                  child: CardOption(
                    image: 'assets/images/signup/background.jpg',
                    title: 'إنقاص الوزن',
                    description:
                        'هدفك يتمثل في إنقاص الوزن الزائد وتحسين صحتك العامة.',
                    isSelected: weightGoal == 'lose',
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    selectWeightGoal('gain');
                  },
                  child: CardOption(
                    image: 'assets/images/signup/background.jpg',
                    title: 'زيادة الوزن',
                    description:
                        'هدفك يتمثل في زيادة الوزن بصورة صحية وبناء العضلات.',
                    isSelected: weightGoal == 'gain',
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    selectWeightGoal('maintain');
                  },
                  child: CardOption(
                    image: 'assets/images/signup/background.jpg',
                    title: 'الحفاظ على الوزن',
                    description:
                        'هدفك يتمثل في الحفاظ على وزنك الحالي وتحسين نمط حياتك الصحي.',
                    isSelected: weightGoal == 'maintain',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (weightGoal == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('يرجى ملء الحقول المطلوبة'),
                        ),
                      );
                    } else {
                      print('User weight goal: $weightGoal');

                      UserData.weightGoal = weightGoal;
                      // Perform sign up logic and navigate to the next screen
                      showLoadingIndicator(context);
                      await UserData.addUserToFirestore().then((_) {
                        print('User added successfully');
                        const FloatingMessage(
                            message: 'تمت التسجيل بنجاح', durationInSeconds: 2);
                        hideLoadingIndicator();
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const LogoScreen(),
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
                      }).catchError((error) {
                        print('Error adding user: $error');
                      }); // Hide the loading indicator

                      // ignore: use_build_context_synchronously
                    } // the else braclet
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    minimumSize: const Size(double.infinity, 48),
                    backgroundColor: primaryColor,
                  ),
                  child: const Text(
                    'إرسال',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class CardOption extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool isSelected;

  const CardOption({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            image,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey[800],
                  ),
                ),
                Container(height: 10),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Spacer(),
                    Text(
                      isSelected ? 'تم الاختيار' : 'لم يتم الاختيار',
                      style: TextStyle(
                        color: isSelected ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(height: 5),
        ],
      ),
    );
  }
}
