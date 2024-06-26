import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/simple_appbar.dart';
import 'package:ttpay/component/toggle.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingPage extends StatefulWidget {
  final bool notificationPermission;
  final bool biometricPermission;
  final bool showPreviews;
  final bool devicePasscodePermission;

  const SettingPage(
      {super.key,
      required this.notificationPermission,
      required this.biometricPermission,
      required this.showPreviews,
      required this.devicePasscodePermission});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final storage = const FlutterSecureStorage();

  List<String> selectedSetting = [];

  @override
  void initState() {
    super.initState();
    if (widget.notificationPermission) {
      selectedSetting.add('allow_notifications');
    }
    if (widget.biometricPermission) {
      selectedSetting.add('biometric_authentication');
    }
    if (widget.showPreviews) {
      selectedSetting.add('show_previews');
    }
    if (widget.devicePasscodePermission) {
      selectedSetting.add('device_passcode');
    }
  }

  @override
  Widget build(BuildContext context) {
    const notificationSettingList = ['Allow Notifications', 'Show Previews'];
    final notificationSettingListLocale = [
      AppLocalizations.of(context)!.allow_notifications,
      AppLocalizations.of(context)!.show_previews
    ];

    const securitySettingList = ['Biometric Authentication', 'Device Passcode'];
    final securitySettingListLocale = [
      AppLocalizations.of(context)!.biometric_authentication,
      AppLocalizations.of(context)!.device_passcode
    ];

    void onTapBack() async {
      await storage.write(key: showNotificationStorageKey, value: 'false');
      await storage.write(key: showPreviewStrorageKey, value: 'false');
      await storage.write(key: biometricPermissionStorageKey, value: 'false');
      await storage.write(key: devicePasscodeStorageKey, value: 'false');

      if (selectedSetting.contains('allow_notifications')) {
        await storage.write(key: showNotificationStorageKey, value: 'true');
      }
      if (selectedSetting.contains('show_previews')) {
        await storage.write(key: showPreviewStrorageKey, value: 'true');
      }
      if (selectedSetting.contains('biometric_authentication')) {
        await storage.write(key: biometricPermissionStorageKey, value: 'true');
      }
      if (selectedSetting.contains('device_passcode')) {
        await storage.write(key: devicePasscodeStorageKey, value: 'true');
      }
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }

    void onSelectedSetting(String setting) {
      setState(() {
        if (selectedSetting.contains(setting)) {
          selectedSetting.remove(setting);
        } else {
          selectedSetting.add(setting);
        }
      });
    }

    return Scaffold(
      appBar: simpleAppBar(
          onTapBack: onTapBack, title: AppLocalizations.of(context)!.setting),
      extendBodyBehindAppBar: true,
      body: backgroundContainer(
          padding: EdgeInsets.symmetric(horizontal: width08 * 2),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: height31),
                child: settingTypeColumn(
                    settingType: AppLocalizations.of(context)!.notifications,
                    settingList: notificationSettingList,
                    settingListLocale: notificationSettingListLocale,
                    selectedSetting: selectedSetting,
                    onSelectedSetting: onSelectedSetting),
              ),
              settingTypeColumn(
                  settingType:
                      AppLocalizations.of(context)!.security_authentication,
                  settingList: securitySettingList,
                  settingListLocale: securitySettingListLocale,
                  selectedSetting: selectedSetting,
                  onSelectedSetting: onSelectedSetting)
            ],
          )),
    );
  }
}

Row _settingList(
    {required String settingName,
    required bool isOn,
    required void Function(bool on) onChangedOn}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        settingName,
        style: textSm.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      toggle(
        value: isOn,
        onChanged: onChangedOn,
      ),
    ],
  );
}

Widget settingTypeColumn(
    {required String settingType,
    required List<String> settingList,
    required List<String> settingListLocale,
    required List<String> selectedSetting,
    required void Function(String setting) onSelectedSetting}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        settingType,
        style: textSm.copyWith(
          color: neutralGrayScale,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: height08 / 2),
      ...settingList.mapIndexed((i, e) => _settingList(
          isOn: selectedSetting.contains(changeToLowerCaseUnderscore(e)),
          onChangedOn: (on) {
            onSelectedSetting(changeToLowerCaseUnderscore(e));
          },
          settingName: settingListLocale[i]))
    ],
  );
}

String changeToLowerCaseUnderscore(String text) {
  return text.toLowerCase().replaceAll(RegExp(r' '), '_');
}
