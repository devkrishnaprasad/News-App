import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/core/utils/local_storage/local_storage.dart';
import 'package:news_app_test/core/utils/navbar/view/navbar.dart';
import 'package:news_app_test/core/utils/snackbar.dart';
import 'package:news_app_test/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:news_app_test/features/onboarding/view/onboarding_page_1.dart';
import 'package:news_app_test/features/onboarding/view/onboarding_page_2.dart';
import 'package:news_app_test/features/onboarding/view/onboarding_page_3.dart';
import 'package:news_app_test/features/splash_screen/view/cubit/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  LocalStorage localStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                OnboardingPage1(
                  nameController: nameController,
                ),
                const OnboardingPage2(),
                OnboardingPage3(
                  cityController: cityController,
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.38),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return TextButton(
                        onPressed: () async {
                          if (_currentPage == 0) {
                            if (nameController.text.isEmpty) {
                              showSnackBarFun(
                                  context, "Name is required to continue");
                              return;
                            }
                            localStorage.write('username', nameController.text);
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else if (_currentPage < 2) {
                            if (state is CategoryList) {
                              if (state.categoryList.length >= 2) {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setStringList(
                                    'favoriteCategory', state.categoryList);

                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                showSnackBarFun(context,
                                    "At least two items should be selected. Currently selected: ${state.categoryList.length}");
                              }
                            }
                          } else {
                            log('The city name ${cityController.text}');
                            if (cityController.text.isNotEmpty) {
                              localStorage.write(
                                  'cityName', cityController.text);
                              localStorage.write('isLoggedIn', 'true');
                            }
                            localStorage.write('isLoggedIn', 'true');
                            context.read<SplashCubit>().getUsername();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NavBarPage(isInternetConnected: true),
                              ),
                            );
                          }
                        },
                        child: Text(
                          _currentPage < 2 ? 'Next' : 'Get Started',
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
