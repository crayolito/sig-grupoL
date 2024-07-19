import 'package:animate_do/animate_do.dart';
import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/blocs/googleMap/google_map_bloc.dart';
import 'package:app_sig2024/blocs/location/location_bloc.dart';
import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/features/geolocalizacion/domain/entities/responseRutas.dart';
import 'package:app_sig2024/features/geolocalizacion/presentation/screens/map-loading.sreen.dart';
import 'package:app_sig2024/features/geolocalizacion/presentation/views/google-map.view.dart';
import 'package:app_sig2024/features/geolocalizacion/presentation/widgets/optionsMap.widget.dart';
import 'package:app_sig2024/features/geolocalizacion/presentation/widgets/searchBarCustom.dart';
import 'package:app_sig2024/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final autheticationBloc =
        BlocProvider.of<AutheticationBloc>(context, listen: true);
    return BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
      if (locationState.lastKnowLocationGM == null ||
          autheticationBloc.state.puntosCorte == null) {
        return const MapLoading();
      }

      return Material(
        child: Stack(
          children: [
            // MAPA GOOGLE
            const GoogleMapCustom(),
            // SEARCH BAR
            Positioned(
                top: size.height * 0.04,
                left: size.width * 0.04,
                child: const SearchBarCustom()),
            // OPTIONS MAP
            const OptionsMap(),
            // SHOW SCROLL INFO PUNTOS CORTE
            autheticationBloc.state.showAlternativa &&
                    autheticationBloc.state.rutasGoogleApi.isNotEmpty
                ? const ScrollViewInfo()
                : Container()
          ],
        ),
      );
    });
  }
}

class ScrollViewInfo extends StatelessWidget {
  const ScrollViewInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final autheticationBloc =
        BlocProvider.of<AutheticationBloc>(context, listen: true);

    return FadeInUp(
        child: DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                width: size.width,
                padding: EdgeInsets.only(
                  top: size.height * 0.02,
                  left: size.width * 0.02,
                  right: size.width * 0.02,
                ),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(
                            color: kPrimaryColor,
                            width: 4,
                            style: BorderStyle.solid)),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: size.width * 0.15,
                          height: size.height * 0.005,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "ESCOGA UNA RUTA",
                          style: estilosText!.tituloScrollInfo,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      ...autheticationBloc.state.rutasGoogleApi
                          .asMap()
                          .entries
                          .map((entry) => ItemRutaAlternativa(
                              data: entry.value, index: entry.key)),
                    ],
                  ),
                ),
              );
            }));
  }
}

class ItemRutaAlternativa extends StatelessWidget {
  const ItemRutaAlternativa({
    super.key,
    required this.data,
    required this.index,
  });

  final RutaGoogleApi data;
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final googleMapBloc = BlocProvider.of<GoogleMapBloc>(context, listen: true);

    return Container(
      width: size.width,
      height: size.height * 0.16,
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 2,
              offset: const Offset(-2, -2),
            )
          ]),
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.835,
            height: size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Ruta ${index + 1}",
                    style: estilosText!.tituloItemScrollInfo,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: size.width * 0.03),
                  width: size.width * 0.835,
                  height: size.height * 0.06,
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.ruler,
                        size: size.width * 0.06,
                        color: kSecondaryColor,
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Text(metrosAKilometrosConDetalle(data.metros),
                          style: estilosText!.subTituloItemScrollInfo),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: size.width * 0.03),
                  width: size.width * 0.835,
                  height: size.height * 0.06,
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.clock,
                        size: size.width * 0.06,
                        color: kSecondaryColor,
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Text(
                        segundosAFormatoTiempo(data.segundos),
                        style: estilosText!.subTituloItemScrollInfo,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: IconButton(
                onPressed: () {
                  googleMapBloc.add(const OnClearPolilyne());
                  googleMapBloc
                      .add(OnInitPolylineByCodigo(data.codigoPolilinea));
                },
                icon: Icon(
                  FontAwesomeIcons.route,
                  size: size.width * 0.08,
                  color: kPrimaryColor,
                )),
          )
        ],
      ),
    );
  }
}

String metrosAKilometrosConDetalle(int metros) {
  int kilometros = metros ~/ 1000;
  int metrosRestantes = metros % 1000;
  return "$kilometros km $metrosRestantes m";
}

String segundosAFormatoTiempo(String segundosStr) {
  int totalSegundos = int.parse(segundosStr.replaceAll('s', ''));
  int horas = totalSegundos ~/ 3600;
  int minutos = (totalSegundos % 3600) ~/ 60;
  int segundos = totalSegundos % 60;

  String resultado = "";
  if (horas > 0) {
    resultado += "$horas hora${horas > 1 ? "s " : " "}";
  }
  if (minutos > 0 || horas > 0) {
    resultado += "$minutos minuto${minutos != 1 ? "s " : " "}";
  }
  resultado += "$segundos segundo${segundos != 1 ? "s" : ""}";

  return resultado.trim();
}

class GoogleMapCustom extends StatelessWidget {
  const GoogleMapCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleMapBloc, GoogleMapState>(
        builder: (context, googleMapState) {
      return GoogleMapView(
        polygons: googleMapState.polygons.values.toSet(),
        markers: googleMapState.markers.values.toSet(),
        polylines: googleMapState.polylines.values.toSet(),
      );
    });
  }
}
