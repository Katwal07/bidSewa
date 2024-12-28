
import '../entity/network_status.dart';

abstract class NetworkInfoRepository {
  Stream<NetworkStatus> get networkStatus;
}