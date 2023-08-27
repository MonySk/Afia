import 'package:flutter/material.dart';

import '../../models/app_theme.dart';

class GreetingView extends StatefulWidget {
  final AnimationController animationController;

  const GreetingView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _GreetingViewState createState() => _GreetingViewState();
}

class _GreetingViewState extends State<GreetingView> {
  @override
  Widget build(BuildContext context) {
    final introductionanimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: introductionanimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 100,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                //! change it to app logo
                child: Image.asset(
                  'assets/introduction_animation/afia_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 8.0),
              child: Text(
                "مرحبا بك",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 64, right: 64, top: 15),
              child: Text(
                "مرحبًا بك في تطبيق عافية، التطبيق الذي سيساعدك في العناية بصحتك ورفاهيتك بطريقة سهلة ومريحة",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: AppTheme.fontName),
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              child: InkWell(
                onTap: () {
                  widget.animationController.animateTo(0.2);
                },
                child: Container(
                  height: 58,
                  padding: const EdgeInsets.only(
                    left: 56.0,
                    right: 56.0,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38.0),
                      color: AppTheme.greenLight // const Color(0xff132137),
                      ),
                  child: const Text(
                    "لنبدأ",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppTheme.white,
                      fontFamily: AppTheme.fontName,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
