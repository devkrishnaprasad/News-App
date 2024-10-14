// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app_test/core/themes/fonts.dart';

class OnboardingPage1 extends StatelessWidget {
  final TextEditingController nameController;
  const OnboardingPage1({
    super.key,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter your Name.",
              style: AppFonts.labelText.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: nameController,
              style: AppFonts.labelText,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
