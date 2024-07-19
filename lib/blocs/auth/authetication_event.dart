part of 'authetication_bloc.dart';

class AutheticationEvent extends Equatable {
  const AutheticationEvent();

  @override
  List<Object> get props => [];
}

class OnChangedTypeMap extends AutheticationEvent {
  final TypeMap typeMap;
  const OnChangedTypeMap(this.typeMap);
}

class OnGetPuntosCorte extends AutheticationEvent {
  const OnGetPuntosCorte();
}

class OnChangedShowScrollInfo extends AutheticationEvent {
  const OnChangedShowScrollInfo();
}

class OnChangedDataCorte extends AutheticationEvent {
  final int dataCorte;
  const OnChangedDataCorte(this.dataCorte);
}

class OnFiltroViewClienteDPC extends AutheticationEvent {
  final String filtroViewCliente;
  const OnFiltroViewClienteDPC(this.filtroViewCliente);
}

class OnResetViewClienteDPC extends AutheticationEvent {
  const OnResetViewClienteDPC();
}

class OnUpdatePuntosCorte extends AutheticationEvent {
  const OnUpdatePuntosCorte();
}

class OnChangedProcesoCambioRuta extends AutheticationEvent {
  final ProcesoCambioRuta procesoCambioRuta;
  const OnChangedProcesoCambioRuta(this.procesoCambioRuta);
}

class OnChangedFiltroRutaCorte extends AutheticationEvent {
  final TipoTransporte? tipoTransporte;
  final NivelTrafico? nivelTrafico;
  final int? tipoRuta;
  final bool? showAlternativa;

  const OnChangedFiltroRutaCorte({
    this.tipoTransporte,
    this.nivelTrafico,
    this.tipoRuta,
    this.showAlternativa,
  });
}

class OnChangedRutasGoogleApi extends AutheticationEvent {
  final List<RutaGoogleApi> rutasGoogleApi;
  const OnChangedRutasGoogleApi(this.rutasGoogleApi);
}

class OnIniciarSesion extends AutheticationEvent {
  final BuildContext context;
  final String username;
  final String password;
  const OnIniciarSesion(this.username, this.password, this.context);
}

class OnChangedProccessAuth extends AutheticationEvent {
  final ProcesoAuthentication procesoAuthentication;
  const OnChangedProccessAuth(this.procesoAuthentication);
}

class OnActualizatPuntoCorte extends AutheticationEvent {
  final String liNcoc;
  const OnActualizatPuntoCorte(this.liNcoc);
}
