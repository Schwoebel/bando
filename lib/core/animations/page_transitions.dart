import 'package:animations/animations.dart';
import 'package:flutter/material.dart';


class PageRoutes extends PageRouteBuilder{
  static double kDefaultDuration = 300;
  static Route<T> fadeThrough<T>(Widget page,
    [double duration = 300]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (duration).round()),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child);
      },
    );
  }
}

