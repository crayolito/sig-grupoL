import 'dart:async';

import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/config/constant/shadow.constant.dart';
import 'package:app_sig2024/features/home/presentation/widgets/buttonAuth.widget.dart';
import 'package:app_sig2024/features/showLoadingCustom/showLoadingCustom.dart';
import 'package:app_sig2024/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoPuntoCorte extends StatefulWidget {
  const InfoPuntoCorte({super.key});

  @override
  State<InfoPuntoCorte> createState() => _InfoPuntoCorteState();
}

class _InfoPuntoCorteState extends State<InfoPuntoCorte> {
  String? estadoSeleccionado;
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    final autheticationBloc = BlocProvider.of<AutheticationBloc>(context);
    _subscription = autheticationBloc.stream.listen((event) {
      if (event.procesoAuthentication == ProcesoAuthentication.correcto) {
        ShowLoadingCustom.showLoadingProcessUpdateSuccess(context);
      }
      if (event.procesoAuthentication == ProcesoAuthentication.error) {
        ShowLoadingCustom.showLoadingProcessUpdateError(context);
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final autheticationBloc = BlocProvider.of<AutheticationBloc>(context);
    final data = autheticationBloc.state.dataCorte;

    List<String> estadosCorte = [
      "Retrasado",
      "Realizado",
      "En Observacion",
      "En Proceso",
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.arrow_back,
            color: kSecondaryColor, size: size.width * 0.1),
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          color: Colors.white,
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                "INFORMACION DEL PUNTO DE CORTE",
                style: estilosText!.tituloInfoPuntoCorte,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                width: size.width,
                height: size.height * 0.85,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Codigo Ubicacion",
                      style: estilosText!.subTituloInfoPuntoCorte,
                    ),
                    Text(data!.data1,
                        style: estilosText!.subTituloInfoPuntoCorte2),
                    Text(
                      "Nombre de benefactor",
                      style: estilosText!.subTituloInfoPuntoCorte,
                    ),
                    Text(data.nombre,
                        style: estilosText!.subTituloInfoPuntoCorte2),
                    Text(
                      "Medidor Serie",
                      style: estilosText!.subTituloInfoPuntoCorte,
                    ),
                    Text(data.data2,
                        style: estilosText!.subTituloInfoPuntoCorte2),
                    Text(
                      "Codigo Fijo",
                      style: estilosText!.subTituloInfoPuntoCorte,
                    ),
                    Text(data.data3,
                        style: estilosText!.subTituloInfoPuntoCorte2),
                    Text(
                      "Estado servicio",
                      style: estilosText!.subTituloInfoPuntoCorte,
                    ),
                    Text(data.data7,
                        style: estilosText!.subTituloInfoPuntoCorte2),
                    Text(
                      "Direccion",
                      style: estilosText!.subTituloInfoPuntoCorte,
                    ),
                    Text(data.umz,
                        style: estilosText!.subTituloInfoPuntoCorte2),
                    Text(
                      "bsmedNume",
                      style: estilosText!.subTituloInfoPuntoCorte,
                    ),
                    Text(data.data6,
                        style: estilosText!.subTituloInfoPuntoCorte2),
                    Text(
                      "dNcat",
                      style: estilosText!.subTituloInfoPuntoCorte,
                    ),
                    Text(data.data8,
                        style: estilosText!.subTituloInfoPuntoCorte2),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Center(
                      child: DropdownButtonHideUnderline(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(color: kSecondaryColor, width: 2),
                          ),
                          child: DropdownButton<String>(
                            value: estadoSeleccionado,
                            icon: const Icon(
                              Icons.arrow_circle_down_rounded,
                              color: kPrimaryColor,
                              shadows: shadowKCC,
                            ),
                            hint: Text("Selecciona un estado",
                                style: estilosText!.subTituloInfoPuntoCorte),
                            onChanged: (String? nuevoValor) {
                              setState(() {
                                estadoSeleccionado = nuevoValor;
                              });
                            },
                            items: estadosCorte
                                .map<DropdownMenuItem<String>>((String valor) {
                              return DropdownMenuItem<String>(
                                value: valor,
                                child: Text(valor),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Center(
                        child: ButtonAuthentication(
                            titulo: "Guardar Datos",
                            onTap: () {
                              autheticationBloc
                                  .add(OnActualizatPuntoCorte(data.data1));
                            }))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
