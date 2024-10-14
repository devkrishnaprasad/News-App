// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/core/utils/location_service/cubit/location_cubit.dart';
import 'package:news_app_test/core/utils/location_service/cubit/location_state.dart';

class OnboardingPage3 extends StatelessWidget {
  final TextEditingController cityController;
  const OnboardingPage3({
    super.key,
    required this.cityController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<LocationCubit, LocationState>(
              builder: (context, locationState) {
                if (locationState is LocationLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (locationState is LocationError) {
                  return Center(child: Text('Error: ${locationState.message}'));
                }
                return TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                      labelText: 'Your City',
                      suffixIcon: IconButton(
                        onPressed: () {
                          context.read<LocationCubit>().fetchCurrentLocation();

                          if (locationState is LocationLoaded) {
                            cityController.text = locationState.locationData;
                          }
                        },
                        icon: const Icon(Icons.location_searching),
                      )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
