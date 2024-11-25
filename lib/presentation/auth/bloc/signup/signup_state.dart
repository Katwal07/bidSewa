class SignupState {
  final bool checkbox1;
  final bool checkbox2;

  SignupState({this.checkbox1 = true, this.checkbox2 = false});

  SignupState copyWith({bool? checkbox1, bool? checkbox2}){
    return SignupState(
      checkbox1: checkbox1 ?? this.checkbox1,
      checkbox2: checkbox2 ?? this.checkbox2
    );
  }
}
