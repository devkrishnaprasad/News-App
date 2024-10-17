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

class SavedImageLoading extends SavedNewsState {}

class SavedImagedLoaded extends SavedNewsState {
  final String imagePath;

  SavedImagedLoaded({required this.imagePath});
}

class SavedImagedLoadingFailed extends SavedNewsState {
  late final String errorMessage;
}
