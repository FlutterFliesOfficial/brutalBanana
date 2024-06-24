import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          const Text(
            'FUNCTIONALITY REPORT',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox (height: 20.0),
          const Text(
            'MSAzure Predictive Machine Learning dataset. Location of machine FLOOR 2. other descriptions',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 20.0),
          const Text(
            'DATE  TIME',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(
            formattedDate,
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 20.0),
          const Text(
            'USER',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const Text(
            'John Doe',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 20.0),
          const Text(
            'MACHINE ID',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const Text(
            '23 - Machine Type 1',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 20.0),
          const Text(
            'PREDICTED RUL',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const Text(
            '17 (cycles)',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 20.0),
          const Text(
            'NEXT MAINTAINANCE DATE',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const Text(
            '2024-07-03',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 20.0),
          const Text(
            'ASSIGNED TO',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Admin 1',
            style: TextStyle(fontSize: 16.0),
          ),const SizedBox(height: 20.0),
          const Text(
            'HEALTH SCORE',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const Text(
            '43.5      / 100',
            style: TextStyle(fontSize: 16.0),
          ),const SizedBox(height: 20.0),
          const Text(
            'ERROR RECORD',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const Text(
            'no Error Record Found',
            style: TextStyle(fontSize: 16.0),
          ),
         const  SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Add download logic here
            },
            child: const Text('Download Report'),
          ),
        ],
      ),
    );
  }
}
