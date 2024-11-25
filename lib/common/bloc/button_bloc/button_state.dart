part of 'button_cubit.dart';

abstract class ButtonState {}

class ButtonInitial extends ButtonState {}

class ButtonLoading extends ButtonState {}

class ButtonLoaded extends ButtonState {
  final bool success;
  final String message;

  ButtonLoaded({required this.success, required this.message});
}

class ButtonFailure extends ButtonState {
  final String message;

  ButtonFailure({required this.message});
}
