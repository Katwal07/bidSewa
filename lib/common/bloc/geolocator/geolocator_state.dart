import 'package:geolocator/geolocator.dart';

abstract class GeolocatorState {}

class LocationInitial extends GeolocatorState {}

class LocationLoading extends GeolocatorState {}

class LocationSuccess extends GeolocatorState {
  final Position position;
  final String address;

  LocationSuccess({required this.position, required this.address});
}

class LocationFailure extends GeolocatorState {
  final String error;

  LocationFailure({required this.error});
}
