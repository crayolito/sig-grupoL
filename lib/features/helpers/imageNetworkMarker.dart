import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> getNetworkImageMarker(String urlMarker) async {
  final resp = await Dio().get(
    urlMarker,
    options: Options(responseType: ResponseType.bytes),
  );

  final imageCodec = await ui.instantiateImageCodec(resp.data,
      targetHeight: 140, targetWidth: 140);
  final frame = await imageCodec.getNextFrame();
  final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);

  // ignore: deprecated_member_use
  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}
