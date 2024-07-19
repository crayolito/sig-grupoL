import 'package:app_sig2024/features/geolocalizacion/domain/entities/lugar-corte.dart';
import 'package:app_sig2024/features/geolocalizacion/domain/entities/responsePuntosCorte.dart';
import 'package:app_sig2024/features/geolocalizacion/domain/entities/responseRutas.dart';
import 'package:app_sig2024/features/geolocalizacion/infrastructure/repositories/geo_repository_impl.dart';
import 'package:app_sig2024/features/showLoadingCustom/showLoadingCustom.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'authetication_event.dart';
part 'authetication_state.dart';

class AutheticationBloc extends Bloc<AutheticationEvent, AuthenticationState> {
  final geoDatasourceImpl = GeolocalizacionRepositoryImpl();

  AutheticationBloc() : super(AuthenticationState()) {
    on<OnChangedTypeMap>((event, emit) {
      emit(state.copyWith(typeMap: event.typeMap));
    });

    on<OnGetPuntosCorte>((event, emit) async {
      final puntosCorte = await geoDatasourceImpl.getDataPuntosCorte(2);
      emit(state.copyWith(
          puntosCorte: puntosCorte,
          clienteDataCorte: puntosCorte.infoPuntosCorte,
          verCliente: puntosCorte.infoPuntosCorte,
          coordPuntosCorte: puntosCorte.coordPuntosCorte));
    });

    on<OnUpdatePuntosCorte>((event, emit) async {
      add(const OnChangedProcesoCambioRuta(ProcesoCambioRuta.proceso));
      final puntosCorte =
          await geoDatasourceImpl.getDataPuntosCorte(state.tipoRuta);
      emit(state.copyWith(
          puntosCorte: puntosCorte,
          clienteDataCorte: puntosCorte.infoPuntosCorte,
          verCliente: puntosCorte.infoPuntosCorte,
          coordPuntosCorte: puntosCorte.coordPuntosCorte));
      add(const OnChangedProcesoCambioRuta(
          ProcesoCambioRuta.procesoFinalizado));
    });

    on<OnChangedProcesoCambioRuta>((event, emit) {
      emit(state.copyWith(procesoCambioRuta: event.procesoCambioRuta));
    });

    on<OnChangedShowScrollInfo>((event, emit) {
      emit(state.copyWith(showScrollInfo: !state.showScrollInfo));
    });

    on<OnChangedDataCorte>((event, emit) {
      final dataCorte = state.verCliente[event.dataCorte];
      emit(state.copyWith(dataCorte: dataCorte));
    });

    on<OnFiltroViewClienteDPC>((event, emit) {
      final verCliente = state.clienteDataCorte
          .where((element) => element.nombre
              .toLowerCase()
              .contains(event.filtroViewCliente.toLowerCase()))
          .toList();
      emit(state.copyWith(verCliente: verCliente));
    });

    on<OnResetViewClienteDPC>((event, emit) {
      emit(state.copyWith(verCliente: state.clienteDataCorte));
    });

    on<OnChangedFiltroRutaCorte>((event, emit) {
      emit(state.copyWith(
        tipoTransporte: event.tipoTransporte ?? state.tipoTransporte,
        tipoTrafico: event.nivelTrafico ?? state.tipoTrafico,
        tipoRuta: event.tipoRuta ?? state.tipoRuta,
        showAlternativa: event.showAlternativa ?? state.showAlternativa,
      ));
    });

    on<OnChangedRutasGoogleApi>((event, emit) {
      emit(state.copyWith(rutasGoogleApi: event.rutasGoogleApi));
    });

    on<OnChangedProccessAuth>((event, emit) {
      emit(state.copyWith(procesoAuthentication: event.procesoAuthentication));
    });

    on<OnIniciarSesion>((event, emit) async {
      add(const OnChangedProccessAuth(ProcesoAuthentication.procesando));
      final response =
          await geoDatasourceImpl.login(event.username, event.password);
      print(response);

      if (response.contains("OK")) {
        add(const OnChangedProccessAuth(ProcesoAuthentication.correcto));
        event.context.push('/map');
      } else {
        add(const OnChangedProccessAuth(ProcesoAuthentication.error));
        ShowLoadingCustom.showLoadingAuth(event.context);
      }
    });

    on<OnActualizatPuntoCorte>((event, emit) async {
      add(const OnChangedProccessAuth(ProcesoAuthentication.procesando));
      final dataUpdate =
          await geoDatasourceImpl.actualizarPuntoCorte(event.liNcoc);
      if (dataUpdate.contains("1")) {
        add(const OnChangedProccessAuth(ProcesoAuthentication.correcto));
      } else {
        add(const OnChangedProccessAuth(ProcesoAuthentication.error));
      }
    });
  }
}
