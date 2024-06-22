import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle filter/sort option
            },
            itemBuilder: (BuildContext context) {
              return {'List', 'Cards'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Admin')),
            DataColumn(label: Text('Members')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Finish Date')),
          ],
          rows: _buildTableRows(),
        ),
      ),
    );
  }

  List<DataRow> _buildTableRows() {
    return List<DataRow>.generate(
      5,
      (index) => DataRow(
        cells: [
          DataCell(Text('Name $index')),
          DataCell(Text('Admin $index')),
          DataCell(Text('Members $index')),
          DataCell(Text('Status $index')),
          DataCell(Text('Finish Date $index')),
        ],
      ),
    );
  }
}
