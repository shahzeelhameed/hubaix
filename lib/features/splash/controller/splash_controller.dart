import 'package:flutter/material.dart';
import 'package:hubaix/features/bottom_navigation/bottom_navigation.dart';
import 'package:hubaix/features/splash/Animation/splash_animation.dart';
import 'package:hubaix/features/welcome/presentation/welcome_screen.dart';
import 'package:hubaix/features/auth/services/auth_service.dart';

import 'package:hubaix/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController {
  final BuildContext context;
  final SplashAnimation animation;
  final AuthenticationService _authService = AuthenticationService();
  bool isInitialized = false;

  SplashController({required TickerProvider vsync, required this.context})
      : animation = SplashAnimation(vsync: vsync);

  Animation<double> get opacityAnimation => animation.opacity;

  Future<void> initialize() async {
    try {
      await animation.start();
      await Future.delayed(const Duration(seconds: 1));
      final isAuthenticated = await _checkAuthenticationState();

      if (context.mounted) {
        _navigate(isAuthenticated);
      }
    } catch (_) {
      if (context.mounted) _handleError();
    }
  }

  Future<bool> _checkAuthenticationState() async {
    try {
      final userId = await _getUserIdFromStorage();
      if (userId != null) {
        return true;
      }

      return false;
    } catch (e) {
      debugPrint('Error in _checkAuthenticationState: $e');
      return false;
    }
  }

  Future<int?> _getUserIdFromStorage() async {
    final prefs = await SharedPreferences.getInstance();

    final userId = prefs.getInt('user_id');
    return userId;
  }

  void _navigate(bool isAuthenticated) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => isAuthenticated
            ? const BottomNavigationScreen()
            : const WelcomePage(),
      ),
    );
  }

  void _handleError() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const WelcomePage()),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Unable to initialize application. Please try again.'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void dispose() {
    animation.dispose();
  }
}
