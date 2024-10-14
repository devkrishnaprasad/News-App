import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app_test/features/favourite_news/model/favourite_news_model.dart';

@immutable
abstract class FavouriteNewsState {}

class FavouriteNewsInitial extends FavouriteNewsState {}

class FavouriteNewsLoading extends FavouriteNewsState {}

class FavouriteNewsSuccess extends FavouriteNewsState {
  final List<NewsResponse> newsList;

  FavouriteNewsSuccess(this.newsList);
}

class FavouriteNewsFailure extends FavouriteNewsState {
  final String error;

  FavouriteNewsFailure(this.error);
}

class FavouriteNewsEmpty extends FavouriteNewsState {}

class NewsSavedState extends FavouriteNewsState {}

class NewsNotSavedState extends FavouriteNewsState {}

class FavouriteCategoryLoaded extends FavouriteNewsState {
  final List<String> categoryList;

  FavouriteCategoryLoaded({required this.categoryList});
}

class FavouriteCategoryLoading extends FavouriteNewsState {}

class FavouriteCategoryFailed extends FavouriteNewsState {
  final String errorMessage;

  FavouriteCategoryFailed({required this.errorMessage});
}
