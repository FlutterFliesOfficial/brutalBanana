import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Equipment Name: Your Equipment Name',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Health Status: Good',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Remaining Useful Life: 120 days',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement any action you want here
              },
              child: const Text('Perform Maintenance'),
            ),
          ],
        ),
      ),
    );
  }
}
