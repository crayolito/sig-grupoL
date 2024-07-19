import 'package:app_sig2024/blocs/googleMap/google_map_bloc.dart';
import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/features/interfaces/interfaces.dart';
import 'package:app_sig2024/features/widgets/containerTypeMap.widget.dart';
import 'package:app_sig2024/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OptionsTypeMap extends StatelessWidget {
  const OptionsTypeMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final googleMapBloc = BlocProvider.of<GoogleMapBloc>(context, listen: true);

    List<MapTypeOptions> mapTypeOptions1 = [
      MapTypeOptions(
          titulo: "Estándar",
          tipoMapa: MapType.normal,
          imagen: "assets/mapaNormal.png",
          onTap: () {
            googleMapBloc.add(const OnChangeTypeMap(MapType.normal));
          }),
      MapTypeOptions(
          titulo: "Satélite",
          tipoMapa: MapType.satellite,
          imagen: "assets/mapaSatellite.png",
          onTap: () {
            googleMapBloc.add(const OnChangeTypeMap(MapType.satellite));
          }),
      MapTypeOptions(
          titulo: "Terreno",
          tipoMapa: MapType.terrain,
          imagen: "assets/mapaTerrain.png",
          onTap: () {
            googleMapBloc.add(const OnChangeTypeMap(MapType.terrain));
          })
    ];

    List<MapTypeOptions> mapTypeOptions2 = [
      MapTypeOptions(
          titulo: "Híbrido",
          tipoMapa: MapType.hybrid,
          imagen: "assets/mapaHybrid.png",
          onTap: () {
            googleMapBloc.add(const OnChangeTypeMap(MapType.hybrid));
          }),
    ];

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.01, vertical: size.height * 0.01),
        margin: EdgeInsets.only(top: size.height * 0.55),
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Column(
          children: [
            // TITULO
            Container(
              width: size.width,
              height: size.height * 0.05,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tipos de Mapa",
                    style: estilosText!.tituloTipoMapa,
                    textAlign: TextAlign.start,
                  ),
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(
                        FontAwesomeIcons.xmark,
                        color: kPrimaryColor,
                        size: size.width * 0.08,
                      ))
                ],
              ),
            ),
            ContainerTypeMap(
              listaButtons: mapTypeOptions1,
            ),
            ContainerTypeMap(
              listaButtons: mapTypeOptions2,
            ),
          ],
        ),
      ),
    );
  }
}
