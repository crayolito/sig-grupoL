import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positionSteam;

  LocationBloc() : super(const LocationState()) {
    on<OnChangedStatusFollowUser>((event, emit) {
      emit(state.copyWith(isFollowingUser: event.isFollowingUser));
    });
    on<OnNewUserLocation>(_onNewUserLocation);
  }

  _onNewUserLocation(OnNewUserLocation event, Emitter<LocationState> emit) {
    emit(state.copyWith(
      lastKnowLocationGM: LatLng(event.latitude, event.longitude),
      lastKnowLocationMB: LatLng(
        event.latitude,
        event.longitude,
      ),
      myLocationHistoryGM: [
        ...state.myLocationHistoryGM,
        LatLng(event.latitude, event.longitude),
      ],
      myLocationHistoryMB: [
        ...state.myLocationHistoryMB,
        LatLng(event.latitude, event.longitude),
      ],
    ));
  }

  Future<Position> getActualLocation() async {
    final position = await Geolocator.getCurrentPosition();
    return position;
  }



  void startFollowingUser() {
    add(const OnChangedStatusFollowUser(true));

    positionSteam = Geolocator.getPositionStream().listen((position) {
      add(OnNewUserLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      ));
    });
  }

  Future<void> stopFollowingUser() async {
    add(const OnChangedStatusFollowUser(false));
    await positionSteam?.cancel();
  }

  @override
  Future<void> close() {
    positionSteam?.cancel();
    return super.close();
  }
}
