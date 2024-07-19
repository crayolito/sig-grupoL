part of 'location_bloc.dart';

class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class OnChangedStatusFollowUser extends LocationEvent {
  final bool isFollowingUser;
  const OnChangedStatusFollowUser(this.isFollowingUser);
}

class OnNewUserLocation extends LocationEvent {
  final double longitude;
  final double latitude;
  const OnNewUserLocation({
    required this.longitude,
    required this.latitude,
  });
}
