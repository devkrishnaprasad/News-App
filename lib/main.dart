import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app_test/core/themes/app_theme.dart';
import 'package:news_app_test/core/utils/location_service/cubit/location_cubit.dart';
import 'package:news_app_test/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:news_app_test/features/settings/views/cubit/settings_cubit.dart';
import 'package:news_app_test/features/settings/views/cubit/settings_state.dart';
import 'package:news_app_test/features/splash_screen/view/splash_screen.dart';
import 'package:news_app_test/features/splash_screen/view/cubit/splash_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashCubit()..getUsername(),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider(
          create: (context) => OnboardingCubit(),
        ),
        BlocProvider(
          create: (context) => LocationCubit(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme:
                state.themeMode ? AppTheme().darkTheme : AppTheme().lightTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
