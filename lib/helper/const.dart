import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String apiAddress = 'https://ttpay-admin.currenttech.pro/api';
const Color backgroundColor = Colors.black;
const List<Map<String, dynamic>> languageList = [
  {'language_name': 'English', 'locale': Locale('en')},
  {'language_name': '中文', 'locale': Locale('zh')},
];
const String emailPattern =
    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,})$';

final NumberFormat amountFormatter = NumberFormat('#,##0.00', 'en_US');
final NumberFormat amountFormatterWithoutDecimal =
    NumberFormat('#,##0', 'en_US');
final DateFormat rowDateFormat = DateFormat('dd MMM yyyy HH:mm:ss');

const showNotificationStorageKey = 'show_notification';
const biometricPermissionStorageKey = 'biometric_permission';
const devicePasscodeStorageKey = 'device_passcode';
const showPreviewStrorageKey = 'show_preview';
const List<String> transactionTypeList = ['All', 'Deposit', 'Withdrawal'];
List<String> tabNameList(BuildContext context) => [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.deposit,
      AppLocalizations.of(context)!.withdrawal
    ];
