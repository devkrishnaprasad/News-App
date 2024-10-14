part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashLoaded extends SplashState {
  final bool isLoggedIn;
  final String? username;
  final String? greating;
  final String? weather;

  SplashLoaded(
      {required this.isLoggedIn, this.username, this.greating, this.weather});
}

final class SplashError extends SplashState {
  final String message;

  SplashError(this.message);
}

final class SplashNetworkError extends SplashState {
  final String message;
  final bool isLoggedIn;
  final String? username;
  final String? greating;
  final String? weather;

  SplashNetworkError(
      {required this.message,
      required this.isLoggedIn,
      this.username,
      this.greating,
      this.weather});
}
