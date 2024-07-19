import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permissions_event.dart';
part 'permissions_state.dart';

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {
  StreamSubscription? gpsServiceSubscription;

  PermissionsBloc() : super(const PermissionsState()) {
    on<OnChangedGpsEnabled>((event, emit) {
      emit(state.copyWith(isGpsEnabled: event.isGpsEnabled));
    });

    on<OnChangedGpsPermissionGranted>((event, emit) {
      emit(
          state.copyWith(isGpsPermissionGranted: event.isGpsPermissionGranted));
    });

    on<OnChangedInternetEnabled>((event, emit) {
      emit(state.copyWith(isInternetEnabled: event.isInternetEnabled));
    });

    _init();
  }

  Future<void> _init() async {
    askGpsAccess();
    final gpsInitStatus =
        await Future.wait([_checkGpsStatus(), _isPermissionGranted()]);
    add(OnChangedGpsEnabled(gpsInitStatus[0]));
    add(OnChangedGpsPermissionGranted(gpsInitStatus[1]));
  }

  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();
    gpsServiceSubscription =
        Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = (event.index == 1) ? true : false;
      add(OnChangedGpsEnabled(isEnabled));
    });
    return isEnable;
  }

  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();
    switch (status) {
      case PermissionStatus.granted:
        add(const OnChangedGpsPermissionGranted(true));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
      case PermissionStatus.limited:
        add(const OnChangedGpsPermissionGranted(false));
        break;
      default:
    }
  }

  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    // TODO: implement close
    return super.close();
  }
}
