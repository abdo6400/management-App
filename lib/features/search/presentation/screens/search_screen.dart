import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'SearchScreenPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}