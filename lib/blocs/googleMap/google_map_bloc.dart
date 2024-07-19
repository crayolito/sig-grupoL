import 'dart:math' as math;

import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/blocs/location/location_bloc.dart';
import 'package:app_sig2024/features/geolocalizacion/domain/entities/responseRutas.dart';
import 'package:app_sig2024/features/geolocalizacion/infrastructure/repositories/geo_repository_impl.dart';
import 'package:app_sig2024/features/helpers/imageNetworkMarker.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'google_map_event.dart';
part 'google_map_state.dart';

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  final AutheticationBloc authBloc;
  final LocationBloc locationBloc;
  final geoDatasourceImpl = GeolocalizacionRepositoryImpl();

  GoogleMapBloc({
    required this.authBloc,
    required this.locationBloc,
  }) : super(GoogleMapState()) {
    on<OnInitFigureMap>((event, emit) async {
      Map<String, Marker> markers = {};
      final imageMarker = await getNetworkImageMarker(
          "https://res.cloudinary.com/da9xsfose/image/upload/v1721345101/kdcpwdunhzwkmkc0i5bz.png");
      for (int i = 0; i < authBloc.state.coordPuntosCorte.length; i++) {
        var puntoCorte = authBloc.state.coordPuntosCorte[i];
        final marker = Marker(
          markerId: MarkerId(puntoCorte.toString()),
          position: puntoCorte,
          anchor: const Offset(0.5, 0.5),
          icon: imageMarker,
          onTap: () {
            int index = i;
            authBloc.add(OnChangedDataCorte(index));
            event.context.push("/infoPuntoCorte");
          },
        );
        markers[puntoCorte.toString()] = marker;
      }
      emit(state.copyWith(markers: markers));
    });

    on<OnCreateRouteTodoPuntos>((event, emit) async {
      // Map<String, Polyline> polilineas = {};

      // Position posicionUsuario = await locationBloc.getActualLocation();
      // LatLng posicion =
      //     LatLng(posicionUsuario.latitude, posicionUsuario.longitude);

      LatLng posicion = const LatLng(-16.36485088715999, -60.97646113472762);
      List<RutaGoogleApi> difRutas =
          await geoDatasourceImpl.getRoutePuntosCorte(
              posicion,
              authBloc.state.coordPuntosCorte,
              authBloc.state.tipoTransporte,
              authBloc.state.tipoTrafico,
              authBloc.state.showAlternativa);
      // NOTE : Cambiar el estado de la ruta
      authBloc.add(OnChangedRutasGoogleApi(difRutas));
      // NOTE : DIBUJAR LA RUTA EN EL MAPA MEDIANTE EL CODIGO
      add(OnInitPolylineByCodigo(difRutas[0].codigoPolilinea));
      // String codigoPuntos = difRutas[0].codigoPolilinea;
      // List<PointLatLng> decodificacionPuntos =
      //     PolylinePoints().decodePolyline(codigoPuntos);
      // List<LatLng> puntos = decodificacionPuntos
      //     .map((PointLatLng point) => LatLng(point.latitude, point.longitude))
      //     .toList();
      // final polilineaRuta = Polyline(
      //   polylineId: const PolylineId("ruta"),
      //   color: Colors.pinkAccent,
      //   points: puntos,
      //   width: 4,
      //   patterns: [PatternItem.dash(30), PatternItem.gap(20)],
      // );
      // polilineas["ruta"] = polilineaRuta;
      // emit(state.copyWith(polylines: polilineas));
      // await orientarYajustarCamara();
    });

    on<OnInitPolylineByCodigo>((event, emit) async {
      Map<String, Polyline> polilineas = {};
      List<PointLatLng> decodificacionPuntos =
          PolylinePoints().decodePolyline(event.codigo);
      List<LatLng> puntos = decodificacionPuntos
          .map((PointLatLng point) => LatLng(point.latitude, point.longitude))
          .toList();
      final polilineaRuta = Polyline(
        polylineId: const PolylineId("ruta"),
        color: Colors.pinkAccent,
        points: puntos,
        width: 4,
        patterns: [PatternItem.dash(30), PatternItem.gap(20)],
      );
      polilineas["ruta"] = polilineaRuta;
      emit(state.copyWith(polylines: polilineas));
      await orientarYajustarCamara();
    });

    on<OnMapInitialControllerMap>((event, emit) async {
      mapController = event.controller;
      emit(state.copyWith(status: GoogleMapStatus.construido));
      add(OnInitFigureMap(event.context));
    });

    on<OnMapInitialControllerCamera>((event, emit) async {
      cameraPosition = event.cameraPosition;
      emit(state.copyWith(status: GoogleMapStatus.construido));
    });

    on<OnChangeTypeMap>((event, emit) {
      emit(state.copyWith(mapType: event.mapType));
    });

    on<OnClearPolilyne>((event, emit) {
      emit(state.copyWith(polylines: {}));
    });
  }

  void moveCameraMyLocation(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLngZoom(newLocation, 17.5);
    mapController?.animateCamera(cameraUpdate);
  }

  void reorientMap() {
    if (mapController != null && cameraPosition != null) {
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: cameraPosition!.target, zoom: cameraPosition!.zoom)));
    }
  }

  Future<void> reorientarCamara() async {
    if (mapController != null && cameraPosition != null) {
      final CameraPosition posicionNormalizada = CameraPosition(
        target: cameraPosition!.target, // Mantén la posición actual
        zoom: cameraPosition!.zoom, // Mantén el nivel de zoom actual
        bearing: 0.0, // Reorienta el norte hacia arriba
        tilt: 0.0, // Elimina la inclinación
      );

      await mapController!
          .animateCamera(CameraUpdate.newCameraPosition(posicionNormalizada));
    }
  }

  Future<void> orientarCamaraALaPosicion() async {
    final posicion = await locationBloc.getActualLocation();

    if (mapController != null) {
      final cameraPosition = CameraPosition(
        target: LatLng(posicion.latitude, posicion.longitude),
        zoom: 18,
      );

      mapController!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  LatLng posicion = const LatLng(-16.36485088715999, -60.97646113472762);
  // final posicionActual = await locationBloc.getActualLocation();

  Future<void> orientarYajustarCamara() async {
    LatLng posicion = const LatLng(-16.3675989519896, -60.97186793742027);
    // LatLng posicionFinal = const LatLng(-16.37266659233544, -60.96163469450924);
    // Calcular el bearing entre las dos posiciones
    // double bearing = calcularBearing(posicion.latitude, posicion.longitude,
    //     posicionFinal.latitude, posicionFinal.longitude);
    // Orientar la cámara a la posición específica
    final cameraPositionOrientar =
        CameraPosition(target: posicion, zoom: 17.5, bearing: 120, tilt: 90);
    await mapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPositionOrientar));
  }

  double calcularBearing(double lat1, double lon1, double lat2, double lon2) {
    var dLon = (lon2 - lon1);
    var y = math.sin(dLon) * math.cos(lat2);
    var x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLon);
    var brng = math.atan2(y, x);
    brng = radianesAGrados(brng);
    brng = (brng + 360) % 360;
    return brng;
  }

  double radianesAGrados(double radianes) {
    return radianes * 180 / math.pi;
  }

  @override
  Future<void> close() {
    mapController?.dispose();
    add(const OnResetState());
    return super.close();
  }
}
