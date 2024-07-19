import 'dart:convert';
import 'dart:math';

import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRouterHelpers {
  static String convertTravelMode(TipoTransporte tipoTransporte) {
    switch (tipoTransporte) {
      case TipoTransporte.carro:
        return 'DRIVE';
      case TipoTransporte.bicicleta:
        return 'BICYCLE';
      case TipoTransporte.caminar:
        return 'WALK';
      case TipoTransporte.moto:
        return 'TWO_WHEELER';
    }
  }

  static String convertRoutingPreference(NivelTrafico nivelTrafico) {
    switch (nivelTrafico) {
      case NivelTrafico.con:
        return 'TRAFFIC_AWARE';
      case NivelTrafico.sin:
        return 'TRAFFIC_UNAWARE';
      case NivelTrafico.optimo:
        return 'TRAFFIC_AWARE_OPTIMAL';
    }
  }

  static String puntosIntermedioBody(List<LatLng> puntosCorte) {
    var puntos = puntosCorte.take(puntosCorte.length - 1).map((punto) {
      return {
        "location": {
          "latLng": {
            "latitude": punto.latitude,
            "longitude": punto.longitude,
          }
        }
      };
    }).toList();

    return jsonEncode(puntos);
  }

  static double calcularDistancia(LatLng punto1, LatLng punto2) {
    var p = 0.017453292519943295; // Pi / 180
    var a = 0.5 -
        cos((punto2.latitude - punto1.latitude) * p) / 2 +
        cos(punto1.latitude * p) *
            cos(punto2.latitude * p) *
            (1 - cos((punto2.longitude - punto1.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  static List<LatLng> filtrarPuntoCorteUtiles(List<LatLng> puntosCorte) {
    // Elimina objetos donde latitud o longitud sean 0 y elimina duplicados
    var uniqueFiltered = <String, LatLng>{};

    for (var punto in puntosCorte) {
      if (punto.latitude != 0 && punto.longitude != 0) {
        // Usa una representación en string de LatLng como clave para asegurar unicidad
        String key = '${punto.latitude},${punto.longitude}';
        if (!uniqueFiltered.containsKey(key)) {
          uniqueFiltered[key] = punto;
        }
      }
    }

    // Filtrar elementos cercanos
    // var distanciaMinima =
    //     0.155;
    // 155.23 la distancia que mas conciencte por cada cuadra en esa zona
    // metros, pero la función devuelve kilómetros

    var distanciaMinima =
        0.2; // LO MAS RECOMENDABLE 2 PUNTOS EN UNA CUADRA PARA QUE PUEDA RECORRER
    var puntosFiltrados = <LatLng>[];

    for (var punto in uniqueFiltered.values) {
      bool esCercano = puntosFiltrados
          .any((p) => calcularDistancia(p, punto) < distanciaMinima);
      if (!esCercano) {
        puntosFiltrados.add(punto);
      }
    }

    return puntosFiltrados;
  }
}
