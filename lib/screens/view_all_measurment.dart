import 'package:afia/models/app_theme.dart';
import 'package:afia/screens/add_data_screens/update_measurment_screen.dart';
import 'package:flutter/material.dart';

import '../models/user/user_class.dart';

class ViewAllMeasurment extends StatelessWidget {
  const ViewAllMeasurment({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // No elevation
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppTheme.nearlyDarkGreen,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'مراجعة كل القياسات',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: AppTheme.fontName,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UpdateMeasurmentScreen()),
          );
        },
        backgroundColor: AppTheme.greenLight,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 386,
          height: 835,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 386,
                height: 455,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 30,
                        left: 22,
                        right: 11,
                        bottom: 7,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'التاريخ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 96),
                          Text(
                            'الطول',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 96),
                          Text(
                            'الوزن',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      width: screenWidth,
                      child: ListView.builder(
                        itemCount: currentuser.bodyMeasurements.length,
                        itemBuilder: (context, index) {
                          BodyMeasurement measurement =
                              currentuser.bodyMeasurements[index];
                          return Container(
                            width: 386,
                            height: 61,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Stack(
                              children: [
                                Positioned(
                                  // left: 23,
                                  // top: 30,
                                  left: 310,
                                  top: 30,
                                  child: Text(
                                    '${measurement.date.day}/${measurement.date.month}/${measurement.date.year}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 181,
                                  top: 30,
                                  child: Text(
                                    '${measurement.height} سم',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // left: 331,
                                  // top: 30,
                                  left: 23,
                                  top: 30,
                                  child: Text(
                                    '${measurement.weight} كجم',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: 500,
                  height: 311,
                  padding: const EdgeInsets.only(right: 92),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth *
                            0.5, // Adjust the multiplier as needed
                        height: screenWidth *
                            0.5, // Adjust the multiplier as needed
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage("assets/images/measure_woman.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
