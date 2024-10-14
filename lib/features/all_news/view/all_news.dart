import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/core/themes/fonts.dart';
import 'package:news_app_test/features/all_news/controller/news_controller.dart';
import 'package:news_app_test/features/all_news/view/cubit/all_news_cubit.dart';
import 'package:news_app_test/features/news/view/news_details.dart';
import 'package:news_app_test/features/settings/views/cubit/settings_cubit.dart';
import 'package:news_app_test/features/settings/views/cubit/settings_state.dart';

class AllNews extends StatelessWidget {
  AllNews({super.key});
  final NewsRepository newsRepository = NewsRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllNewsCubit(newsRepository)..fetchAllNews(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<AllNewsCubit, AllNewsState>(
          builder: (context, state) {
            if (state is AllNewsFailure) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state is AllNewsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AllNewsSuccess) {
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var data = state.newsList[0].articles[index];
                  return GestureDetector(
                    onTap: () {
                      var data = state.newsList[0].articles[index];
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NewsDetails(article: data),
                        ),
                      );
                    },
                    child: BlocBuilder<SettingsCubit, SettingsState>(
                      builder: (context, state) {
                        return Container(
                          decoration: BoxDecoration(
                            color: state.themeMode
                                ? const Color.fromARGB(255, 29, 28, 28)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                        AllNewsCubit(newsRepository)
                                          ..checkIsSavedNews(data.title!),
                                    child:
                                        BlocBuilder<AllNewsCubit, AllNewsState>(
                                      builder: (context, state) {
                                        return IconButton(
                                          onPressed: () {
                                            if (state is NewsSavedState) {
                                              context
                                                  .read<AllNewsCubit>()
                                                  .removeFromSavedList(
                                                      data.title!);
                                            } else {
                                              context
                                                  .read<AllNewsCubit>()
                                                  .saveNewOffline([data]);
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
              );
            } else if (state is AllNewsFailure) {
              return Center(
                child: Text('Error: ${state.error}'),
              );
            } else {
              return const Center(child: Text('No news available'));
            }
          },
        ),
      ),
    );
  }
}
