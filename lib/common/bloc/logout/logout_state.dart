abstract class LogoutState {}

class LogoutInitial extends LogoutState{}

class LogoutLoading extends LogoutState{}

class LogoutSuccess extends LogoutState{}

class LogoutFailure extends LogoutState{
  final String errorMessage;

  LogoutFailure({required this.errorMessage});
}