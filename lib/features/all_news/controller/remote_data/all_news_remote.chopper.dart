// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_news_remote.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AllNewsRemoteData extends AllNewsRemoteData {
  _$AllNewsRemoteData([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AllNewsRemoteData;

  @override
  Future<Response<dynamic>> fetchNewsHeadLine(
    String country,
    String apiKey,
  ) {
    final Uri $url = Uri.parse('top-headlines?');
    final Map<String, dynamic> $params = <String, dynamic>{
      'country': country,
      'apiKey': apiKey,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
