// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/core/utils/navbar/cubit/navbar_state.dart';
import 'package:news_app_test/core/utils/navbar/view/navbar.dart';
import 'package:news_app_test/features/onboarding/view/onboarding_controller.dart';
import 'package:news_app_test/features/splash_screen/view/cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            if (state.isLoggedIn) {
              context.read<NavbarCubit>().selectTab(0);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => NavBarPage(
                          isInternetConnected: true,
                        )),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const OnboardingScreen()),
              );
            }
          }
          if (state is SplashNetworkError) {
            if (state.isLoggedIn) {
              context.read<NavbarCubit>().selectTab(2);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => NavBarPage(
                          isInternetConnected: false,
                        )),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const OnboardingScreen()),
              );
            }
          } else if (state is SplashError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Center(
          child: Image.asset(
            'assets/images/news.png',
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
