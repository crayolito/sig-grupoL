import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/blocs/location/location_bloc.dart';
import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/features/home/presentation/widgets/buttonAuth.widget.dart';
import 'package:app_sig2024/features/home/presentation/widgets/textFormFieldCustom.widget.dart';
import 'package:app_sig2024/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormCustomAuth extends StatefulWidget {
  const FormCustomAuth({
    super.key,
  });

  @override
  State<FormCustomAuth> createState() => _FormCustomAuthState();
}

class _FormCustomAuthState extends State<FormCustomAuth> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final autheticationBloc = BlocProvider.of<AutheticationBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    return Positioned(
      top: size.height * 0.6,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
        height: size.height * 0.4,
        width: size.width,
        child: Column(
          children: [
            CustomTextFormField(
                placeholder: "Nombre usuario",
                icon: Icons.person,
                color: kPrimaryColor,
                keyboardType: TextInputType.text,
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                }),
            SizedBox(
              height: size.height * 0.03,
            ),
            CustomTextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                placeholder: "Contraseña",
                icon: Icons.lock,
                color: kPrimaryColor,
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                }),
            SizedBox(
              height: size.height * 0.03,
            ),
            ButtonAuthentication(
                titulo: "Iniciar Sesion",
                onTap: () {
                  autheticationBloc
                      .add(OnIniciarSesion(email, password, context));
                  autheticationBloc.add(const OnGetPuntosCorte());
                  locationBloc.startFollowingUser();
                }),
            SizedBox(
              height: size.height * 0.065,
            ),
            // READ : MESSAGE DE PETICION DE REGISTRO
            const MessageRegistrationRequest()
          ],
        ),
      ),
    );
  }
}

class MessageRegistrationRequest extends StatelessWidget {
  const MessageRegistrationRequest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: '¿Tienes una cuenta?\n',
              style: estilosText!.registroLetra1),
          TextSpan(
            text: 'Ingresa tu código para empezar.',
            style: estilosText!.registroLetra2,
          ),
        ],
      ),
    );
  }
}

class ContainerCustom extends StatelessWidget {
  const ContainerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        height: size.height,
        child: CustomPaint(
          painter: _CurvoContainer(),
        ));
  }
}

class _CurvoContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();

    // Propiedades
    // lapiz.color = Color(0xFFFFEFCD);
    lapiz.color = Colors.white;

    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;
    lapiz.shader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter, // Ajusta este valor
      colors: [Colors.black, Colors.white],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.61));

    final path = Path();

    // Dibujar con el path y el lapiz
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.42);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.61, size.width, size.height * 0.42);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
