import 'package:flutter/material.dart';

class SplashAnimation {
  final AnimationController controller;
  late final Animation<double> opacity;

  SplashAnimation({required TickerProvider vsync})
      : controller = AnimationController(
          duration: const Duration(milliseconds: 1500),
          vsync: vsync,
        ) {
    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );
  }

  Future<void> start() async {
    await controller.forward();
  }

  void dispose() {
    controller.dispose();
  }
}
