import 'dart:convert';
import 'dart:developer';
import 'package:chopper/chopper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app_test/features/favourite_news/controller/remote_data/fetch_favourite_remote.dart';
import 'package:news_app_test/features/favourite_news/model/favourite_news_model.dart';

class NewsRepository {
  Future<NewsResponse?> fetchFavouriteHeadLine(category) async {
    try {
      final chopper = ChopperClient(
        baseUrl: Uri.https('newsapi.org', '/v2/'),
        services: [FavouriteNewsRemoteData.create()],
      );

      final newsService = chopper.getService<FavouriteNewsRemoteData>();
      final response = await newsService.fetchNewsHeadLine(
        'us',
        category,
        dotenv.env['NEWS_API_KEY']!,
      );

      if (response.isSuccessful) {
        final responseData = jsonDecode(response.body);
        return NewsResponse.fromJson(responseData);
      } else {
        log("Data is not successful: ${response.error}");
      }
    } catch (e) {
      log('The Error is $e');
    }
    return null;
  }
}
