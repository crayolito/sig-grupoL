import 'package:animate_do/animate_do.dart';
import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/config/constant/shadow.constant.dart';
import 'package:app_sig2024/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchBarCustom extends StatelessWidget {
  const SearchBarCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        context.push('/search');
      },
      child: FadeInDown(
        child: Container(
          padding: const EdgeInsets.all(2),
          width: size.width * 0.92,
          height: size.height * 0.075,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 2,
                    offset: const Offset(
                      -1,
                      3,
                    ))
              ],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: kPrimaryColor, width: 2)),
          child: Row(
            children: [
              Icon(
                size: size.width * 0.1,
                Icons.search,
                color: kSecondaryColor,
                shadows: shadowKPN2,
              ),
              SizedBox(
                width: size.width * 0.01,
              ),
              Text(
                "Buscar ...",
                style: estilosText!.titulo2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
