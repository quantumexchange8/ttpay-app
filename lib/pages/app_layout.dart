import 'package:fade_indexed_stack/fade_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:ttpay/component/bottom_navigation_bar.dart';
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
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: FadeIndexedStack(index: currentIndex, children: [
        HomePage(),
        TransactionPage(),
        GroupPage(),
        WithdrawalPage(),
        ProfilePage()
      ]),
      bottomNavigationBar: bottomNavigationBar(
          onTap: (p0) {
            setState(() {
              currentIndex = p0;
            });
          },
          currentIndex: currentIndex),
    );
  }
}
