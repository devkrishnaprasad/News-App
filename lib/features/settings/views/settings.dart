import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/core/utils/navbar/view/navbar.dart';
import 'package:news_app_test/core/utils/location_service/cubit/location_cubit.dart';
import 'package:news_app_test/core/utils/location_service/cubit/location_state.dart';
import 'package:news_app_test/core/utils/snackbar.dart';
import 'package:news_app_test/features/settings/views/cubit/settings_cubit.dart';
import 'package:news_app_test/features/settings/views/cubit/settings_state.dart';
import 'package:textfield_tags/textfield_tags.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final _stringTagController = StringTagController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NavBarPage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            final usernameController =
                TextEditingController(text: state.username);

            final cityController = TextEditingController(text: state.city);

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.light_mode_outlined),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Choose Theme'),
                            Text(state.themeMode ? 'Dark' : 'Light'),
                          ],
                        ),
                      ],
                    ),
                    Switch(
                      value: state.themeMode,
                      onChanged: (bool value) {
                        context.read<SettingsCubit>().toggleTheme();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                const SizedBox(height: 10),
                TextFieldTags<String>(
                  textfieldTagsController: _stringTagController,
                  initialTags: state.favoriteCategories,
                  textSeparators: const [' ', ','],
                  letterCase: LetterCase.normal,
                  validator: (String tag) {
                    if (tag == 'php') {
                      return 'No, please just no';
                    } else if (_stringTagController.getTags!.contains(tag)) {
                      return 'You\'ve already entered that';
                    }
                    return null;
                  },
                  inputFieldBuilder: (context, inputFieldValues) {
                    return TextField(
                      onTap: () {
                        _stringTagController.getFocusNode?.requestFocus();
                      },
                      controller: inputFieldValues.textEditingController,
                      focusNode: inputFieldValues.focusNode,
                      decoration: InputDecoration(
                        labelText: 'Favourite Category',
                        isDense: true,
                        helperStyle: const TextStyle(
                          color: Color.fromARGB(255, 74, 137, 92),
                        ),
                        hintText: inputFieldValues.tags.isNotEmpty
                            ? ''
                            : "Enter tag...",
                        errorText: inputFieldValues.error,
                        prefixIcon: inputFieldValues.tags.isNotEmpty
                            ? SingleChildScrollView(
                                controller:
                                    inputFieldValues.tagScrollController,
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 8,
                                    left: 8,
                                  ),
                                  child: Wrap(
                                      runSpacing: 4.0,
                                      spacing: 4.0,
                                      children: inputFieldValues.tags
                                          .map((String tag) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20.0),
                                            ),
                                            color: Color.fromARGB(
                                                255, 70, 155, 224),
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                child: Text(
                                                  tag,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                onTap: () {},
                                              ),
                                              const SizedBox(width: 4.0),
                                              InkWell(
                                                child: const Icon(
                                                  Icons.cancel,
                                                  size: 14.0,
                                                  color: Color.fromARGB(
                                                      255, 233, 233, 233),
                                                ),
                                                onTap: () {
                                                  inputFieldValues
                                                      .onTagRemoved(tag);
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList()),
                                ),
                              )
                            : null,
                      ),
                      onChanged: inputFieldValues.onTagChanged,
                      onSubmitted: inputFieldValues.onTagSubmitted,
                    );
                  },
                ),
                const SizedBox(height: 10),
                BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, locationState) {
                    if (locationState is LocationLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (locationState is LocationError) {
                      return Center(
                          child: Text('Error: ${locationState.message}'));
                    }
                    return TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                          labelText: 'Your City',
                          suffixIcon: IconButton(
                            onPressed: () {
                              context
                                  .read<LocationCubit>()
                                  .fetchCurrentLocation();

                              if (locationState is LocationLoaded) {
                                cityController.text =
                                    locationState.locationData;
                              }
                            },
                            icon: const Icon(Icons.location_searching),
                          )),
                    );
                  },
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    try {
                      context.read<SettingsCubit>().updateUserSettings(
                            usernameController.text,
                            state.favoriteCategories!,
                            cityController.text,
                          );
                      showSnackBarFun(context, 'User data are updated');
                    } catch (e) {
                      showSnackBarFun(context, 'Failed to update');
                    }
                  },
                  child: const Text('Update Settings'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
