import 'package:dashboard_template_dribbble/view/screens/admin_screen.dart';
import 'package:dashboard_template_dribbble/view/screens/feedbac_screen.dart';
import 'package:dashboard_template_dribbble/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/media_query_values.dart';

// Import other pages here

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
  });

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final List<IconData> _icons = [
    // Icons.data_exploration_rounded,
    // Icons.messenger,
    // Icons.pie_chart_rounded,
    Icons.account_balance_wallet,
    Icons.message,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.06,
      height: context.height,
      color: darkBlack,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Container(
              width: context.width * 0.05,
              height: context.height * 0.05,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 4.0, color: primaryColor),
              ),
            ),
            SizedBox(
              height: context.height * 0.09,
            ),
            ..._icons
                .asMap()
                .entries
                .map(
                  (entry) => _customIcon(
                    entry.value,
                    entry.key,
                    _navigateToPage(entry.key, context),
                  ),
                )
                .toList(),
            SizedBox(
              height: context.height * 0.02,
            ),
            GestureDetector(
              onTap: () => _navigateToPage(0, context),
              child: Container(
                width: context.width * 0.03,
                height: context.height * 0.06,
                decoration: BoxDecoration(
                  color: chocolateMelange,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Icon(
                  Icons.data_exploration_rounded,
                  color: primaryColor,
                  size: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: context.height * 0.015,
            ),
            GestureDetector(
              onTap: () => _navigateToPage(3, context),
              child: Container(
                width: context.width * 0.03,
                height: context.height * 0.06,
                decoration: BoxDecoration(
                  color: lightBlack,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Icon(
                  Icons.account_balance,
                  color: royalFuchsia,
                  size: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: context.height * 0.015,
            ),
            GestureDetector(
              onTap: () => AdminPage(),
              child: Container(
                width: context.width * 0.03,
                height: context.height * 0.06,
                decoration: BoxDecoration(
                  color: lightBlack,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Icon(
                  Icons.account_tree,
                  color: promiscuousPink,
                  size: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: context.height * 0.015,
            ),
            GestureDetector(
              onTap: () => _navigateToPage(4, context),
              child: Container(
                width: context.width * 0.03,
                height: context.height * 0.06,
                decoration: BoxDecoration(
                  color: lightBlack,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  Icons.add,
                  color: darkGrey.withOpacity(0.6),
                  size: 20.0,
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => _navigateToPage(6, context),
              child: Container(
                width: context.width * 0.03,
                height: context.height * 0.06,
                decoration: BoxDecoration(
                  color: lightBlack,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  Icons.logout,
                  color: darkGrey.withOpacity(0.6),
                  size: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  VoidCallback _navigateToPage(int index, BuildContext context) {
    return () {
      switch (index) {
        case 0:
          // Navigator.push(
          //   context,
          //   // MaterialPageRoute(builder: (context) => DataExplorationPage()),
          // );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FeedbackScreen()),
          );
          break;
        case 2:
          // Navigator.push to PieChartPage
          break;
        case 3:
          // Navigator.push to WalletPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
          break;
        case 4:
          // Navigator.push to MessagePage
          break;
        case 5:
          // Navigator.push to PersonPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminPage()),
          );

          break;
        // Add more cases for additional pages
      }
    };
  }

  Padding _customIcon(IconData icon, int index, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          icon,
          color: index == 1 ? Colors.white : darkGrey.withOpacity(0.6),
        ),
      ),
    );
  }
}
