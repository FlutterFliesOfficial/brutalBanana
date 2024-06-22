import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          const Text(
            'Report Title',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed commodo, mi non convallis lacinia, leo leo semper justo, vitae posuere quam metus ut tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Integer ut mi sed nulla consectetur cursus.',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 20.0),
          Text(
            'Section 1',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(
            'Content for Section 1',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 20.0),
          Text(
            'Section 2',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(
            'Content for Section 2',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 20.0),
          Text(
            'Section 3',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(
            'Content for Section 3',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Add download logic here
            },
            child: Text('Download Report'),
          ),
        ],
      ),
    );
  }
}
