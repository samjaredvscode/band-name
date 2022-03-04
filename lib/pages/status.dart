import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:band_name/services/socket_services.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketServices = Provider.of<SocketService>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Server Status: ${socketServices.serverStatus}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: () {
          socketServices.socket.emit(
            'emitir-mensaje',
            {
              'nombre': 'Flutter',
              'mensaje': 'Hola desde Flutter',
            },
          );
        },
      ),
    );
  }
}
