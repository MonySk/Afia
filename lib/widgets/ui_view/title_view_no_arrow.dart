import 'package:flutter/material.dart';

import '../../models/app_theme.dart';

class TitleViewNoArrow extends StatelessWidget {
  final String titleTxt;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final TextDirection textDirection;

  const TitleViewNoArrow({
    Key? key,
    required this.titleTxt,
    this.animationController,
    this.animation,
    this.textDirection = TextDirection.rtl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0,
              30 * (1.0 - animation!.value),
              0.0,
            ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        titleTxt,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          color: AppTheme.lightText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
