import 'package:app_sig2024/features/geolocalizacion/domain/entities/lugar-corte.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ResponsePuntosCorte {
  final List<DataCorte> infoPuntosCorte;
  final List<LatLng> coordPuntosCorte;

  ResponsePuntosCorte(
      {required this.infoPuntosCorte, required this.coordPuntosCorte});


}
