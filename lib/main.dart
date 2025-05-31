import 'dart:convert';

import 'rastreo.dart';
import 'package:flutter/material.dart';
import 'api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color colorDHL = const Color(0xFFFFCC00);
    return MaterialApp(
      title: 'DHL',
      home: const MyHomePage(
        title: 'DHL',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _folioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color colorDHL = const Color(0xFFFFCC00);
    return Scaffold(
      appBar: AppBar(backgroundColor: colorDHL, title: Text(widget.title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start, // <-- alineado arriba
            children: <Widget>[
              // Imagen arriba
              SizedBox(
                height: 100,
                child: Image.asset(
                  'assets/images/dhl_logo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('No se pudo cargar la imagen');
                  },
                ),
              ),

              const SizedBox(height: 40), // espacio entre imagen y texto

              const Text('Rastrear envío:', style: TextStyle(fontSize: 18)),

              const SizedBox(height: 10),

              TextField(
                controller: _folioController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(hintText: 'Folio'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var data = {'folio': _folioController.text};

          var res = await CallApi().postData(data, 'rastreo');
          var body = json.decode(res.body);

          if (body['data'] != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultadoRastreoPage(data: body['data'], folio: _folioController.text),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("No se encontró información del envío"),
              ),
            );
          }
        },
        tooltip: 'Buscar envío',
        child: const Icon(Icons.search),
      ),
    );
  }
}
