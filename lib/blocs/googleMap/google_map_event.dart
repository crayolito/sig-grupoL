part of 'google_map_bloc.dart';

class GoogleMapEvent extends Equatable {
  const GoogleMapEvent();

  @override
  List<Object> get props => [];
}

// EVENTO PARA INICIALIZAR EL CONTROLADOR DEL MAPA DE GOOGLE
class OnMapInitialControllerMap extends GoogleMapEvent {
  final BuildContext context;
  final GoogleMapController controller;
  const OnMapInitialControllerMap(this.controller, this.context);
}

// EVENTO PARA INICIALIZAR EL CONTROLADOR DE CAMARA DEL MAPA DE GOOGLE
class OnMapInitialControllerCamera extends GoogleMapEvent {
  final CameraPosition cameraPosition;
  const OnMapInitialControllerCamera(this.cameraPosition);
}

class OnInitFigureMap extends GoogleMapEvent {
  final BuildContext context;
  const OnInitFigureMap(this.context);
}

class OnClearFigureMap extends GoogleMapEvent {
  const OnClearFigureMap();
}

class OnResetState extends GoogleMapEvent {
  const OnResetState();
}

class OnChangeTypeMap extends GoogleMapEvent {
  final MapType mapType;
  const OnChangeTypeMap(this.mapType);
}

class OnCreateRouteTodoPuntos extends GoogleMapEvent {
  const OnCreateRouteTodoPuntos();
}

class OnCreateRoutePuntoAPunto extends GoogleMapEvent {
  const OnCreateRoutePuntoAPunto();
}

class OnInitPolylineByCodigo extends GoogleMapEvent {
  final String codigo;
  const OnInitPolylineByCodigo(this.codigo);
}

class OnClearPolilyne extends GoogleMapEvent {
  const OnClearPolilyne();
}
