import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/media_query_values.dart';
import 'search_form_field.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reminder'),
          content: const Text('This is your reminder message.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showToast(BuildContext context) {
    Fluttertoast.showToast(
      msg: "This is your reminder message.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
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
                'Sun, 4 June 2023',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey[200]),
              ),
            ],
          ),
          const SearchFormField(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.nights_stay,
              ),
              SizedBox(
                width: context.width * 0.01,
              ),
              const Icon(
                Icons.mic,
              ),
              SizedBox(
                width: context.width * 0.01,
              ),
              GestureDetector(
                onTap: () => _showAlertDialog(
                    context), // OR _showToast(context) if you prefer toast
                child: const Icon(
                  Icons.notifications,
                ),
              ),
              SizedBox(
                width: context.width * 0.01,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                      'https://media.licdn.com/dms/image/D4E03AQHirihVTwk9sA/profile-displayphoto-shrink_800_800/0/1678926297499?e=2147483647&v=beta&t=AXEpUxgTP1zcc3eP1U4jN6oiu9N9yzL1hHj83WZjZtU',
                    ),
                  ),
                  SizedBox(
                    width: context.width * 0.007,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Hnay Sameh Elshafey',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: context.width * 0.005,
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 12.0,
                          ),
                        ],
                      ),
                      Text(
                        'han798348@gmail.com',
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
