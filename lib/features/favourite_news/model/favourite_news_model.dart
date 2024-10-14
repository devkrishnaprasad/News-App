import 'package:freezed_annotation/freezed_annotation.dart';

part 'favourite_news_model.freezed.dart';
part 'favourite_news_model.g.dart';

// Main response model
@freezed
class NewsResponse with _$NewsResponse {
  factory NewsResponse({
    required String status,
    required int totalResults,
    required List<Article> articles,
  }) = _NewsResponse;

  factory NewsResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseFromJson(json);
}

// Article model
@freezed
class Article with _$Article {
  factory Article({
    required Source source,
    required String? author,
    required String? title,
    required String? description,
    required String? url,
    required String? urlToImage,
    required DateTime? publishedAt,
    required String? content,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}

// Source model
@freezed
class Source with _$Source {
  factory Source({
    String? id,
    required String name,
  }) = _Source;

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
}
