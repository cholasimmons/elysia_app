import 'package:flutter/material.dart';

class ToastService {
  static final ToastService _instance = ToastService._internal();

  factory ToastService() => _instance;

  ToastService._internal();

  // Function to display a toast message
  void showToast(String message) {
    if (_navigatorKey.currentContext != null) {
      ScaffoldMessenger.of(_navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void dispose() {
    // _instance = null;
  }

  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<
      NavigatorState>();

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}