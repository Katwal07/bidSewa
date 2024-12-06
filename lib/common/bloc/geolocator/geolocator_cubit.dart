import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nepa_bid/common/bloc/geolocator/geolocator_state.dart';

class GeolocatorCubit extends Cubit<GeolocatorState> {
  GeolocatorCubit() : super(LocationInitial());

  Future<void> determinePosition() async {
    emit(LocationLoading());
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      // Test if location service are enabled.
      if (!serviceEnabled) {
        emit(LocationFailure(error: "Location service are disabled"));
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(
            LocationFailure(error: "Location permission are denied"),
          );
        }
      }
      if (permission == LocationPermission.deniedForever) {
        emit(
          LocationFailure(
            error:
                "Location permissions are permanently denied, we cannot request permissions.",
          ),
        );
      }
      // when we reach here , permission are granted.
      Position position = await Geolocator.getCurrentPosition(      );
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      
        final Placemark placemark = placemarks.first;
        final String address = "${placemark.locality},${placemark.administrativeArea},${placemark.country}";
      
      emit(LocationSuccess(position: position, address: address));
    } catch (e) {
      emit(LocationFailure(error: e.toString()));
    }
  }
}
