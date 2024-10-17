// ignore_for_file: depend_on_referenced_packages
import 'dart:io';
import 'package:isar/isar.dart';
import 'package:news_app_test/core/utils/local_storage/model/news_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class LocalDBService {
  static Isar? _isarInstance;

  Future<Isar> getIsarInstance() async {
    if (_isarInstance == null) {
      final dir = await getApplicationDocumentsDirectory();
      _isarInstance = await Isar.open([NewsArticleSchema], directory: dir.path);
    }
    return _isarInstance!;
  }

  Future<void> insertNewsArticle(sourceId, sourceName, author, title,
      description, url, urlToImage, publishedAt, content) async {
    final isar = await getIsarInstance();

    final newsArticle = NewsArticle()
      ..sourceId = sourceId ?? ""
      ..sourceName = sourceName
      ..author = author
      ..title = title
      ..description = description
      ..url = url
      ..urlToImage = urlToImage
      ..publishedAt = DateTime.parse(publishedAt.toString())
      ..content = content;

    await isar.writeTxn(() async {
      await isar.newsArticles.put(newsArticle);
    });
    await downloadAndSaveImage(urlToImage, title);
  }

  Future<List<NewsArticle>> getNewsArticles() async {
    final isar = await getIsarInstance();
    return await isar.newsArticles.where().findAll();
  }

  Future<bool> searchNewsArticlesByTitle(String title) async {
    final isar = await getIsarInstance();
    final result = await isar.newsArticles
        .filter()
        .titleContains(title, caseSensitive: false)
        .findAll();
    return result.isNotEmpty;
  }

  Future<void> deleteNewsArticleByTitle(String title) async {
    final isar = await getIsarInstance();
    final articles = await isar.newsArticles
        .filter()
        .titleEqualTo(title, caseSensitive: false)
        .findAll();
    if (articles.isNotEmpty) {
      await isar.writeTxn(() async {
        await isar.newsArticles.delete(articles[0].id);
      });
    }
  }

  Future<void> clearAllData() async {
    final isar = await getIsarInstance();
    await isar.writeTxn(() async {
      await isar.newsArticles.clear();
    });
  }

  Future<void> closeIsarInstance() async {
    if (_isarInstance != null) {
      await _isarInstance!.close();
      _isarInstance = null;
    }
  }

  Future<File> downloadAndSaveImage(String imageUrl, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(imageUrl));
    final file = File(filePath);
    return file.writeAsBytes(response.bodyBytes);
  }

  Future<String?> getLocalImagePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);

    if (await file.exists()) {
      return filePath;
    }
    return null;
  }
}
