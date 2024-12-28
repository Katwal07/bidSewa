abstract class ConnectivityState {}

class NetworkInitial extends ConnectivityState {}

class NetworkChecking extends ConnectivityState{}

class NetworkConnected extends ConnectivityState {}

class NetworkDisconnected extends ConnectivityState {}