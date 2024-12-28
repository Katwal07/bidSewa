// ignore_for_file: constant_pattern_never_matches_value_type

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../domain/network/entity/network_status.dart';
import '../../domain/network/repositories/network_info.dart';

class NetworkInfoRepositoryImpl implements NetworkInfoRepository {
  final Connectivity _connectivity;
  
  NetworkInfoRepositoryImpl(this._connectivity);

  @override
  Stream<NetworkStatus> get networkStatus async* {
    // Check initial status
    final initialResults = await _connectivity.checkConnectivity();
    yield _mapConnectivityToStatus(initialResults);

    // Listen to changes
    await for (final results in _connectivity.onConnectivityChanged) {
      yield _mapConnectivityToStatus(results);
    }
  }

  NetworkStatus _mapConnectivityToStatus(List<ConnectivityResult> results) {
    // If the list is empty or contains only 'none', we're disconnected
    if (results.isEmpty || (results.length == 1 && results.first == ConnectivityResult.none)) {
      return NetworkStatus.disconnected;
    }

    // If we have any valid connection type, we're connected
    if (results.any((result) => 
      result == ConnectivityResult.wifi ||
      result == ConnectivityResult.mobile ||
      result == ConnectivityResult.ethernet ||
      result == ConnectivityResult.vpn
    )) {
      return NetworkStatus.connected;
    }
    return NetworkStatus.disconnected;
  }
}




///Note:
/*
A Stream is a sequence of asynchronous data events that allows us to receive data
over time instead of waiting for all the data to be available at once.
A async* is an asynchronous generator that produce a stream of value.
_mapConnectivityToStatus(initialResults); -> map the result from ConnectivityResult to a NetworkStatus.
yields -> Emits the mapped NetworkStatus as the first value in the stream.
*/