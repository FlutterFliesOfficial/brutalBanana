import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/colors.dart';
import '../../utils/media_query_values.dart';
import 'custom_button.dart';
import 'total_widget.dart';

class OverallPortfolioCard extends StatefulWidget {
  const OverallPortfolioCard({Key? key}) : super(key: key);

  @override
  _OverallPortfolioCardState createState() => _OverallPortfolioCardState();
}

class _OverallPortfolioCardState extends State<OverallPortfolioCard> {
  late Timer _timer;
  late double _randomValue;
  late bool _isAlert;

  @override
  void initState() {
    super.initState();
    _randomValue = 0.0;
    _isAlert = false;
    _startRandomValueUpdate();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startRandomValueUpdate() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _randomValue = Random().nextDouble() * 100;
        _isAlert = _randomValue < 20; // Check if value goes below 20
      });
    });
  }

  void _showAlertToast() {
    if (_isAlert) {
      Fluttertoast.showToast(
        msg: "Alert: Random value exceeded 15!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _showAlertToast(); // Call _showAlertToast() to display alert message

    return Container(
      transform: Matrix4.translationValues(0, -90, 0),
      width: context.width * 0.65,
      height: context.height * 0.24,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22.0),
      decoration: BoxDecoration(
        color: lightBlack.withOpacity(0.9),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                'Equipment Health Overview',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              CustomButton(
                width: context.width * 0.08,
                title: 'View Details',
                isIconButton: true,
                onPressed: () {
                  debugPrint('hello');
                  // Navigate to details screen
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TotalWidget(
                title: 'Remaining useful life',
                value: _randomValue.toStringAsFixed(2),
                textColor:
                    _isAlert ? Colors.red : null, // Set color to red if alert
              ),
              TotalWidget(
                title: 'Health Score',
                value: _randomValue.toStringAsFixed(2),
                textColor:
                    _isAlert ? Colors.red : null, // Set color to red if alert
              ),
              TotalWidget(
                title: 'Recommendations',
                value: _randomValue < 20
                    ? 'Yes'
                    : 'No', // Show 'Yes' if value is less than 20
              ),
            ],
          ),
        ],
      ),
    );
  }
}
