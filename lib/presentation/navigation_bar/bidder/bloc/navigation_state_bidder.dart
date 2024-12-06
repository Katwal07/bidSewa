abstract class NavigationStateBidder {}

class NavigateStateBidder extends NavigationStateBidder{
  final int tabIndex;

  NavigateStateBidder({required this.tabIndex});
}