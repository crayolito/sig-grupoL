import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/features/geolocalizacion/domain/datasources/geo_datasource.dart';
import 'package:app_sig2024/features/geolocalizacion/domain/entities/lugar-corte.dart';
import 'package:app_sig2024/features/geolocalizacion/domain/entities/responsePuntosCorte.dart';
import 'package:app_sig2024/features/geolocalizacion/domain/entities/responseRutas.dart';
import 'package:app_sig2024/features/helpers/mapRoute.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xml/xml.dart';

class GeolocalizacionDatasourceImpl extends GeolocalizacionDatasource {
  final dio = Dio();

  @override
  Future<ResponsePuntosCorte> getDataPuntosCorte(int ruta) async {
    String data = '''
        <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                     xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                     xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
          <soap:Body>
              <W2Corte_ReporteParaCortesSIG xmlns="http://activebs.net/">
                  <liNrut>$ruta</liNrut>
                  <liNcnt>0</liNcnt>
                  <liCper>0</liCper>
              </W2Corte_ReporteParaCortesSIG>
          </soap:Body>
      </soap:Envelope>
    ''';

    var response = await dio.post(
      'http://190.171.244.211:8080/wsVarios/wsBS.asmx',
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'text/xml; charset=utf-8',
          'SOAPAction': 'http://activebs.net/W2Corte_ReporteParaCortesSIG',
        },
      ),
    );

    final reponseData = XmlDocument.parse(response.data);
    final encontrarEtiqueta = reponseData.findAllElements('Table');
    List<LatLng> coordPuntosCorte = [];
    List<DataCorte> infoPuntosCorte = [];
    for (var table in encontrarEtiqueta) {
      var bscocNcoc = table.findElements('bscocNcoc').single.innerText;
      var bscntCodf = table.findElements('bscntCodf').single.innerText;
      var bscocNcnt = table.findElements('bscocNcnt').single.innerText;
      var dNomb = table.findElements('dNomb').single.innerText;
      var bscocNmor = table.findElements('bscocNmor').single.innerText.trim();
      var bscocImor = table.findElements('bscocImor').single.innerText.trim();
      var bsmednser = table.findElements('bsmednser').single.innerText.trim();
      var bsmedNume = table.findElements('bsmedNume').single.innerText.trim();
      var bscntlati = table.findElements('bscntlati').single.innerText.trim();
      var bscntlogi = table.findElements('bscntlogi').single.innerText.trim();
      var dNcat = table.findElements('dNcat').single.innerText;
      var dCobc = table.findElements('dCobc').single.innerText;
      var dLotes = table.findElements('dLotes').single.innerText;

      coordPuntosCorte
          .add(LatLng(double.parse(bscntlati), double.parse(bscntlogi)));
      infoPuntosCorte.add(
        DataCorte(
            data1: bscocNcoc,
            data2: bscntCodf,
            data3: bscocNcnt,
            data4: bscocNmor,
            data5: bsmednser,
            data6: bsmedNume,
            data7: dCobc,
            data8: dNcat,
            nombre: dNomb,
            longitud: double.parse(bscntlogi),
            latitud: double.parse(bscntlati),
            importe: double.parse(bscocImor),
            umz: dLotes),
      );
    }

    return ResponsePuntosCorte(
        infoPuntosCorte: infoPuntosCorte, coordPuntosCorte: coordPuntosCorte);
  }

  @override
  Future<List<RutaGoogleApi>> getRoutePuntosCorte(
      LatLng posicionUsuario,
      List<LatLng> puntosCorte,
      TipoTransporte tipoTransporte,
      NivelTrafico nivelTrafico,
      bool showAlternativa) async {
    puntosCorte = MapRouterHelpers.filtrarPuntoCorteUtiles(puntosCorte);
    String travelMode = MapRouterHelpers.convertTravelMode(tipoTransporte);
    String routingPreference =
        MapRouterHelpers.convertRoutingPreference(nivelTrafico);
    String puntosIntermedios =
        MapRouterHelpers.puntosIntermedioBody(puntosCorte);
    String origen = '''
    "origin": {
        "location": {
            "latLng": {
                "latitude": ${posicionUsuario.latitude},
                "longitude":  ${posicionUsuario.longitude}
            }
        }
    }
    ''';
    String destino = '''
    "destination": {
        "location": {
            "latLng": {
                "latitude": ${puntosCorte.last.latitude},
                "longitude": ${puntosCorte.last.longitude}
            }
        }
    }
    ''';

    String body = '''
    {
    $origen,
    $destino,
    "intermediates": 
        $puntosIntermedios
    ,
    "polylineQuality": "HIGH_QUALITY",
    "travelMode": "$travelMode",
    "routingPreference": "$routingPreference",
    "trafficModel" : "OPTIMISTIC",
    "computeAlternativeRoutes": $showAlternativa,
    "routeModifiers": {
        "avoidTolls": false,
        "avoidHighways": false,
        "avoidFerries": false,
        "avoidIndoor": false
    }
}
    ''';
    try {
      var response = await dio.post(
          'https://routes.googleapis.com/directions/v2:computeRoutes',
          data: body,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'X-Goog-Api-Key': 'AIzaSyDYq6w1N7meIbXFGd56FrrfoGN4c7U-r2g',
            'X-Goog-FieldMask':
                'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
          }));
      if (response.statusCode == 200) {
        List<RutaGoogleApi> encodedPolylines =
            RutaGoogleApi.fromJson(response.data);
        return encodedPolylines;
      } else {
        // Manejo de errores para códigos de estado distintos de 200
        throw Exception('Failed to load route data');
      }
    } catch (e) {
      // Captura de errores generales
      print('Error fetching route data: $e');
      throw Exception('Error fetching route data: $e');
    }
  }

  @override
  Future<String> login(String username, String password) async {
    String data = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ValidarLoginPassword xmlns="http://tempuri.org/">
      <lsLogin>$username</lsLogin>
      <lsPassword>$password</lsPassword>
    </ValidarLoginPassword>
  </soap:Body>
</soap:Envelope>
  ''';

    try {
      var response = await dio.post(
        'http://190.171.244.211:8080/wsVarios/wsAD.asmx',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'text/xml; charset=utf-8',
            'SOAPAction': 'http://tempuri.org/ValidarLoginPassword',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = XmlDocument.parse(response.data);
        final encontrarEtiqueta =
            responseData.findAllElements('ValidarLoginPasswordResult');
        if (encontrarEtiqueta.isNotEmpty) {
          return encontrarEtiqueta.single.innerText;
        } else {
          throw Exception(
              'Elemento ValidarLoginPasswordResult no encontrado en la respuesta XML.');
        }
      } else {
        throw Exception(
            'Error en la respuesta del servidor: Código de estado ${response.statusCode}');
      }
    } catch (e) {
      // Maneja la excepción, que podría ser un error de red, un error de parseo, etc.
      print('Error al realizar la solicitud de login: $e');
      // Considera lanzar la excepción o devolver un valor de error específico
      throw Exception('Error al realizar la solicitud de login: $e');
    }
  }

  @override
  Future<String> actualizarPuntoCorte(String liNcoc) async {
    String dataTiempo = obtenerFechaComoCadena();
    String data = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <W3Corte_UpdateCorte xmlns="http://activebs.net/">
      <liNcoc>$liNcoc</liNcoc>
      <liCemc>456</liCemc>
      <ldFcor>$dataTiempo</ldFcor>
      <liPres>0</liPres>
      <liCobc>100</liCobc>
      <liLcor>1234</liLcor>
      <liNofn>1</liNofn>
      <lsAppName>SIGUPDATE</lsAppName>
    </W3Corte_UpdateCorte>
  </soap:Body>
</soap:Envelope>
  ''';

    try {
      var response = await dio.post(
        'http://190.171.244.211:8080/wsVarios/wsBS.asmx',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'text/xml; charset=utf-8',
            'SOAPAction': 'http://activebs.net/W3Corte_UpdateCorte',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = XmlDocument.parse(response.data);
        final encontrarEtiqueta =
            responseData.findAllElements('W3Corte_UpdateCorteResult');
        if (encontrarEtiqueta.isNotEmpty) {
          return encontrarEtiqueta.single.innerText;
        } else {
          throw Exception(
              'Elemento ValidarLoginPasswordResult no encontrado en la respuesta XML.');
        }
      } else {
        throw Exception(
            'Error en la respuesta del servidor: Código de estado ${response.statusCode}');
      }
    } catch (e) {
      // Maneja la excepción, que podría ser un error de red, un error de parseo, etc.
      print('Error al realizar la solicitud de actualizar corte: $e');
      // Considera lanzar la excepción o devolver un valor de error específico
      throw Exception('Error al realizar la solicitud de actualizar corte: $e');
    }
  }

  String obtenerFechaComoCadena() {
    DateTime ahora = DateTime.now();
    return "${ahora.year.toString().padLeft(4, '0')}-${ahora.month.toString().padLeft(2, '0')}-${ahora.day.toString().padLeft(2, '0')}T${ahora.hour.toString().padLeft(2, '0')}:${ahora.minute.toString().padLeft(2, '0')}:${ahora.second.toString().padLeft(2, '0')}";
  }
}
