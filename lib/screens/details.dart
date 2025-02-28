// lib/screens/details.dart
import 'package:flutter/material.dart';

class LocationDetailsScreen extends StatelessWidget {
  final String imagePath;

  const LocationDetailsScreen({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Details'),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 1.0,
          maxScale: 2.0,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}