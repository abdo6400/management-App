import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'ProfileScreenPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}