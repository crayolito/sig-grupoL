import 'package:app_sig2024/blocs/googleMap/google_map_bloc.dart';
import 'package:app_sig2024/blocs/location/location_bloc.dart';
import 'package:app_sig2024/features/showLoadingCustom/showLoadingCustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  final Set<Polygon> polygons;
  final Set<Marker> markers;
  final Set<Polyline> polylines;

  const GoogleMapView(
      {super.key,
      required this.polygons,
      required this.markers,
      required this.polylines});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowLoadingCustom.showLoadingMap(context);
      Future.delayed(const Duration(seconds: 3))
          .then((value) => Navigator.pop(context));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final googleMapBloc = BlocProvider.of<GoogleMapBloc>(context, listen: true);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    // final CameraPosition initialCameraPosition = CameraPosition(
    //     target: LatLng(
    //       locationBloc.state.lastKnowLocationGM!.latitude,
    //       locationBloc.state.lastKnowLocationGM!.longitude,
    //     ),
    //     zoom: 17);

    const initialCameraPosition = CameraPosition(
        target: LatLng(-16.36485088715999, -60.97646113472762), zoom: 17);
    return SizedBox(
        width: size.width,
        height: size.height,
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          mapType: googleMapBloc.state.mapType,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          compassEnabled: false,
          mapToolbarEnabled: false,
          zoomGesturesEnabled: true,
          buildingsEnabled: true,
          indoorViewEnabled: true,
          // fortyFiveDegreeImageryEnabled: true,
          // liteModeEnabled: true,
          // rotateGesturesEnabled: true,
          // scrollGesturesEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            googleMapBloc.add(OnMapInitialControllerMap(controller, context));
          },
          onCameraMove: (CameraPosition cameraPosition) {
            googleMapBloc.add(OnMapInitialControllerCamera(cameraPosition));
          },
          polygons: widget.polygons,
          markers: widget.markers,
          polylines: widget.polylines,
          // style: jsonEncode(mapTheme),
        ));
  }
}
