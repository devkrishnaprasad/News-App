import 'package:flutter/material.dart';
import 'package:news_app_test/core/themes/fonts.dart';

void showSnackBarFun(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(
    content: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(message, style: AppFonts.labelText),
    ),
    backgroundColor: Colors.indigo,
    dismissDirection: DismissDirection.horizontal,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.only(
      bottom: 40,
      left: 10,
      right: 10,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
