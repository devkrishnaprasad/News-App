part of 'onboarding_cubit.dart';

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class CategoryList extends OnboardingState {
  final List<String> categoryList;

  CategoryList({required this.categoryList});
}
