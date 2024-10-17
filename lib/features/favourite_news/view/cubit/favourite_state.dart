// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:news_app_test/features/favourite_news/model/favourite_news_model.dart';

@immutable
abstract class FavouriteNewsState {}

class FavouriteNewsInitial extends FavouriteNewsState {}

class FavouriteNewsLoading extends FavouriteNewsState {}

class FavouriteNewsSuccess extends FavouriteNewsState {
  final List<NewsResponse> newsList;
  final List<String> category;

  FavouriteNewsSuccess(
    this.newsList,
    this.category,
  );
}

class FavouriteNewsFailure extends FavouriteNewsState {
  final String error;

  FavouriteNewsFailure(this.error);
}

class FavouriteNewsEmpty extends FavouriteNewsState {}

class NewsSavedState extends FavouriteNewsState {}

class NewsNotSavedState extends FavouriteNewsState {}
