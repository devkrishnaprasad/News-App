// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app_test/core/utils/local_storage/local_database.dart';
import 'package:news_app_test/core/utils/wrapper.dart';
import 'package:news_app_test/features/all_news/controller/news_controller.dart';
import 'package:news_app_test/features/all_news/model/all_news_model.dart';
part 'all_news_state.dart';

class AllNewsCubit extends Cubit<AllNewsState> {
  final NewsRepository newsRepository;

  AllNewsCubit(this.newsRepository) : super(AllNewsInitial());

  Future<void> fetchAllNews() async {
    AppWrapper appWrapper = AppWrapper();
    try {
      emit(AllNewsLoading());
      bool stauts = await appWrapper.internetCheckConnection();
      if (stauts) {
        final newsResponse = await newsRepository.fetchNewsHeadLine();

        if (newsResponse == null || newsResponse.articles.isEmpty) {
          emit(AllNewsEmpty());
        } else {
          emit(AllNewsSuccess([newsResponse]));
        }
      } else {
        emit(AllNewsFailure('Internet Not Connected'));
      }
    } catch (e) {
      emit(AllNewsFailure(e.toString()));
    }
  }

  saveNewOffline(List<Article> data) async {
    LocalDBService localDBSerive = LocalDBService();

    await localDBSerive.insertNewsArticle(
        data[0].source!.id ?? '',
        data[0].source!.name,
        data[0].author ?? '',
        data[0].title == null ? '' : data[0].title!,
        data[0].description == null ? '' : data[0].description!,
        data[0].url == null ? '' : data[0].url!,
        data[0].urlToImage == null ? '' : data[0].urlToImage!,
        data[0].publishedAt == null ? '' : data[0].publishedAt!,
        data[0].content == null ? '' : data[0].content!);
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
}
