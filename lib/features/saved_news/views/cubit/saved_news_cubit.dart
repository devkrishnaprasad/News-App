// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app_test/core/utils/local_storage/local_database.dart';
import 'package:news_app_test/core/utils/local_storage/model/news_model.dart';

part 'saved_news_state.dart';

class SavedNewsCubit extends Cubit<SavedNewsState> {
  SavedNewsCubit() : super(SavedNewsInitial());
  fetchSavedNews() async {
    emit(SavedNewsLoading());
    try {
      LocalDBService localDBSerive = LocalDBService();
      List<NewsArticle> data = await localDBSerive.getNewsArticles();
      if (data.isEmpty) {
        emit(SavedNewsEmpty());
      } else {
        emit(SavedNewsSuccess(savedNewsList: data));
      }
    } catch (e) {
      emit(SavedNewsFailure(e.toString()));
    }
  }

  removeFromSavedList(title) async {
    LocalDBService localDBService = LocalDBService();
    try {
      await localDBService.deleteNewsArticleByTitle(title);
      final updatedNewsList = await localDBService.getNewsArticles();
      if (updatedNewsList.isEmpty) {
        emit(SavedNewsEmpty());
      } else {
        emit(SavedNewsSuccess(savedNewsList: updatedNewsList));
      }
    } catch (e) {
      emit(SavedNewsFailure(e.toString()));
    }
  }
}
