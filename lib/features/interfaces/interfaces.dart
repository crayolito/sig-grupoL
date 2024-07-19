import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTypeOptions {
  final String titulo;
  final MapType tipoMapa;
  final String imagen;
  final GestureTapCallback onTap;

  MapTypeOptions({
    required this.titulo,
    required this.tipoMapa,
    required this.imagen,
    required this.onTap,
  });
}
