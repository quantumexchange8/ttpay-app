import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/two_simple_appbar.dart';
import 'package:ttpay/component/warning_dialog.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/dummyData/accounts.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/models/user.dart';
import 'package:ttpay/pages/auth/login_page.dart';
import 'package:ttpay/pages/profile/change_language_page.dart';
import 'package:ttpay/pages/profile/change_password_page.dart';
import 'package:ttpay/pages/profile/setting_page.dart';
import 'package:ttpay/pages/profile/widgets/account_list_container.dart';
import 'package:ttpay/pages/profile/widgets/edit_profile_photo_bottomsheet.dart';
import 'package:ttpay/pages/profile/widgets/logout_container.dart';
import 'package:ttpay/pages/profile/widgets/profile_details_container.dart';
import 'package:ttpay/pages/profile/widgets/profile_photo_row.dart';
import 'package:ttpay/pages/profile/widgets/setting_list_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

User profile = User.fromMap({
  'id': 500,
  'name': 'CC POWER GROUP',
  'email': 'you@example.com',
  'profile_photo': null,
  'profile_id': 'MID000001',
  'phone_number': '0162723683'
});

class _ProfilePageState extends State<ProfilePage> {
  dynamic profilePhoto = profile.profilePhoto;

  @override
  Widget build(BuildContext context) {
    List<User> userAccount = listUserFromListMap(dummyAccounts);

    Map<String, dynamic> details = {
      'Manager Name': profile.name,
      'Email': profile.email,
      'Phone Number': profile.phoneNumber ?? '-'
    };

    List<Map<String, dynamic>> accountSettings = [
      {
        'on_tap': () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChangeLanguagePage(),
              ));
        },
        'icon_address': 'assets/icon_image/grey_globe_icon.png',
        'name': 'Language',
      },
      {
        'on_tap': () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingPage(),
              ));
        },
        'icon_address': 'assets/icon_image/grey_setting_icon.png',
        'name': 'Setting',
      },
      {
        'on_tap': () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChangePasswordPage(),
              ));
        },
        'icon_address': 'assets/icon_image/grey_lock_icon.png',
        'name': 'Change Password',
      }
    ];

    void onTapLogout() async {
      await showWarningDialog(
              context: context,
              title: 'Are you sure you want to log out?',
              redButtonText: 'Log Out')
          .then((yes) {
        if (yes != null && yes) {
          Navigator.popUntil(context, (route) => true);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
        }
      });
    }

    return Scaffold(
      appBar: twoSimpleAppbar(
          title: 'My Profile',
          onPressedButton: () {
            customShowModalBottomSheet(
              context: context,
              builder: (context) => const EditProfilePhotoBottomsheet(),
            ).then((file) {
              setState(() {
                profilePhoto = file;
              });
            });
          },
          leftButtonIcon: Padding(
            padding: EdgeInsets.only(right: width08),
            child: Image.asset(
              'assets/icon_image/edit_icon.png',
              height: height08 * 2,
              fit: BoxFit.fitHeight,
            ),
          ),
          buttonText: 'Profile Photo'),
      extendBodyBehindAppBar: true,
      body: backgroundContainer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: width08 * 2, vertical: height24 / 2),
            children: [
              profilePhotoRow(
                  profilePhotoAddress: profilePhoto,
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
              InkWell(onTap: onTapLogout, child: logoutContainer)
            ],
          ),
        ),
      ),
    );
  }
}
