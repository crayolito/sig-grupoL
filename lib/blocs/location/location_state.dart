part of 'location_bloc.dart';

class LocationState extends Equatable {
  // Empezar a seguir al usuario
  final bool isFollowingUser;

  // Ultima ubicacion del usuario MapBox
  final LatLng? lastKnowLocationMB;
  final List<LatLng> myLocationHistoryMB;

  // Ultima ubicacion del usuario GoogleMaps
  final LatLng? lastKnowLocationGM;
  final List<LatLng> myLocationHistoryGM;

  const LocationState({
    this.isFollowingUser = false,
    this.lastKnowLocationMB,
    myLocationHistoryMB,
    this.lastKnowLocationGM,
    myLocationHistoryGM,
  })  : myLocationHistoryMB = myLocationHistoryMB ?? const [],
        myLocationHistoryGM = myLocationHistoryGM ?? const [];

  LocationState copyWith({
    bool? isFollowingUser,
    LatLng? lastKnowLocationMB,
    List<LatLng>? myLocationHistoryMB,
    LatLng? lastKnowLocationGM,
    List<LatLng>? myLocationHistoryGM,
  }) =>
      LocationState(
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        lastKnowLocationMB: lastKnowLocationMB ?? this.lastKnowLocationMB,
        myLocationHistoryMB: myLocationHistoryMB ?? this.myLocationHistoryMB,
        lastKnowLocationGM: lastKnowLocationGM ?? this.lastKnowLocationGM,
        myLocationHistoryGM: myLocationHistoryGM ?? this.myLocationHistoryGM,
      );

  @override
  List<Object?> get props => [
        isFollowingUser,
        lastKnowLocationMB,
        myLocationHistoryMB,
        lastKnowLocationGM,
        myLocationHistoryGM,
      ];
}
