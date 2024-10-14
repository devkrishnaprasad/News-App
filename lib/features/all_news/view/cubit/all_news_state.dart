part of 'all_news_cubit.dart';

@immutable
abstract class AllNewsState {}

class AllNewsInitial extends AllNewsState {}

class AllNewsLoading extends AllNewsState {}

class AllNewsSuccess extends AllNewsState {
  final List<NewsResponse> newsList;

  AllNewsSuccess(this.newsList);
}

class AllNewsFailure extends AllNewsState {
  final String error;

  AllNewsFailure(this.error);
}

class AllNewsEmpty extends AllNewsState {}

class NewsSavedState extends AllNewsState {}

class NewsNotSavedState extends AllNewsState {}
