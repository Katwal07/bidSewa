import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/presentation/onboard/cubit/onboard_state.dart';

class OnboardCubit extends Cubit<OnboardState>{
  OnboardCubit(): super(OnBoardPageChanged(pageIndex: 0));

  void updatePage(int index){
    emit(OnBoardPageChanged(pageIndex: index));
  }
}