part of 'authetication_bloc.dart';

enum TypeMap { googleMap, mapBox }

enum TipoTransporte { caminar, bicicleta, carro, moto }

enum NivelTrafico { con, sin, optimo }

enum ProcesoCambioRuta { sinProceso, proceso, procesoFinalizado, error }

enum ProcesoAuthentication { none, procesando, correcto, error }

// ignore: must_be_immutable
class AuthenticationState extends Equatable {
// READ : VECTOR DE RUTAS DE PUNTOS DE CORTE
  List<RutaGoogleApi> rutasGoogleApi;
  // READ : DATOS DE PUNTOS DE CORTE PRINCIPAL
  List<DataCorte> clienteDataCorte;
  // READ : DATOS DE PUNTOS DE CORTE SECUNDARIO
  List<DataCorte> verCliente;
  // READ : PROCESO DE CAMBIO DE RUTA
  final ProcesoCambioRuta procesoCambioRuta;
  final ProcesoAuthentication procesoAuthentication;

  final TypeMap typeMap;
  ResponsePuntosCorte? puntosCorte;
  List<LatLng> coordPuntosCorte;
  final bool showScrollInfo;
  DataCorte? dataCorte;

  // NOTE : FILTRO DE PUNTOS DE CORTE
  final String filtroViewCliente;
  final TipoTransporte tipoTransporte;
  final NivelTrafico tipoTrafico;
  final int tipoRuta;
  final bool showAlternativa;

  AuthenticationState({
    this.typeMap = TypeMap.googleMap,
    this.puntosCorte,
    this.showScrollInfo = false,
    this.dataCorte,
    List<LatLng>? coordPuntosCorte,
    List<RutaGoogleApi>? rutasGoogleApi,
    // READ : DATOS DE PUNTOS DE CORTE PRINCIPAL
    List<DataCorte>? clienteDataCorte,
    // READ : DATOS DE PUNTOS DE CORTE SECUNDARIO
    List<DataCorte>? verCliente,
    // READ : PROCESO DE CAMBIO DE RUTA
    this.procesoCambioRuta = ProcesoCambioRuta.sinProceso,
    this.procesoAuthentication = ProcesoAuthentication.none,
    // NOTE : FILTRO DE PUNTOS DE CORTE
    this.filtroViewCliente = "",
    this.tipoTransporte = TipoTransporte.carro,
    this.tipoTrafico = NivelTrafico.optimo,
    this.tipoRuta = 2,
    this.showAlternativa = false,
  })  : clienteDataCorte = clienteDataCorte ?? [],
        coordPuntosCorte = coordPuntosCorte ?? [],
        rutasGoogleApi = rutasGoogleApi ?? [],
        verCliente = verCliente ?? [];

  AuthenticationState copyWith({
    bool? showScrollInfo,
    DataCorte? dataCorte,
    TypeMap? typeMap,
    ResponsePuntosCorte? puntosCorte,
    List<LatLng>? coordPuntosCorte,
    List<RutaGoogleApi>? rutasGoogleApi,
    // READ : DATOS DE PUNTOS DE CORTE PRINCIPAL
    List<DataCorte>? clienteDataCorte,
    // READ : DATOS DE PUNTOS DE CORTE SECUNDARIO
    List<DataCorte>? verCliente,
    // READ : PROCESO DE CAMBIO DE RUTA
    ProcesoCambioRuta? procesoCambioRuta,
    ProcesoAuthentication? procesoAuthentication,
    // NOTE : FILTRO DE PUNTOS DE CORTE
    String? filtroViewCliente,
    TipoTransporte? tipoTransporte,
    NivelTrafico? tipoTrafico,
    int? tipoRuta,
    bool? showAlternativa,
  }) =>
      AuthenticationState(
        showScrollInfo: showScrollInfo ?? this.showScrollInfo,
        dataCorte: dataCorte ?? this.dataCorte,
        typeMap: typeMap ?? this.typeMap,
        puntosCorte: puntosCorte ?? this.puntosCorte,
        coordPuntosCorte: coordPuntosCorte ?? this.coordPuntosCorte,
        rutasGoogleApi: rutasGoogleApi ?? this.rutasGoogleApi,
        // READ : DATOS DE PUNTOS DE CORTE PRINCIPAL
        clienteDataCorte: clienteDataCorte ?? this.clienteDataCorte,
        // READ : DATOS DE PUNTOS DE CORTE SECUNDARIO
        verCliente: verCliente ?? this.verCliente,
        // READ : PROCESO DE CAMBIO DE RUTA
        procesoCambioRuta: procesoCambioRuta ?? this.procesoCambioRuta,
        procesoAuthentication:
            procesoAuthentication ?? this.procesoAuthentication,
        // NOTE : FILTRO DE PUNTOS DE CORTE
        filtroViewCliente: filtroViewCliente ?? this.filtroViewCliente,
        tipoTransporte: tipoTransporte ?? this.tipoTransporte,
        tipoTrafico: tipoTrafico ?? this.tipoTrafico,
        tipoRuta: tipoRuta ?? this.tipoRuta,
        showAlternativa: showAlternativa ?? this.showAlternativa,
      );

  @override
  List<Object?> get props => [
        typeMap,
        puntosCorte,
        coordPuntosCorte,
        showScrollInfo,
        dataCorte,
        rutasGoogleApi,
        // READ : DATOS DE PUNTOS DE CORTE PRINCIPAL
        clienteDataCorte,
        // READ : DATOS DE PUNTOS DE CORTE SECUNDARIO
        verCliente,
        // READ : PROCESO DE CAMBIO DE RUTA
        procesoCambioRuta,
        procesoAuthentication,
        // NOTE : FILTRO DE PUNTOS DE CORTE
        filtroViewCliente,
        tipoTransporte,
        tipoTrafico,
        tipoRuta,
        showAlternativa
      ];
}
