import 'package:flutter/material.dart';

Widget textLoader(String? text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const CircularProgressIndicator(),
      const SizedBox(height: 8.0),
      Text(text ?? 'Loading...')
    ],
  );
}