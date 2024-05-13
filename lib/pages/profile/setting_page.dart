import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/simple_appbar.dart';
import 'package:ttpay/component/toggle.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<String> selectedSetting = [];

  @override
  Widget build(BuildContext context) {
    const notificationSettingList = ['Allow Notifications', 'Show Previews'];

    const securitySettingList = ['Biometric Authentication', 'Device Passcode'];

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
          onTapBack: () {
            Navigator.pop(context);
          },
          title: 'Setting'),
      extendBodyBehindAppBar: true,
      body: backgroundContainer(
          padding: EdgeInsets.symmetric(horizontal: width08 * 2),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: height31),
                child: settingTypeColumn(
                    settingType: 'Notifications',
                    settingList: notificationSettingList,
                    selectedSetting: selectedSetting,
                    onSelectedSetting: onSelectedSetting),
              ),
              settingTypeColumn(
                  settingType: 'Security Authentication',
                  settingList: securitySettingList,
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
      ...settingList.map((e) => _settingList(
          isOn: selectedSetting.contains(changeToLowerCaseUnderscore(e)),
          onChangedOn: (on) {
            onSelectedSetting(changeToLowerCaseUnderscore(e));
          },
          settingName: e))
    ],
  );
}

String changeToLowerCaseUnderscore(String text) {
  return text.toLowerCase().replaceAll(RegExp(r' '), '_');
}
