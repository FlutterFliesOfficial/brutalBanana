import 'package:flutter/material.dart';

class MachineEnvironment {
  final String name;
  final String description;
  final Color color; // Color for UI representation

  MachineEnvironment({
    required this.name,
    required this.description,
    required this.color,
  });
}

// Dummy data for three different machine environments
List<MachineEnvironment> environments = [
  MachineEnvironment(
    name: 'Machine A',
    description: 'Settings for Machine A',
    color: Colors.blue,
  ),
  MachineEnvironment(
    name: 'Machine B',
    description: 'Settings for Machine B',
    color: Colors.green,
  ),
  MachineEnvironment(
    name: 'Machine C',
    description: 'Settings for Machine C',
    color: Colors.orange,
  ),
];
