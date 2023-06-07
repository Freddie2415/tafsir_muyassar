import 'package:flutter/material.dart';

class SlideRouter extends PageRouteBuilder {
  final Widget page;
  final SlideDirection slideDirection;

  SlideRouter({
    required this.page,
    this.slideDirection = SlideDirection.top,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            final begin =
                Offset(0.0, slideDirection == SlideDirection.top ? -1.0 : 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}

enum SlideDirection {
  top,
  bottom,
}
