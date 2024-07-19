part of 'permissions_bloc.dart';

class PermissionsEvent extends Equatable {
  const PermissionsEvent();

  @override
  List<Object> get props => [];
}


class OnChangedGpsEnabled extends PermissionsEvent {
  final bool isGpsEnabled;
  const OnChangedGpsEnabled(this.isGpsEnabled);
}

class OnChangedGpsPermissionGranted extends PermissionsEvent {
  final bool isGpsPermissionGranted;
  const OnChangedGpsPermissionGranted(this.isGpsPermissionGranted);
}

class OnChangedInternetEnabled extends PermissionsEvent {
  final bool isInternetEnabled;
  const OnChangedInternetEnabled(this.isInternetEnabled);
}
