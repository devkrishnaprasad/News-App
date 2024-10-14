// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:news_app_test/core/utils/local_storage/local_database.dart';
import 'package:news_app_test/core/utils/wrapper.dart';

import 'package:news_app_test/features/favourite_news/controller/favoutite_controller.dart';
import 'package:news_app_test/features/favourite_news/model/favourite_news_model.dart';
import 'package:news_app_test/features/favourite_news/view/cubit/favourite_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteNewsCubit extends Cubit<FavouriteNewsState> {
  final NewsRepository? newsRepository;
  String? selectedCategory;
  FavouriteNewsCubit({this.newsRepository}) : super(FavouriteNewsInitial());

  fetchFavouriteCategory() async {
    print('loading %%%%%%%%%%%%%');
    emit(FavouriteCategoryLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? items = prefs.getStringList('favoriteCategory');

      if (items != null && items.isNotEmpty) {
        selectedCategory = items[0];
      }

      emit(FavouriteCategoryLoaded(categoryList: items ?? []));
    } catch (e) {
      emit(FavouriteCategoryFailed(errorMessage: e.toString()));
    }
  }

  Future<void> fetchFavouriteNews() async {
    AppWrapper appWrapper = AppWrapper();
    try {
      emit(FavouriteNewsLoading());
      bool status = await appWrapper.internetCheckConnection();

      if (status) {
        final newsResponse =
            await newsRepository!.fetchFavouriteHeadLine('sports');

        if (newsResponse == null || newsResponse.articles.isEmpty) {
          emit(FavouriteNewsEmpty());
        } else {
          emit(FavouriteNewsSuccess([newsResponse]));
        }
      } else {
        emit(FavouriteNewsFailure('Internet issue'));
      }
    } catch (e) {
      emit(FavouriteNewsFailure(e.toString()));
    }
  }

  saveNewOffline(List<Article> data) async {
    LocalDBService localDBSerive = LocalDBService();

    await localDBSerive.insertNewsArticle(
        data[0].source.id,
        data[0].source.name,
        data[0].author,
        data[0].title!,
        data[0].description!,
        data[0].url!,
        data[0].urlToImage!,
        data[0].publishedAt!,
        data[0].content!);
    emit(NewsSavedState());
  }

  Future<void> checkIsSavedNews(String title) async {
    LocalDBService localDBService = LocalDBService();
    final isSaved = await localDBService.searchNewsArticlesByTitle(title);
    if (isSaved) {
      emit(NewsSavedState());
    } else {
      emit(NewsNotSavedState());
    }
  }

  removeFromSavedList(title) async {
    LocalDBService localDBService = LocalDBService();
    await localDBService.deleteNewsArticleByTitle(title);
    emit(NewsNotSavedState());
  }

  void selectCategory(String category) {
    selectedCategory = category;
    emit(FavouriteCategoryLoaded(
        categoryList: (state as FavouriteCategoryLoaded).categoryList));
  }
}
