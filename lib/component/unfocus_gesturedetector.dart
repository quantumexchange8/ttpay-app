import 'package:flutter/material.dart';

GestureDetector unfocusGestureDetector(BuildContext context, {Widget? child}) {
  return GestureDetector(
    onTap: () {
      FocusScope.of(context).unfocus();
    },
    child: child,
  );
}
