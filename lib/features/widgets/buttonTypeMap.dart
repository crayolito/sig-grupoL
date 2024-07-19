import 'package:app_sig2024/blocs/googleMap/google_map_bloc.dart';
import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/features/interfaces/interfaces.dart';
import 'package:app_sig2024/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonTypeMap extends StatelessWidget {
  const ButtonTypeMap({
    super.key,
    required this.data,
  });

  final MapTypeOptions data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final googleMapBloc = BlocProvider.of<GoogleMapBloc>(context, listen: true);

    final decoration = BoxDecoration(
        border: Border.all(
            color: data.tipoMapa == googleMapBloc.state.mapType
                ? kSecondaryColor
                : Colors.transparent,
            width: 3),
        borderRadius: BorderRadius.circular(10));
    final padding = EdgeInsets.symmetric(
        horizontal: size.width * 0.005, vertical: size.height * 0.003);

    return GestureDetector(
      onTap: data.onTap,
      child: SizedBox(
        height: size.height * 0.17,
        width: size.width * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: (size.height * 0.17) * 0.7,
                width: (size.width * 0.3) * 0.83,
                padding: padding,
                decoration: decoration,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: AssetImage(data.imagen),
                    fit: BoxFit.cover,
                  ),
                )),
            Text(
              data.titulo,
              style: data.tipoMapa == googleMapBloc.state.mapType
                  ? estilosText!.subTituloTipoMapa1
                  : estilosText!.subTituloTipoMapa2,
            )
          ],
        ),
      ),
    );
  }
}
