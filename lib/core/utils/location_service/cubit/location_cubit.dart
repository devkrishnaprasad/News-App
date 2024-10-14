// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:chopper/chopper.dart';
import 'package:news_app_test/core/utils/location_service/cubit/location_state.dart';
import 'package:news_app_test/core/utils/location_service/remote/location_chopper.dart';
import 'package:news_app_test/core/utils/wrapper.dart';

// Define the states

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<void> fetchCurrentLocation() async {
    emit(LocationLoading());
    try {
      AppWrapper appWrapper = AppWrapper();
      bool status = await appWrapper.internetCheckConnection();
      if (status) {
        final chopper = ChopperClient(
          baseUrl: Uri.https('api.bigdatacloud.net'),
          services: [LocationData.create()],
        );

        final locationService = chopper.getService<LocationData>();
        final response = await locationService.fetchCurrentLocation();

        if (response.isSuccessful) {
          final responseData = jsonDecode(response.body);
          emit(LocationLoaded(responseData['city']));
        } else {
          log("Data is not successful: ${response.error}");
          emit(LocationError("Failed to fetch location data"));
        }
      } else {
        emit(LocationError("Network Error "));
      }
    } catch (e) {
      log('The Error is $e');
      emit(LocationError("An error occurred: $e"));
    }
  }
}
