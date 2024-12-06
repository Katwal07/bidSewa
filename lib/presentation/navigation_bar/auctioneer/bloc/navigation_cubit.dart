import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/presentation/navigation_bar/auctioneer/bloc/navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigateState(tabIndex: 0));

  void onTabClick(int index) {
    emit(
      NavigateState(tabIndex: index),
    );
  }
}
