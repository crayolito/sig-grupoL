class RutaGoogleApi {
  final int metros;
  final String segundos;
  final String codigoPolilinea;

  RutaGoogleApi(
      {required this.metros,
      required this.segundos,
      required this.codigoPolilinea});

  // MAPEAR RESPUESTA
  static List<RutaGoogleApi> fromJson(Map<String, dynamic> json) {
    var routesList = json['routes'] as List;
    return routesList.map((route) {
      var polyline = route['polyline'] as Map<String, dynamic>;
      return RutaGoogleApi(
        metros: route['distanceMeters'],
        segundos: route['duration'],
        codigoPolilinea: polyline['encodedPolyline'],
      );
    }).toList();
  }
}
