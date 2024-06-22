import 'package:dashboard_template_dribbble/utils/media_query_values.dart';
import 'package:flutter/material.dart';

class EquipmentDetails extends StatelessWidget {
  final String equipmentId;

  const EquipmentDetails({Key? key, required this.equipmentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Equipment ID: $equipmentId',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Current Status: Running'),
            SizedBox(height: 8.0),
            Text('Predicted Maintenance Needs:'),
            Text('• Remaining Useful Life: 120 days'),
            Text('• Likelihood of Failure: Low'),
            Text('• Recommended Action: Routine Check-Up'),
            SizedBox(height: 8.0),
            Text('Historical Data:'),
            // Add graphs or tables for historical data here
            SizedBox(height: 8.0),
            Text('Alerts and Notifications:'),
            Text('• No alerts'),
            SizedBox(height: 8.0),
            Text('Maintenance History:'),
            Text('• 01/01/2023: Routine Check-Up - No issues found'),
            SizedBox(height: 8.0),
            Text('Sensor Data:'),
            // Add real-time or recent sensor data here
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EquipmentDetails(equipmentId: '12345'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.28,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.bottomCenter,
          image: AssetImage(
            'assets/images/header_image.jpeg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.cloudy_snowing,
              ),
              SizedBox(
                width: context.width * 0.01,
              ),
              Text(
                'Sat, 22 June 2023',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey[200]),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => _navigateToDetails(context),
            child: const Text('View Details'),
          ),
        ],
      ),
    );
  }
}
