import 'package:flutter/material.dart';

class FadePageRoute extends PageRouteBuilder {
  final Widget child;

  FadePageRoute({
    required this.child,
  }) : super(
            transitionDuration: const Duration(milliseconds: 600),
            pageBuilder: (context, animation, secondaryAnimation) => child);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(animation),
      child: child,
    );
  }
}
