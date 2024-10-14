part of 'saved_news_cubit.dart';

@immutable
abstract class SavedNewsState {}

class SavedNewsInitial extends SavedNewsState {}

class SavedNewsLoading extends SavedNewsState {}

class SavedNewsSuccess extends SavedNewsState {
  final List<NewsArticle> savedNewsList;

  SavedNewsSuccess({required this.savedNewsList});
}

class SavedNewsFailure extends SavedNewsState {
  final String error;

  SavedNewsFailure(this.error);
}

class SavedNewsEmpty extends SavedNewsState {}

class AllNewsEmpty extends SavedNewsState {}
