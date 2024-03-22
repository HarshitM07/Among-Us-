import 'package:flutter/material.dart';

class BadgeAllocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text(
          'This is the next screen!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
