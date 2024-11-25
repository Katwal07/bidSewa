abstract class OnboardState {}

class OnBoardPageChanged extends OnboardState{
  final int pageIndex;

  OnBoardPageChanged({required this.pageIndex});
}