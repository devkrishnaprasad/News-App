import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/core/themes/fonts.dart';
import 'package:news_app_test/features/news/view/news_details.dart';
import 'package:news_app_test/features/saved_news/views/cubit/saved_news_cubit.dart';
import 'package:news_app_test/features/settings/views/cubit/settings_cubit.dart';
import 'package:news_app_test/features/settings/views/cubit/settings_state.dart';

class SavedNews extends StatelessWidget {
  const SavedNews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SavedNewsCubit()..fetchSavedNews(),
      child: BlocBuilder<SavedNewsCubit, SavedNewsState>(
        builder: (context, state) {
          if (state is SavedNewsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SavedNewsEmpty) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text('There is no new saved yet')),
              ],
            );
          }
          if (state is SavedNewsSuccess) {
            return ListView.separated(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var data = state.savedNewsList[index];
                return GestureDetector(
                  onTap: () {
                    var data = state.savedNewsList[index];

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NewsDetails(
                          article: data,
                          isSavedNews: true,
                        ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    data.title,
                                    style: AppFonts.labelText,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<SavedNewsCubit>()
                                        .removeFromSavedList(data.title);
                                  },
                                  icon:
                                      const Icon(Icons.delete_forever_outlined),
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
              itemCount: state.savedNewsList.length,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
