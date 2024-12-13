part of 'button_cubit.dart';

abstract class ButtonState {}

class ButtonInitial extends ButtonState {}

class ButtonLoading extends ButtonState {}

class ButtonLoaded extends ButtonState {
  final String role;
  final bool success;
  final String message;

  ButtonLoaded({required this.role, required this.success, required this.message});
}

class ButtonFailure extends ButtonState {
  final AppErrorType errorType;

  ButtonFailure({required this.errorType});
}
