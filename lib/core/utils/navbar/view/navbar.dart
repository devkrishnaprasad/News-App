import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/core/utils/navbar/cubit/navbar_state.dart';
import 'package:news_app_test/features/all_news/view/all_news.dart';
import 'package:news_app_test/features/favourite_news/view/favourite_news.dart';
import 'package:news_app_test/features/saved_news/views/saved_news.dart';
import 'package:news_app_test/features/settings/views/settings.dart';
import 'package:news_app_test/features/splash_screen/view/cubit/splash_cubit.dart';

// ignore: use_key_in_widget_constructors
class NavBarPage extends StatelessWidget {
  final List<Widget> pages = [
    AllNews(),
    FavouriteNews(),
    SavedNews(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavbarCubit(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<SplashCubit, SplashState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      state is SplashNetworkError
                          ? Text(
                              '${state.greating ?? ''}, ${state.username ?? ''}')
                          : state is SplashLoaded
                              ? Text(
                                  '${state.greating ?? ''}, ${state.username ?? ''}')
                              : const SizedBox.shrink(),
                    ],
                  ),
                  state is SplashNetworkError
                      ? Text(
                          "${state.weather == null ? '' : state.weather!} ${state.weather == null ? '' : '°C'}")
                      : state is SplashLoaded
                          ? Text(
                              "${state.weather == null ? '' : state.weather!}  ${state.weather == null ? '' : '°C'}")
                          : const Text('')
                ],
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: BlocBuilder<NavbarCubit, int>(
          builder: (context, currentIndex) {
            return pages[currentIndex];
          },
        ),
        bottomNavigationBar: BlocBuilder<NavbarCubit, int>(
          builder: (context, currentIndex) {
            return BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<NavbarCubit>().selectTab(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper_sharp),
                  label: 'All News',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline),
                  label: 'Favourites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.save_alt_rounded),
                  label: 'saved news',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
