import 'package:flutter/material.dart';
import '../../models/app_color.dart';
import '../../models/app_theme.dart';
import '../../models/user/current_user.dart';
import '../../widgets/signing_widgets/wave_clipper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ),
              ),
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: const Text(
                  'الملف الشخصي',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: AppTheme.white,
                      fontFamily: AppTheme.fontName),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 100,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.person_outline, color: Colors.green[600]),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 132, 191, 60)),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: ' ${getUserName()}',
                      fillColor: Colors.grey[30],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 2, // Adjust the width value as needed
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: TextFormField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email,
                          color: Color.fromARGB(255, 132, 191, 60)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: getUserEmail(),
                      fillColor: Colors.grey[30],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 2, // Adjust the width value as needed
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock,
                          color: Color.fromARGB(255, 132, 191, 60)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: 'كلمة المرور القديمة',
                      fillColor: Colors.grey[30],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 2, // Adjust the width value as needed
                        ),
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock,
                          color: Color.fromARGB(255, 132, 191, 60)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: 'كلمة المرور الجديدة',
                      fillColor: Colors.grey[30],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 2, // Adjust the width value as needed
                        ),
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock,
                          color: Color.fromARGB(255, 132, 191, 60)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: '  تأكيد كلمة المرور الجديدة',
                      fillColor: Colors.grey[30],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 2, // Adjust the width value as needed
                        ),
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 70),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 132, 191, 60),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        "حفظ",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: AppTheme.fontName),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Container(
                //   width: 100,
                //   height: 50,
                //   decoration: BoxDecoration(
                //     color: Color.fromARGB(255, 132, 191, 60),
                //     borderRadius: BorderRadius.circular(25),
                //   ),
                //   child: Center(
                //     child: Text(
                //       "الغاء",
                //       style: TextStyle(
                //           color: Colors.white,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 16,
                //           fontFamily: AppTheme.fontName),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
