import 'package:flutter/material.dart';
import 'dart:math' as math;

class RippleRoute extends PageRouteBuilder {
  final Widget page;
  final Offset? centerAlignment; // optional origin point for the ripple

  RippleRoute({required this.page, this.centerAlignment})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionDuration: const Duration(milliseconds: 800),
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCubic,
      );

      return AnimatedBuilder(
        animation: curved,
        child: child,
        builder: (context, child) {
          return ClipPath(
            clipper: _RippleClipper(
              fraction: curved.value,
              center: centerAlignment,
            ),
            child: child,
          );
        },
      );
    },
  );
}

class _RippleClipper extends CustomClipper<Path> {
  final double fraction;
  final Offset? center;

  _RippleClipper({required this.fraction, this.center});

  @override
  Path getClip(Size size) {
    final Offset origin = center ?? Offset(size.width / 2, size.height / 2);

    // Max radius needed to cover the whole screen from the origin point
    final double maxRadius = [
      origin.distance,
      (origin - Offset(size.width, 0)).distance,
      (origin - Offset(0, size.height)).distance,
      (origin - Offset(size.width, size.height)).distance,
    ].reduce(math.max);

    final double radius = maxRadius * fraction;

    return Path()
      ..addOval(Rect.fromCircle(center: origin, radius: radius));
  }

  @override
  bool shouldReclip(covariant _RippleClipper oldClipper) {
    return oldClipper.fraction != fraction || oldClipper.center != center;
  }
}