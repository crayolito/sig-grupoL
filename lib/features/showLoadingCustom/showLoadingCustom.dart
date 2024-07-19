import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/blocs/googleMap/google_map_bloc.dart';
import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowLoadingCustom {
  static void showLoadingMap(BuildContext context) {
    final size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: kPrimaryColor, width: 3)),
            title: Text(
              "Espere por favor",
              textAlign: TextAlign.center,
              style: estilosText!.titulo2,
            ),
            content: SizedBox(
              height: size.height * 0.1,
              width: size.width * 0.1,
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
                ),
              ),
            ),
          );
        });
  }

  static void showLoadingProcesoRutas(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final googleMapBloc = BlocProvider.of<GoogleMapBloc>(context);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return BlocListener<AutheticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state.procesoCambioRuta ==
                    ProcesoCambioRuta.procesoFinalizado) {
                  googleMapBloc.add(OnInitFigureMap(context));
                  Navigator.pop(context);
                }
              },
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: kPrimaryColor, width: 3)),
                title: Text(
                  "Espere por favor",
                  textAlign: TextAlign.center,
                  style: estilosText!.titulo2,
                ),
                content: SizedBox(
                  height: size.height * 0.1,
                  width: size.width * 0.1,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(kSecondaryColor),
                    ),
                  ),
                ),
              ));
        });
  }

  static void showLoadingAuth(BuildContext context) {
    final size = MediaQuery.of(context).size;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final autheticationBloc =
            BlocProvider.of<AutheticationBloc>(context, listen: true);
        return BlocListener<AutheticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.procesoAuthentication ==
                ProcesoAuthentication.correcto) {}
          },
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: kPrimaryColor, width: 3),
            ),
            title: Text(
              autheticationBloc.state.procesoAuthentication ==
                      ProcesoAuthentication.error
                  ? "Usuario o contraseña incorrectos"
                  : "Espere por favor",
              textAlign: TextAlign.center,
              style: estilosText!.titulo2,
            ),
            content: SizedBox(
              height: size.height * 0.1,
              width: size.width * 0.1,
              child: Center(
                child: autheticationBloc.state.procesoAuthentication ==
                        ProcesoAuthentication.error
                    ? IconButton(
                        icon: Icon(Icons.error,
                            size: size.width * 0.1, color: Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                    : const CircularProgressIndicator(
                        strokeWidth: 5,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kSecondaryColor),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showLoadingProcessUpdateSuccess(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final autheticationBloc = BlocProvider.of<AutheticationBloc>(context);

          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: kPrimaryColor, width: 3)),
            title: Text(
              "Proceso Completado",
              textAlign: TextAlign.center,
              style: estilosText!.titulo2,
            ),
            content: SizedBox(
              height: 100,
              width: 100,
              child: Center(
                  child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  autheticationBloc
                      .add(OnChangedProccessAuth(ProcesoAuthentication.none));
                },
                icon: Icon(
                  Icons.check_circle_outline,
                  color: kSecondaryColor,
                  size: 60,
                ),
              )),
            ),
          );
        });
  }

  static void showLoadingProcessUpdateError(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final autheticationBloc = BlocProvider.of<AutheticationBloc>(context);

          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: kPrimaryColor, width: 3)),
            title: Text(
              "Error en el Proceso",
              textAlign: TextAlign.center,
              style: estilosText!.titulo2,
            ),
            content: SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      autheticationBloc.add(
                          OnChangedProccessAuth(ProcesoAuthentication.none));
                    },
                    icon: Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    )),
              ),
            ),
          );
        });
  }
}
