// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_chopper.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$LocationData extends LocationData {
  _$LocationData([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = LocationData;

  @override
  Future<Response<dynamic>> fetchCurrentLocation() {
    final Uri $url = Uri.parse('data/reverse-geocode-client');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
