part of 'google_map_bloc.dart';

enum GoogleMapStatus {
  none,
  cargando,
  construido,
  error,
}

// ignore: must_be_immutable
class GoogleMapState extends Equatable {
  final MapType mapType;
  final GoogleMapStatus status;

  // POLIGONOS PARA EL MAPA
  Map<String, Polyline> polylines;
  Map<String, Marker> markers;
  Map<String, Polygon> polygons;

  GoogleMapState({
    this.mapType = MapType.normal,
    this.status = GoogleMapStatus.none,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    Map<String, Polygon>? polygons,
  })  : polylines = polylines ?? const {},
        markers = markers ?? const {},
        polygons = polygons ?? const {};

  GoogleMapState copyWith({
    MapType? mapType,
    GoogleMapStatus? status,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    Map<String, Polygon>? polygons,
  }) =>
      GoogleMapState(
        mapType: mapType ?? this.mapType,
        status: status ?? this.status,
        polylines: polylines ?? this.polylines,
        markers: markers ?? this.markers,
        polygons: polygons ?? this.polygons,
      );

  @override
  List<Object?> get props => [mapType, status, polylines, markers, polygons];
}
