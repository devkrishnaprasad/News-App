// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_favourite_remote.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$FavouriteNewsRemoteData extends FavouriteNewsRemoteData {
  _$FavouriteNewsRemoteData([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = FavouriteNewsRemoteData;

  @override
  Future<Response<dynamic>> fetchNewsHeadLine(
    String country,
    String category,
    String apiKey,
  ) {
    final Uri $url = Uri.parse('top-headlines?');
    final Map<String, dynamic> $params = <String, dynamic>{
      'country': country,
      'category': category,
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
