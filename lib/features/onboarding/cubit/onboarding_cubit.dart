// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  void toggleSelection(String itemName) {
    List<String> currentSelection = [];
    if (state is CategoryList) {
      currentSelection =
          List<String>.from((state as CategoryList).categoryList);
    }
    if (currentSelection.contains(itemName)) {
      currentSelection.remove(itemName);
    } else {
      if (currentSelection.length < 4) {
        currentSelection.add(itemName);
      }
    }
    emit(CategoryList(categoryList: currentSelection));
  }
}
