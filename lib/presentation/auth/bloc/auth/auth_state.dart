part of 'auth_cubit.dart';

abstract class AuthState {}

class ButtonInitialState extends AuthState {}

class ButtonLoadingState extends AuthState {}

class ButtonLoadedState extends AuthState {
  final String role;
  final bool success;
  final String message;

  ButtonLoadedState({
    required this.role,
    required this.success,
    required this.message,
  });
}

class ButtonFailureState extends AuthState {
  final String errorMessage;

  ButtonFailureState({required this.errorMessage});
}
