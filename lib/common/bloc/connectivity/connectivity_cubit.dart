import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/network/entity/network_status.dart';
import '../../../domain/network/repositories/network_info.dart';
import 'connectivity_state.dart';

class NetworkCubit extends Cubit<ConnectivityState> {
  final NetworkInfoRepository networkInfoRepository;
  StreamSubscription? _networkSubscription;

  NetworkCubit({required this.networkInfoRepository}) : super(NetworkInitial()) {
    _observeNetwork();
  }

  void retryConnection()async{
    emit(NetworkChecking());
    await Future.delayed(const Duration(seconds: 2));
    _observeNetwork();
  }

  void _observeNetwork() {
    _networkSubscription = networkInfoRepository.networkStatus.listen(
      (NetworkStatus status) {
        if (status == NetworkStatus.connected) {
          emit(NetworkConnected());
        } else {
          emit(NetworkDisconnected());
        }
      },
      onError: (error, stackTrace) {
        emit(NetworkDisconnected());
      },
    );
  }

  @override
  Future<void> close() async {
    await _networkSubscription?.cancel();
    return super.close();
  }
}