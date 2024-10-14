// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_remoto_data.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$WeatherRemoteData extends WeatherRemoteData {
  _$WeatherRemoteData([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = WeatherRemoteData;

  @override
  Future<Response<dynamic>> fetchWeather(
    String location,
    String apiKey,
  ) {
    final Uri $url = Uri.parse('current.json');
    final Map<String, dynamic> $params = <String, dynamic>{
      'q': location,
      'key': apiKey,
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
