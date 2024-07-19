import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

class PruebaList extends StatefulWidget {
  const PruebaList({super.key});

  @override
  State<PruebaList> createState() => _PruebaListState();
}

class _PruebaListState extends State<PruebaList> {
  String dataResponse = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerDatos().then((result) {
      setState(() {
        dataResponse = pruebasParse(result);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
          height: size.height,
          width: size.width,
          child: Center(child: Text(dataResponse))
          // ListView.builder(
          //   itemCount: 10,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text('Item $index'),
          //       onTap: () {
          //         print('Item $index');
          //       },
          //     );
          //   },
          // ),
          ),
    );
  }
}

Future<String> obtenerDatos() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://190.171.244.211:8080/wsVarios/wsBS.asmx',
    ),
  );

  String data = '''
        <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                     xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                     xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
          <soap:Body>
              <W2Corte_ReporteParaCortesSIG xmlns="http://activebs.net/">
                  <liNrut>1</liNrut>
                  <liNcnt>0</liNcnt>
                  <liCper>0</liCper>
              </W2Corte_ReporteParaCortesSIG>
          </soap:Body>
      </soap:Envelope>
  ''';

  try {
    var response = await dio.post('',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'text/xml; charset=utf-8',
            'SOAPAction': 'http://activebs.net/W2Corte_ReporteParaCortesSIG'
          },
        ));

    return response.data;
  } catch (e) {
    print(e);
  }

  return '';
}

String pruebasParse(String xmlResponse) {
  final documento = XmlDocument.parse(xmlResponse);
  final encontrarEtiqueta = documento.findAllElements('bscocNcoc');
  List<String> resultados = [];
  encontrarEtiqueta.map((e) => e.innerText).forEach((element) {
    resultados.add(element);
  });
  return resultados.join('\n');
}
