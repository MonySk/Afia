import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/app_theme.dart';
import '../../models/app_color.dart';
import '../../models/user/current_user.dart';
import '../../models/user/new_user.dart';
import '../../widgets/wave_clipper.dart';
import 'sign_up_two.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Define the controllers for the name, email, and password fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Define variables to hold the validation status of each field
  bool _nameValid = true;
  bool _emailValid = true;
  bool _passwordValid = true;

  // Define variables to hold the user input
  String _name = '';
  String _email = '';
  String _password = '';

  // Define a boolean variable to check if all fields are valid
  bool _isAllValid = false;

  @override
  void initState() {
    super.initState();

    // Add listeners to the text controllers to update the validation status
    // whenever the user types something in the fields
    _nameController.addListener(_updateNameValid);
    _emailController.addListener(_updateEmailValid);
    _passwordController.addListener(_updatePasswordValid);
  }

  @override
  void dispose() {
    // Remove the listeners to prevent memory leaks
    _nameController.removeListener(_updateNameValid);
    _emailController.removeListener(_updateEmailValid);
    _passwordController.removeListener(_updatePasswordValid);

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _updateNameValid() {
    setState(() {
      _nameValid = _nameController.text.isNotEmpty;
      _name = _nameController.text;
      _isAllValid = _nameValid && _emailValid && _passwordValid;
    });
  }

  void _updateEmailValid() {
    setState(() {
      _emailValid = _emailController.text.contains('@');
      _email = _emailController.text;
      _isAllValid = _nameValid && _emailValid && _passwordValid;
    });
  }

  void _updatePasswordValid() {
    setState(() {
      _passwordValid = _passwordController.text.length >= 6;
      _password = _passwordController.text;
      _isAllValid = _nameValid && _emailValid && _passwordValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar:
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
                      'انشاء حساب',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: AppTheme.white,
                          fontFamily: AppTheme.fontName),
                    ),
                  ),
                ),
              ),
              // Rest of the screen content here...
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Add the image and text
                  Image.asset(
                    'assets/images/signup/register.png',
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                  // Add the name field
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'الاسم',
                      hintText: 'ادخل الاسم الخاص بك',
                      errorText: _nameValid ? null : 'الرجاء ادخال اسم صحيح',
                      prefixIcon:
                          const Icon(Icons.person_outline, color: primaryColor),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),

                  // Add the email field
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'البريد الالكتروني',
                      hintText: 'ادخل البريد الالكتروني الخاص بك',
                      errorText: _emailValid
                          ? null
                          : 'الرجاء ادخال بريد الكتروني صحيح',
                      prefixIcon:
                          const Icon(Icons.email_outlined, color: primaryColor),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),

                  // Add the password field
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور',
                      hintText: 'ادخل كلمة المرور الخاصة بك',
                      errorText: _passwordValid
                          ? null
                          : 'الرجاء ادخال كلمة مرور صحيحة (6 احرف على الاقل)',
                      prefixIcon:
                          const Icon(Icons.lock_outline, color: primaryColor),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    obscureText: true,
                  ),

                  // Add the submit button
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: _isAllValid
                        ? () async {
                            // Handle the form submission
                            print('Name: $_name');
                            print('Email: $_email');
                            currenUserEmail = _email;
                            //* get user Email to use it
                            //useremail = _email;
                            print('Password: $_password');
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                email: _email,
                                password: _password,
                              );
                              UserData.userId = userCredential.user!.uid;
                              UserData.usernme = _name;
                              UserData.userEmail = _email;

                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const SignUpTwo(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.easeOutCubic;
                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);
                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            } catch (e) {
                              print('User sign up failed: $e');
                            }
                            // // Clear the form fields
                            // _nameController.clear();
                            // _emailController.clear();
                            // _passwordController.clear();

                            // Set the validation status to false
                          }
                        : _showIncompleteFormPopup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ), // Disable the button if not all fields are valid
                    child: const Text('انشاء حساب'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void _navigateToSignUpTwo() {}

  void _showIncompleteFormPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text(
          'اكمل استيفاء جميع المتطلبات',
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
