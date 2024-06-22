import 'dart:ui';

import 'package:dashboard_template_dribbble/utils/media_query_values.dart';
import 'package:dashboard_template_dribbble/view/screens/report_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import 'custom_button.dart';
import 'outline_button.dart';
import 'pie_chart.dart';

class EquipmentWidget extends StatelessWidget {
  const EquipmentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.22,
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 22.0,
      ),
      transform: Matrix4.translationValues(0, -75, 0),
      decoration: BoxDecoration(
        color: lightBlack,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: [
          Text(
            'Equipment Health and RUL',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white),
          ),
          SizedBox(
            height: context.height * 0.03,
          ),
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: context.width * 0.15,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: darkGrey.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Current Health Status',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: darkGrey),
                      ),
                      SizedBox(
                        height: context.height * 0.012,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '85%',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: context.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'RUL Prediction',
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 12.0,
                ),
              ),
              SizedBox(
                width: context.width * 0.007,
              ),
              const Icon(
                Icons.arrow_outward_outlined,
                color: secondPrimaryColor,
                size: 18.0,
              ),
            ],
          ),
          SizedBox(
            height: context.height * 0.02,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              const PieChartWidget(),
              Container(
                width: context.width * 0.235,
                height: context.height * 0.235,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.0,
                    color: darkGrey.withOpacity(0.35),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Remaining Useful Life',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: darkGrey),
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '120',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: context.width * 0.001,
                        ),
                        Text(
                          'days',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: darkGrey, fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: blue,
                          radius: 3.0,
                        ),
                        SizedBox(
                          width: context.width * 0.004,
                        ),
                        Text(
                          'Optimal Performance',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: darkGrey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: context.height * 0.02,
          ),
          CustomOutlineButton(
            width: context.width * 0.15,
            title: 'Schedule Maintenance',
            onPressed: () {
              // Navigate to maintenance scheduling page
            },
          ),
          SizedBox(
            height: context.height * 0.02,
          ),
          CustomButton(
            width: context.width * 0.15,
            title: 'Vw Detailed Report',
            onPressed: () {
              print("object");
              try {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportPage()),
                );
              } catch (e) {
                print('Error navigating to ReportPage: $e');
              }
            },
          ),
        ],
      ),
    );
  }

  Padding infoWidget(BuildContext context, String title, String value,
      {bool isPercentage = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        width: context.width * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: darkGrey),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: isPercentage ? Colors.green : darkGrey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
