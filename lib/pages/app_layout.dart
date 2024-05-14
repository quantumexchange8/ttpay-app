import 'package:fade_indexed_stack/fade_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/bottom_navigation_bar.dart';
import 'package:ttpay/component/unfocus_gesturedetector.dart';
import 'package:ttpay/pages/group/group_page.dart';
import 'package:ttpay/pages/home/home_page.dart';
import 'package:ttpay/pages/profile/profile_page.dart';
import 'package:ttpay/pages/transaction/transaction_page.dart';
import 'package:ttpay/pages/withdrawal/withdrawal_page.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    void onChangeTab(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return unfocusGestureDetector(
      context,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: backgroundContainer(
          child: FadeIndexedStack(index: currentIndex, children: [
            HomePage(
              onChangeTab: onChangeTab,
            ),
            const TransactionPage(),
            const GroupPage(),
            const WithdrawalPage(),
            const ProfilePage()
          ]),
        ),
        floatingActionButton:
            bottomNavigationBar(onTap: onChangeTab, currentIndex: currentIndex),
      ),
    );
  }
}
