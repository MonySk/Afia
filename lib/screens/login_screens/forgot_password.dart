import 'package:afia/models/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/app_color.dart';
import '../../widgets/wave_clipper.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  String _verificationId = '';
  String _errorMessage = '';

  void _sendCode() async {
    String email = emailController.text;

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() {
        _verificationId = 'code_sent';
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _verificationId = '';
        _errorMessage = 'هناك خطا في ارسال البريد تأكد من صحة البيانات';
      });
    }
    _navigateBack;
  }

  void _navigateBack() {
    Navigator.pop(context);
  }

  void _resetPassword() async {
    String code = codeController.text;
    String newPassword = newPasswordController.text;

    try {
      await FirebaseAuth.instance.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
      setState(() {
        _verificationId = '';
        _errorMessage = '';
      });
      // Password reset successful, navigate to login screen
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _errorMessage = 'Invalid verification code';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_verificationId.isEmpty) {
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
                        'تسجيل الدخول',
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
            Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/signup/restore_password.png',
                    width: 300,
                    height: 300,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      color: AppTheme.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'أدخل بريدك الإلكتروني',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppTheme.fontName),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintText: 'البريد الإلكتروني',
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'البريد الإلكتروني مطلوب';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: _sendCode,
                              child: const Text('إرسال رابط تغيير كلمة المرور'),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _errorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
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
                        'اعادة تعيين كلمة المرور',
                        style: TextStyle(fontSize: 18.0, color: AppTheme.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Picture of a man talking
                  Center(
                    child: Image.asset(
                      'assets/images/signup/restore_password.png',
                      width: 300,
                      height: 300,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Title text
                  const Text(
                    'تفقد بريدك الالكتروني\nتم ارسال رابط اعادة تعيين كلمة المرور',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 18, fontFamily: AppTheme.fontName),
                  ),
                  const SizedBox(height: 16),
                  // Button to go back
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'العودة لتسجيل الدخول',
                      style: TextStyle(
                          fontSize: 18, fontFamily: AppTheme.fontName),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
