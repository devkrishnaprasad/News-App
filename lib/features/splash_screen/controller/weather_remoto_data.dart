import 'package:chopper/chopper.dart';
part 'weather_remoto_data.chopper.dart';

@ChopperApi(baseUrl: 'current.json')
abstract class WeatherRemoteData extends ChopperService {
  @Get()
  Future<Response> fetchWeather(
      @Query('q') String location, @Query('key') String apiKey);

  static WeatherRemoteData create([ChopperClient? client]) {
    return _$WeatherRemoteData();
  }
}
