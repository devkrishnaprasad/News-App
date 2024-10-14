import 'package:isar/isar.dart';
part "news_model.g.dart";

@collection
class NewsArticle {
  Id id = Isar.autoIncrement;
  late String sourceId;
  late String sourceName;
  String? author;
  late String title;
  late String description;
  late String url;
  late String urlToImage;
  late DateTime publishedAt;
  late String content;
}
