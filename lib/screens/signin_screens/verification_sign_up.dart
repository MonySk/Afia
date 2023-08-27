import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'sign_up_two.dart';

class VerificationScreen extends StatefulWidget {
  final String email;

  const VerificationScreen(this.email, {super.key});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _verificationCodeController = TextEditingController();
  bool _validCode = true;

  void _verifyCode() async {
    String verificationCode = _verificationCodeController.text.trim();

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null && !user.emailVerified) {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('verification_codes')
            .doc(user.uid)
            .get();

        String storedCode = documentSnapshot['code'];

        if (verificationCode == storedCode) {
          // Verification successful, move to the next screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignUpTwo()),
          );
        } else {
          setState(() {
            _validCode = false;
          });
        }
      } else {
        print('User is already verified or no user is currently signed in.');
      }
    } catch (error) {
      print('Verification error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التحقق'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'أدخل رمز التحقق المرسل إلى البريد الإلكتروني:',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Text(
              widget.email,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _verificationCodeController,
              decoration: InputDecoration(
                labelText: 'رمز التحقق',
                errorText: _validCode ? null : 'رمز التحقق غير صحيح',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _verifyCode,
              child: const Text('تحقق'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> sendVerificationCode(String email) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null && !user.emailVerified) {
      var verificationCode = generateVerificationCode();

      await FirebaseFirestore.instance
          .collection('verification_codes')
          .doc(user.uid)
          .set({'code': verificationCode});

      print('Verification code sent to ${user.email}: $verificationCode');
    } else {
      print('User is already verified or no user is currently signed in.');
    }
  } catch (error) {
    print('Error sending verification code: $error');
  }
}

String generateVerificationCode() {
  var random = Random();
  var code = '';

  for (var i = 0; i < 6; i++) {
    code += random.nextInt(10).toString();
  }

  return code;
}
