import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/blocs/googleMap/google_map_bloc.dart';
import 'package:app_sig2024/blocs/location/location_bloc.dart';
import 'package:app_sig2024/blocs/permissions/permissions_bloc.dart';
import 'package:app_sig2024/config/constant/estilosLetras.constant.dart';
import 'package:app_sig2024/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

EstilosLetras? estilosText;

void main() async {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => PermissionsBloc()),
      BlocProvider(create: (context) => AutheticationBloc()),
      BlocProvider(create: (context) => LocationBloc()),
      BlocProvider(
          create: (context) => GoogleMapBloc(
              locationBloc: BlocProvider.of<LocationBloc>(context),
              authBloc: BlocProvider.of<AutheticationBloc>(context))),
      BlocProvider(create: (context) => LocationBloc()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    estilosText = EstilosLetras(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
