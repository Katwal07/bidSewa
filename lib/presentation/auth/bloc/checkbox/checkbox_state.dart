class CheckBoxState {
  final bool checkbox1;
  final bool checkbox2;

  CheckBoxState({this.checkbox1 = true, this.checkbox2 = false});

  CheckBoxState copyWith({bool? checkbox1, bool? checkbox2}){
    return CheckBoxState(
      checkbox1: checkbox1 ?? this.checkbox1,
      checkbox2: checkbox2 ?? this.checkbox2
    );
  }
}
