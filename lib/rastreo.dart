import 'package:flutter/material.dart';

class ResultadoRastreoPage extends StatelessWidget {
  final List<dynamic> data;
  final String folio;

  const ResultadoRastreoPage({
    super.key,
    required this.data,
    required this.folio,
  });

  @override
  Widget build(BuildContext context) {
    // Buscar escala donde se encuentra la ubicacion actual del envio
    int? ordenActualEscala;
    for (var escala in data) {
      if (escala['ubicacionActual'] == escala['origen']['nombre']) {
        ordenActualEscala = escala['orden_escala'];
        break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Resultado del Rastreo"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Envío con número de folio: $folio",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Total de escalas: ${data.length}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final escala = data[index];
                  final origen = escala['origen'];
                  final destino = escala['destino'];

                  final bool esUbicacionActual =
                      escala['ubicacionActual'] == origen['nombre'];
                  final int escalaActual = escala['orden_escala'];

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: esUbicacionActual
                                  ? Colors.green
                                  : Colors.amber,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 2,
                              height: 100,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Opacity(
                          opacity: ordenActualEscala != null && escala['orden_escala'] > ordenActualEscala ? 0.4 : 1.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (esUbicacionActual)
                                const Text(
                                  "Actualmente",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              Text(
                                "Tu envío ha salido de ${origen['nombre']} con destino a ${destino['nombre']}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Origen: ${origen['nombre']} (${origen['ciudad']['nombre']})",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Destino: ${destino['nombre']} (${destino['ciudad']['nombre']})",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
