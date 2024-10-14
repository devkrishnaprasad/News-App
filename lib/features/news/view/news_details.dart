// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/features/favourite_news/view/cubit/favourite_cubit.dart';
import 'package:news_app_test/features/favourite_news/view/cubit/favourite_state.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news_app_test/core/utils/wrapper.dart';

// ignore: must_be_immutable
class NewsDetails extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var article;
  NewsDetails({
    super.key,
    required this.article,
  });
  AppWrapper appWrapper = AppWrapper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Deatils'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title == null ? '' : article.title!,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appWrapper.dateFormating(article.publishedAt!)),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Share.share(article.url == null ? '' : article.url!,
                              subject: 'News');
                        },
                        icon: const Icon(Icons.share),
                      ),
                      BlocProvider(
                        create: (context) => FavouriteNewsCubit()
                          ..checkIsSavedNews(article.title!),
                        child:
                            BlocBuilder<FavouriteNewsCubit, FavouriteNewsState>(
                          builder: (context, state) {
                            return IconButton(
                              onPressed: () {
                                if (state is NewsSavedState) {
                                } else {
                                  context
                                      .read<FavouriteNewsCubit>()
                                      .saveNewOffline([article]);
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
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              article.urlToImage == null
                  ? const SizedBox()
                  : SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: CachedNetworkImage(
                        imageUrl: article.urlToImage!,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
              const SizedBox(height: 10),
              Text(article.content == null ? '' : article.content!),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      if (!await launchUrl(Uri.parse(article.url!))) {
                        throw Exception('Could not launch ${article.url!}');
                      }
                    },
                    child: const Text('Read Full News')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
