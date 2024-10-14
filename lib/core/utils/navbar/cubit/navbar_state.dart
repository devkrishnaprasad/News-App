// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

class NavbarCubit extends Cubit<int> {
  NavbarCubit() : super(0);

  void selectTab(int index) {
    emit(index);
  }
}
