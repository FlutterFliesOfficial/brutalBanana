// TODO Implement this library.
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: Text(
          'Detailed Health Information',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
