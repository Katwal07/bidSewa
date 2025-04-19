
abstract class ButtonStateA {}

class ButtonInitialA extends ButtonStateA {}

class ButtonLoadingA extends ButtonStateA {}

class ButtonLoadedA extends ButtonStateA {
  final String role;
  final bool success;
  final String message;

  ButtonLoadedA({required this.role, required this.success, required this.message});
}

class ButtonFailureA extends ButtonStateA {
  final String errorMessage;

  ButtonFailureA({required this.errorMessage});
}
