import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                // Placeholder image or user's profile picture can be added here
                backgroundImage:
                    AssetImage('assets/images/profile_picture.png'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'John Doe',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Software Engineer',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'About Me:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Additional Information:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Additional user information displayed in a structured form
            _buildUserDataItem('Email', 'john.doe@example.com'),
            _buildUserDataItem('Phone', '+1234567890'),
            _buildUserDataItem('Location', 'New York, USA'),
            _buildUserDataItem('Birthday', 'January 1, 1990'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle edit profile button action
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a data item with label and value
  Widget _buildUserDataItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
