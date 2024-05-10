import 'package:flutter/material.dart';
import 'package:ttpay/component/two_simple_appbar.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/dummyData/accounts.dart';
import 'package:ttpay/models/user.dart';
import 'package:ttpay/pages/profile/widgets/account_list_container.dart';
import 'package:ttpay/pages/profile/widgets/logout_container.dart';
import 'package:ttpay/pages/profile/widgets/profile_details_container.dart';
import 'package:ttpay/pages/profile/widgets/profile_photo_row.dart';
import 'package:ttpay/pages/profile/widgets/setting_list_container.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<User> userAccount = listUserFromListMap(dummyAccounts);

    User profile = User.fromMap({
      'id': 500,
      'name': 'CC POWER GROUP',
      'email': 'you@example.com',
      'profile_photo': null,
      'profile_id': 'MID000001',
      'phone_number': '0162723683'
    });

    Map<String, dynamic> details = {
      'Manager Name': profile.name,
      'Email': profile.email,
      'Phone Number': profile.phoneNumber ?? '-'
    };

    List<Map<String, dynamic>> accountSettings = [
      {
        'on_tap': {},
        'icon_address': 'assets/icon_image/grey_globe_icon.png',
        'name': 'Take Photo',
      },
      {
        'on_tap': {},
        'icon_address': 'assets/icon_image/grey_setting_icon.png',
        'name': 'Import from Gallery',
      },
      {
        'on_tap': {},
        'icon_address': 'assets/icon_image/grey_lock_icon.png',
        'name': 'Browse',
      }
    ];

    return Scaffold(
      appBar: twoSimpleAppbar(
          title: 'My Profile',
          onPressedButton: () {},
          leftButtonIcon: Image.asset(
            'assets/edit_icon.png',
            height: height08 * 2,
            fit: BoxFit.fitHeight,
          ),
          buttonText: 'Profile Photo'),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: width08 * 2, vertical: height24 / 2),
          children: [
            profilePhotoRow(
                profilePhotoAddress: profile.profilePhoto,
                profileName: profile.name,
                profileId: profile.profileId),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height20),
              child: profileDetailsContainer(details),
            ),
            accountListContainer(userAccounts: userAccount),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height20),
              child: settingListContainer(accountSettings: accountSettings),
            ),
            logoutContainer()
          ],
        ),
      ),
    );
  }
}
