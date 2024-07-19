import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/features/geolocalizacion/domain/datasources/geo_datasource.dart';
import 'package:app_sig2024/features/geolocalizacion/domain/entities/responsePuntosCorte.dart';
import 'package:app_sig2024/features/geolocalizacion/domain/entities/responseRutas.dart';
import 'package:app_sig2024/features/geolocalizacion/domain/repositories/geo_repository.dart';
import 'package:app_sig2024/features/geolocalizacion/infrastructure/datasources/geo_datasource_impl.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

class GeolocalizacionRepositoryImpl extends GeolocalizacionRepository {
  final GeolocalizacionDatasource datasource;

  GeolocalizacionRepositoryImpl({GeolocalizacionDatasource? datasource})
      : datasource = datasource ?? GeolocalizacionDatasourceImpl();

  @override
  Future<ResponsePuntosCorte> getDataPuntosCorte(int ruta) async {
    return await datasource.getDataPuntosCorte(ruta);
  }

  @override
  Future<List<RutaGoogleApi>> getRoutePuntosCorte(
      LatLng posicionUsuario,
      List<LatLng> puntosCorte,
      TipoTransporte tipoTransporte,
      NivelTrafico nivelTrafico,
      bool showAlternativa) async {
    return await datasource.getRoutePuntosCorte(posicionUsuario, puntosCorte,
        tipoTransporte, nivelTrafico, showAlternativa);
  }

  @override
  Future<String> login(String username, String password) async {
    return await datasource.login(username, password);
  }

  @override
  Future<String> actualizarPuntoCorte(String liNcoc) async {
    return await datasource.actualizarPuntoCorte(liNcoc);
  }
}
