import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ttpay/component/two_simple_appbar.dart';
import 'package:ttpay/component/warning_dialog.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/helper/const.dart';
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

class _ProfilePageState extends State<ProfilePage> {
  final storage = const FlutterSecureStorage();
  dynamic profilePhoto;

  @override
  Widget build(BuildContext context) {
    List<User> userAccount = listUserFromListMap(dummyAccounts);

    void onOpenSettingPage() async {
      bool biometricPermission = bool.parse(
          await storage.read(key: biometricPermissionStorageKey) ?? 'false');
      bool devicePasscodePermission = bool.parse(
          await storage.read(key: devicePasscodeStorageKey) ?? 'false');
      bool showPreview = bool.parse(
          await storage.read(key: showPreviewStrorageKey) ?? 'false');
      bool notificationPermission = bool.parse(
          await storage.read(key: showNotificationStorageKey) ?? 'false');

      Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => SettingPage(
              biometricPermission: biometricPermission,
              devicePasscodePermission: devicePasscodePermission,
              notificationPermission: notificationPermission,
              showPreviews: showPreview,
            ),
          ));
    }

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
        'on_tap': onOpenSettingPage,
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

    void onTapAddAccount() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(
              topRightWidget: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: height24,
                  color: Colors.white,
                ),
              ),
              onLogin: () {
                Navigator.pop(context);
              },
            ),
          ));
    }

    void onTapLogout() async {
      await showWarningDialog(
              context: context,
              title: 'Are you sure you want to log out?',
              redButtonText: 'Log Out')
          .then((yes) async {
        if (yes != null && yes) {
          await authController
              .logout(context, token: tokenController.token)
              .then((success) {
            Navigator.popUntil(context, (route) => true);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
          });
        }
      });
    }

    return Obx(() {
      final profile = userController.user.value;
      bool profileIsNull = profile == null;

      Map<String, dynamic> details = {
        'Manager Name': profileIsNull ? 'No data' : profile.managerName,
        'Email': profileIsNull ? 'No data' : profile.email,
        'Phone Number': profileIsNull ? 'No data' : profile.phoneNumber ?? '-'
      };

      return SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width08 * 2, 0, width08 * 2, height24 / 2),
              child: twoSimpleAppbar(
                  title: 'My Profile',
                  onPressedButton: () {
                    customShowModalBottomSheet(
                      context: context,
                      builder: (context) => const EditProfilePhotoBottomsheet(),
                    ).then((file) {
                      if (file != null) {
                        if (mounted) {
                          setState(() {
                            profilePhoto = file;
                          });
                        }
                      }
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
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: width08 * 2, vertical: height24 / 2),
                children: [
                  profilePhotoRow(
                      profilePhotoAddress: profilePhoto,
                      profileName: profileIsNull ? 'No data' : profile.name,
                      profileId: profileIsNull ? 'No data' : profile.profileId),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height20),
                    child: profileDetailsContainer(details),
                  ),
                  accountListContainer(
                      onTapAddAccount: onTapAddAccount,
                      userAccounts: userAccount),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height20),
                    child:
                        settingListContainer(accountSettings: accountSettings),
                  ),
                  InkWell(onTap: onTapLogout, child: logoutContainer)
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
