import 'package:app_sig2024/features/interfaces/interfaces.dart';
import 'package:app_sig2024/features/widgets/buttonTypeMap.dart';
import 'package:flutter/material.dart';

class ContainerTypeMap extends StatelessWidget {
  const ContainerTypeMap({
    super.key,
    required this.listaButtons,
  });

  final List<MapTypeOptions> listaButtons;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.17,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [...listaButtons.map((e) => ButtonTypeMap(data: e))],
      ),
    );
  }
}
