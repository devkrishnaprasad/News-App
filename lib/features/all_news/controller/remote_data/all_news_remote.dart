import 'package:chopper/chopper.dart';
part 'all_news_remote.chopper.dart';

@ChopperApi(baseUrl: 'top-headlines?')
abstract class AllNewsRemoteData extends ChopperService {
  @Get()
  Future<Response> fetchNewsHeadLine(
      @Query('country') String country, @Query('apiKey') String apiKey);

  static AllNewsRemoteData create([ChopperClient? client]) {
    return _$AllNewsRemoteData();
  }
}
