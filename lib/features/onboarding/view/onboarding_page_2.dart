import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/core/constants/strings.dart';
import 'package:news_app_test/core/themes/fonts.dart';
import 'package:news_app_test/features/onboarding/cubit/onboarding_cubit.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, state) {
                  List<String> selectedItems = [];

                  if (state is CategoryList) {
                    selectedItems = List<String>.from(state.categoryList);
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 5,
                    ),
                    itemCount: categoryMap.length,
                    itemBuilder: (context, index) {
                      String key = categoryMap.values.elementAt(index);
                      bool isSelected = selectedItems.contains(key);

                      return GestureDetector(
                        onTap: () {
                          context.read<OnboardingCubit>().toggleSelection(key);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isSelected ? Colors.blue : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              key,
                              style: AppFonts.cardTitle,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
