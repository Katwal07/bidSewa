abstract class PasswordVisibilityState {}

class PasswordVisibilityInitial extends PasswordVisibilityState {
  final bool obscureText;

  PasswordVisibilityInitial({required this.obscureText});
}

class PasswordVisibilityLoaded extends PasswordVisibilityState {
  final bool obscureText;

  PasswordVisibilityLoaded({required this.obscureText});
}
