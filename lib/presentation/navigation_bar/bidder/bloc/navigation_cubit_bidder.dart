import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_state_bidder.dart';

class NavigationCubitBidder extends Cubit<NavigationStateBidder> {
  NavigationCubitBidder() : super(NavigateStateBidder(tabIndex: 0));

  void onTabClick(int index) {
    emit(
      NavigateStateBidder(tabIndex: index),
    );
  }
}
