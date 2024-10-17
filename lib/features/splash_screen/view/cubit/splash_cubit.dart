// ignore_for_file: depend_on_referenced_packages, unnecessary_null_comparison
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:meta/meta.dart';
import 'package:news_app_test/core/utils/local_storage/local_storage.dart';
import 'package:news_app_test/core/utils/wrapper.dart';
import 'package:news_app_test/features/splash_screen/controller/weather_remoto_data.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> getUsername() async {
    AppWrapper appWrapper = AppWrapper();
    LocalStorage localStorage = LocalStorage();
    try {
      var isLoggedIn = await localStorage.read('isLoggedIn');
      if (isLoggedIn != null) {
        var username = await localStorage.read('username');
        var cityName = await localStorage.read('cityName');
        if (cityName != null) {
          bool staus = await appWrapper.internetCheckConnection();

          if (staus == true) {
            emit(
              SplashLoaded(
                isLoggedIn: true,
                username: username,
                greating: _getGreetingMessage(),
                weather: await fetchWeather(cityName),
              ),
            );
          } else {
            emit(
              SplashNetworkError(
                message: 'Internet Not Connected',
                isLoggedIn: true,
                username: username,
                greating: _getGreetingMessage(),
              ),
            );
          }
        } else {
          emit(
            SplashLoaded(
              isLoggedIn: true,
              username: username,
              greating: _getGreetingMessage(),
            ),
          );
        }
      } else {
        emit(SplashLoaded(isLoggedIn: false));
      }
    } catch (e) {
      emit(SplashError('Failed to load username $e'));
    }
  }

  String _getGreetingMessage() {
    int hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  fetchWeather(String cityName) async {
    try {
      final chopper = ChopperClient(
        baseUrl: Uri.https('api.weatherapi.com', '/v1/'),
        services: [WeatherRemoteData.create()],
      );

      final weatherService = chopper.getService<WeatherRemoteData>();
      var response = await weatherService.fetchWeather(
        cityName,
        dotenv.env['WEATHER_API_KEY']!,
      );

      if (response.isSuccessful) {
        final responseData = jsonDecode(response.body);
        final tempC = responseData['current']['temp_c'];
        final conditionText = responseData['current']['condition']['text'];

        return '$conditionText $tempC';
      } else {}
    } catch (e) {
      log('The Error is $e');
    }
  }
}
