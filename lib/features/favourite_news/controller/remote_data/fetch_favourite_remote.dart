import 'package:chopper/chopper.dart';
part 'fetch_favourite_remote.chopper.dart';

@ChopperApi(baseUrl: 'top-headlines?')
abstract class FavouriteNewsRemoteData extends ChopperService {
  @Get()
  Future<Response> fetchNewsHeadLine(@Query('country') String country,
      @Query('category') String category, @Query('apiKey') String apiKey);

  static FavouriteNewsRemoteData create([ChopperClient? client]) {
    return _$FavouriteNewsRemoteData();
  }
}
