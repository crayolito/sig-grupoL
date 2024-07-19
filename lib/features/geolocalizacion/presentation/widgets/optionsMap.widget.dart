import 'package:animate_do/animate_do.dart';
import 'package:app_sig2024/blocs/googleMap/google_map_bloc.dart';
import 'package:app_sig2024/blocs/location/location_bloc.dart';
import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/features/geolocalizacion/presentation/widgets/optionsTypeMap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionsMap extends StatelessWidget {
  const OptionsMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locationBloc = BlocProvider.of<LocationBloc>(context, listen: true);
    final googleMapBloc = BlocProvider.of<GoogleMapBloc>(context, listen: true);

    return FadeInRight(
        child: Padding(
      padding:
          EdgeInsets.only(right: size.width * 0.01, bottom: size.height * 0.01),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: "1",
              mini: true,
              onPressed: () {
                googleMapBloc.add(const OnCreateRouteTodoPuntos());
              },
              backgroundColor: Colors.white.withOpacity(0.85),
              child: Icon(
                FontAwesomeIcons.route,
                size: size.width * 0.055,
                color: kPrimaryColor,
              ),
            ),
            FloatingActionButton(
              heroTag: "2",
              mini: true,
              onPressed: () async {
                await googleMapBloc.orientarCamaraALaPosicion();
              },
              backgroundColor: Colors.white.withOpacity(0.85),
              child: Icon(
                FontAwesomeIcons.locationArrow,
                size: size.width * 0.07,
                color: kPrimaryColor,
              ),
            ),
            FloatingActionButton(
              heroTag: "3",
              mini: true,
              onPressed: () async {
                await googleMapBloc.reorientarCamara();
              },
              backgroundColor: Colors.white.withOpacity(0.85),
              child: Icon(
                FontAwesomeIcons.compass,
                size: size.width * 0.07,
                color: kPrimaryColor,
              ),
            ),
            FloatingActionButton(
              heroTag: "4",
              mini: true,
              onPressed: () {
                locationBloc.add(OnChangedStatusFollowUser(
                    !locationBloc.state.isFollowingUser));
              },
              backgroundColor: Colors.white.withOpacity(0.85),
              child: Icon(
                locationBloc.state.isFollowingUser
                    ? FontAwesomeIcons.person
                    : FontAwesomeIcons.personWalking,
                size: size.width * 0.07,
                color: kPrimaryColor,
              ),
            ),
            FloatingActionButton(
              heroTag: "5",
              mini: true,
              onPressed: () {
                showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return const OptionsTypeMap();
                    });
              },
              backgroundColor: Colors.white.withOpacity(0.85),
              child: Icon(
                size: size.width * 0.08,
                Icons.terrain,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
