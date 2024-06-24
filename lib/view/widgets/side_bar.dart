import 'package:flutter/material.dart';
import 'package:dashboard_template_dribbble/view/screens/admin_screen.dart';
import 'package:dashboard_template_dribbble/view/screens/feedbac_screen.dart';
import 'package:dashboard_template_dribbble/view/screens/profile_screen.dart';
import '../../utils/colors.dart';
import '../../utils/media_query_values.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
  });

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final List<IconData> _icons = [
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
                    () => _navigateToPage(entry.key, context),
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
              onTap: () => _navigateToAdditionalPage('wallet', context),
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
              onTap: () => _navigateToAdditionalPage('admin', context),
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
              onTap: () => _navigateToAdditionalPage('add', context),
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
              onTap: () => _navigateToAdditionalPage('logout', context),
              child: Container(
                width: context.width * 0.03,
                height: context.height * 0.06,
                decoration: BoxDecoration(
                  color: Colors.white,
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

  void _navigateToPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        // Navigator.push to DataExplorationPage
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeedbackScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
    }
  }

  void _navigateToAdditionalPage(String page, BuildContext context) {
    switch (page) {
      case 'wallet':
        // Navigator.push to WalletPage
        break;
      case 'admin':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
        break;
      case 'add':
      
        // Navigator.push to AddPage
        break;
      case 'logout':
        // Handle logout
        break;
    }
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
