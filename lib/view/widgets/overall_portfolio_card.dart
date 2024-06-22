// ignore_for_file: non_constant_identifier_names

// ignore: unused_import
import 'package:dashboard_template_dribbble/view/screens/details_screen.dart';

import '../../utils/colors.dart';
import '../../utils/media_query_values.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';
import 'total_widget.dart';

class OverallPortfolioCard extends StatelessWidget {
  const OverallPortfolioCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(),
                      ));
                },
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //  TotalWidget(),
              TotalWidget(
                title: 'Remaining useful life',
                value: '',
              ),
              TotalWidget(
                title: 'Health Score',
                value: '',
              ),
              TotalWidget(
                title: 'Recommendations',
                value: 'No',
              ),
            ],
          ),
        ],
      ),
    );
  }

  DetailsScreen() {}
}
