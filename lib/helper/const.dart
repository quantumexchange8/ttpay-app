import 'package:flutter/material.dart';

const Color backgroundColor = Colors.black;
const List<Map<String, dynamic>> languageList = [
  {'language_name': 'English', 'locale': Locale('en', 'UK')},
  {'language_name': '中文', 'locale': Locale('zh', 'CN')},
];
const String emailPattern =
    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,})$';
