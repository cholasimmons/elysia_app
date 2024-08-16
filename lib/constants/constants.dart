import 'package:flutter/material.dart';

class AppConstants {
  // Colors
  static const Color primaryColor = Colors.purple;
  static const Color secondaryColor = Colors.green;

  // API Endpoints
  static const String baseUrl = 'https://api.hello.simmons.studio/v1';
  // kReleaseMode
  //       ? 'https://api.hello.simmons.studio/v1'
  //       : 'http://10.0.2.2:3000/v1';
  static const int fetchTimeout = 6;

  // Padding
  static const double defaultPadding = 16.0;

  // Strings
  static const String appName = 'Elysia Auth';
  static const String connectText = 'Connect';
  static const String connectingText = 'Connecting...';

  // Icons
  static const String elysiaIcon = 'assets/images/elysia_icon.webp';
  static const String simmonsIcon = 'assets/images/simmons_icon.png';

  // Images
  static const String placeholderThumbnail = 'assets/images/placeholder.png';

  // Toast
  static const int toastDuration = 8;

  // Animation
  static const int pageAnimDuration = 500; // milliseconds

  // Caching
  static const int staleDuration = 25; // Minutes before data is considered stale
}
