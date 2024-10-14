import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/core/themes/fonts.dart';
import 'package:news_app_test/features/favourite_news/controller/favoutite_controller.dart';
import 'package:news_app_test/features/favourite_news/view/cubit/favourite_cubit.dart';
import 'package:news_app_test/features/favourite_news/view/cubit/favourite_state.dart';
import 'package:news_app_test/features/news/view/news_details.dart';
import 'package:news_app_test/features/settings/views/cubit/settings_cubit.dart';
import 'package:news_app_test/features/settings/views/cubit/settings_state.dart';

class FavouriteNews extends StatelessWidget {
  FavouriteNews({super.key});
  final NewsRepository newsRepository = NewsRepository();

  get itemCount => null;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteNewsCubit(newsRepository: newsRepository)
        ..fetchFavouriteNews(),
      child: BlocBuilder<FavouriteNewsCubit, FavouriteNewsState>(
        builder: (context, state) {
          if (state is FavouriteNewsFailure) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is FavouriteNewsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FavouriteNewsFailure) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Something went worng'),
                ),
              ],
            );
          }

          if (state is FavouriteNewsSuccess) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: BlocProvider(
                  create: (context) =>
                      FavouriteNewsCubit(newsRepository: newsRepository)
                        ..fetchFavouriteCategory(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                        child:
                            BlocBuilder<FavouriteNewsCubit, FavouriteNewsState>(
                          builder: (context, state) {
                            if (state is FavouriteCategoryLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is FavouriteCategoryFailed) {
                              return Text(
                                  'Failed to load categoty list ${state.errorMessage}');
                            }
                            if (state is FavouriteCategoryLoaded) {
                              return ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final category = state.categoryList[index];
                                  final isSelected = category ==
                                      (context
                                          .read<FavouriteNewsCubit>()
                                          .selectedCategory);

                                  return GestureDetector(
                                    onTap: () {
                                      context
                                          .read<FavouriteNewsCubit>()
                                          .selectCategory(category);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          category,
                                          style: AppFonts.labelText.copyWith(),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 10),
                                itemCount: state.categoryList.length,
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var data = state.newsList[0].articles[index];
                          return GestureDetector(
                            onTap: () {
                              var data = state.newsList[0].articles[index];
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NewsDetails(article: data),
                                ),
                              );
                            },
                            child: BlocBuilder<SettingsCubit, SettingsState>(
                              builder: (context, state) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: state.themeMode
                                        ? const Color.fromARGB(255, 29, 28, 28)
                                        : Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              data.title!,
                                              style: AppFonts.labelText,
                                            ),
                                          ),
                                          BlocProvider(
                                            create: (context) =>
                                                FavouriteNewsCubit()
                                                  ..checkIsSavedNews(
                                                      data.title!),
                                            child: BlocBuilder<
                                                FavouriteNewsCubit,
                                                FavouriteNewsState>(
                                              builder: (context, state) {
                                                return IconButton(
                                                  onPressed: () {
                                                    if (state
                                                        is NewsSavedState) {
                                                    } else {
                                                      context
                                                          .read<
                                                              FavouriteNewsCubit>()
                                                          .saveNewOffline(
                                                              [data]);
                                                    }
                                                  },
                                                  icon: state is NewsSavedState
                                                      ? Image.asset(
                                                          'assets/images/remove_ic.png',
                                                          width: 20,
                                                          height: 20,
                                                        )
                                                      : Image.asset(
                                                          'assets/images/save_ic.png',
                                                          width: 20,
                                                          height: 20,
                                                        ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 5);
                        },
                        itemCount: state.newsList[0].articles.length,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
