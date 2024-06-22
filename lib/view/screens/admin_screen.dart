import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Box<dynamic>? _adminBox;

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    _adminBox = await Hive.openBox('adminTasks');
    if (_adminBox!.isEmpty) {
      _populateDummyData();
    }
    setState(() {});
  }

  void _populateDummyData() {
    List<Map<String, dynamic>> tasks = [
      {
        'name': 'Tanish',
        'admin': 'Admin 1',
        'members': 5,
        'status': 'Pending',
        'finishDate': '2024-12-01',
        'completed': false,
      },
      {
        'name': 'Disha',
        'admin': 'Admin 2',
        'members': 3,
        'status': 'Pending',
        'finishDate': '2024-12-02',
        'completed': false,
      },
      {
        'name': 'Manthan',
        'admin': 'Admin 3',
        'members': 4,
        'status': 'Ongoing',
        'finishDate': '2024-12-03',
        'completed': false,
      },
      {
        'name': 'Aditi',
        'admin': 'Admin 4',
        'members': 2,
        'status': 'Completed',
        'finishDate': '2024-12-04',
        'completed': true,
      },
      {
        'name': 'Riya',
        'admin': 'Admin 5',
        'members': 6,
        'status': 'Completed',
        'finishDate': '2024-12-05',
        'completed': true,
      },
    ];
    _adminBox!.addAll(tasks);
  }

  void _updateTaskCompletion(int index, bool? value) {
    var task = (_adminBox!.getAt(index) as Map).cast<String, dynamic>();
    if (task != null) {
      task['completed'] = value ?? false;
      _adminBox!.putAt(index, task);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle sorting/filtering logic here
            },
            itemBuilder: (BuildContext context) {
              return {'Sort by Name', 'Sort by Date', 'View as Cards'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: _adminBox == null
          ? Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Admin')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Members')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Finish Date')),
                          DataColumn(label: Text('Completed')),
                        ],
                        rows:
                            List<DataRow>.generate(_adminBox!.length, (index) {
                          var task = (_adminBox!.getAt(index) as Map)
                              .cast<String, dynamic>();
                          return DataRow(cells: [
                            DataCell(Text(task['admin'] ?? '')),
                            DataCell(Text(task['name'] ?? '')),
                            DataCell(Text(task['members']?.toString() ?? '')),
                            DataCell(Text(task['status'] ?? '')),
                            DataCell(Text(task['finishDate'] ?? '')),
                            DataCell(
                              Row(
                                children: [
                                  if (task['completed'] == true)
                                    Icon(Icons.circle,
                                        color: Colors.green, size: 12),
                                  Checkbox(
                                    value: task['completed'] ?? false,
                                    onChanged: (bool? value) {
                                      _updateTaskCompletion(index, value);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ]);
                        }),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
