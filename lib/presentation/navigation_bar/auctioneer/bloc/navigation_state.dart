abstract class NavigationState {}

class NavigateState extends NavigationState{
  final int tabIndex;

  NavigateState({required this.tabIndex});
}