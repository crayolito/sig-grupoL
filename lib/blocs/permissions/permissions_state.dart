part of 'permissions_bloc.dart';

class PermissionsState extends Equatable {
  // GPS ESTADO (ENCENDIDO/APAGADO)
  final bool isGpsEnabled;
  // PERMISOS DEL GPS
  final bool isGpsPermissionGranted;
  // INTERNET ESTADO (ENCENDIDO/APAGADO)
  final bool isInternetEnabled;

  const PermissionsState(
      {this.isGpsEnabled = false,
      this.isGpsPermissionGranted = false,
      this.isInternetEnabled = false});

  PermissionsState copyWith({
    bool? isGpsEnabled,
    bool? isGpsPermissionGranted,
    bool? isInternetEnabled,
  }) =>
      PermissionsState(
        isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
        isGpsPermissionGranted:
            isGpsPermissionGranted ?? this.isGpsPermissionGranted,
        isInternetEnabled: isInternetEnabled ?? this.isInternetEnabled,
      );

  @override
  List<Object> get props => [
        isGpsEnabled,
        isGpsPermissionGranted,
        isInternetEnabled,
      ];
}
