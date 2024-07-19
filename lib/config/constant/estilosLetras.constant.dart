import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/config/constant/shadow.constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EstilosLetras {
  BuildContext context;

  EstilosLetras(this.context);

  Size get size => MediaQuery.of(context).size;

  // HOME(SCREEN) AUTHENTICATION
  TextStyle get tituloAuth => GoogleFonts.ptSans(
      fontSize: size.width * 0.12,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      shadows: shadowKS);

  TextStyle get subTituloAuth => GoogleFonts.ptSans(
        fontSize: size.width * 0.06,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  TextStyle get letraInput => GoogleFonts.ptSans(
        fontSize: size.width * 0.06,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get buttonLetra => GoogleFonts.ptSans(
        fontSize: size.width * 0.06,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  TextStyle get registroLetra1 => GoogleFonts.ptSans(
        fontSize: size.width * 0.045,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get registroLetra2 => GoogleFonts.ptSans(
        fontSize: size.width * 0.04,
        color: kPrimaryColor,
      );

  // // // // // //

  // TIPOS DE MAPAS
  TextStyle get tituloTipoMapa => GoogleFonts.ptSans(
        fontSize: size.width * 0.07,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subTituloTipoMapa1 => GoogleFonts.ptSans(
        fontSize: size.width * 0.05,
        color: kSecondaryColor,
      );

  TextStyle get subTituloTipoMapa2 => GoogleFonts.ptSans(
        fontSize: size.width * 0.05,
        color: kPrimaryColor,
      );

  // // // // // //

  // OPCIONES DE FILTRO DE RUTA
  TextStyle get tituloFiltroRuta => GoogleFonts.ptSans(
        fontSize: size.width * 0.07,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get titulo2FiltroRuta => GoogleFonts.ptSans(
        fontSize: size.width * 0.055,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subTituloFiltroRuta => GoogleFonts.ptSans(
        fontSize: size.width * 0.05,
        color: kSecondaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subTituloFiltroRutaSeleccionado => GoogleFonts.ptSans(
      fontSize: size.width * 0.05,
      color: kPrimaryColor,
      fontWeight: FontWeight.bold,
      shadows: shadowKS);

  TextStyle get subTitulo2FiltroRuta => GoogleFonts.ptSans(
        fontSize: size.width * 0.05,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  TextStyle get titulo => GoogleFonts.ptSans(
      fontSize: size.width * 0.05,
      fontWeight: FontWeight.bold,
      color: kSecondaryColor,
      shadows: shadowKP);

  TextStyle get titulo2 => GoogleFonts.ptSans(
      fontSize: size.width * 0.07, color: kSecondaryColor, shadows: shadowKP);

  TextStyle get titulo3 =>
      GoogleFonts.ptSans(fontSize: size.width * 0.06, color: kPrimaryColor);

  TextStyle get titulo4 => GoogleFonts.ptSans(
      fontSize: size.width * 0.06,
      color: kSecondaryColor,
      fontWeight: FontWeight.bold,
      shadows: shadowKCC);

  TextStyle get tituloItemPC => GoogleFonts.ptSans(
        fontSize: size.width * 0.054,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subTituloItemPC => GoogleFonts.ptSans(
      fontSize: size.width * 0.05,
      color: kSecondaryColor,
      fontWeight: FontWeight.bold);

  // SCROLLVIEW INFO
  TextStyle get tituloScrollInfo => GoogleFonts.ptSans(
        fontSize: size.width * 0.07,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get tituloItemScrollInfo => GoogleFonts.ptSans(
        fontSize: size.width * 0.055,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subTituloItemScrollInfo => GoogleFonts.ptSans(
        fontSize: size.width * 0.06,
        color: kPrimaryColor,
      );

  // SCREEN INFORMACION DE PUNTOS DE CORTE
  TextStyle get tituloInfoPuntoCorte => GoogleFonts.ptSans(
        fontSize: size.width * 0.07,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subTituloInfoPuntoCorte => GoogleFonts.ptSans(
        fontSize: size.width * 0.055,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subTituloInfoPuntoCorte2 => GoogleFonts.ptSans(
        fontSize: size.width * 0.055,
        color: kPrimaryColor,
      );
}
