import 'package:flutter/material.dart';

class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'HomeScreenPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
