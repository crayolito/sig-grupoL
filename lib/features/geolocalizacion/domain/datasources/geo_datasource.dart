import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/features/geolocalizacion/domain/entities/responsePuntosCorte.dart';
import 'package:app_sig2024/features/geolocalizacion/domain/entities/responseRutas.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class GeolocalizacionDatasource {
  Future<ResponsePuntosCorte> getDataPuntosCorte(int ruta);
  Future<List<RutaGoogleApi>> getRoutePuntosCorte(
    LatLng posicionUsuario,
    List<LatLng> puntosCorte,
    TipoTransporte tipoTransporte,
    NivelTrafico nivelTrafico,
    bool showAlternativa,
  );
  Future<String> login(String username, String password);
  Future<String> actualizarPuntoCorte(String liNcoc);
}
