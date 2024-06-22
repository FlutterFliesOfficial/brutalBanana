import 'package:dashboard_template_dribbble/utils/media_query_values.dart';
import 'package:flutter/material.dart';

class TotalWidget extends StatelessWidget {
  const TotalWidget({
    Key? key,
    required this.title,
    required this.value,
    this.isPositive = true,
    MaterialColor? textColor,
  }) : super(key: key);

  final String title;
  final String value;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                    color: isPositive ? Colors.green : Colors.red,
                    size: 15.0,
                  ),
                  SizedBox(
                    width: context.width * 0.001,
                  ),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: isPositive ? Colors.green : Colors.red),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: context.height * 0.02,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '\$',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey),
              ),
              SizedBox(
                width: context.width * 0.001,
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
