import 'package:chopper/chopper.dart';
part 'location_chopper.chopper.dart';

@ChopperApi(baseUrl: 'data/reverse-geocode-client')
abstract class LocationData extends ChopperService {
  @Get()
  Future<Response> fetchCurrentLocation();

  static LocationData create([ChopperClient? client]) {
    return _$LocationData();
  }
}
