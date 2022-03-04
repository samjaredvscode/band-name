import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:band_name/pages/components/show_graph.dart';
import 'package:band_name/models/bands.dart';
import 'package:band_name/models/components/bands_title.dart';
import 'package:band_name/services/socket_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [];

  // Escuchamos el evento
  @override
  void initState() {
    final socketServices = Provider.of<SocketService>(context, listen: false);

    socketServices.socket.on(
      'active-bands',
      (data) => {
        bands = (data as List).map((banda) => Band.fromMap(banda)).toList(),
        setState(() {}),
      },
    );

    super.initState();
  }

  // Limpiamos el evento de la pantalla Home
  @override
  void dispose() {
    final socketServices = Provider.of<SocketService>(context, listen: false);
    socketServices.socket.off('active-bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketServices = Provider.of<SocketService>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Bandas 80' 90'",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: (socketServices.serverStatus == ServerStatus.online)
                ? Icon(Icons.check_circle_rounded, color: Colors.green[500])
                : Icon(Icons.offline_bolt, color: Colors.red[500]),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (bands.isNotEmpty) ShowGraph(bands: bands, context: context),
            ListView.builder(
              controller: ScrollController(initialScrollOffset: 1),
              shrinkWrap: true,
              itemCount: bands.length,
              itemBuilder: (_, i) =>
                  BandTitleCustom(context: context, band: bands[i]),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => addNewBand(),
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Añadir nueva Banda'),
          content: CupertinoTextField(
            controller: textController,
            textCapitalization: TextCapitalization.words,
            placeholder: 'Nombre de la Banda',
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Añadir'),
              onPressed: () {
                addBandToList(textController.text);
              },
            ),
          ],
        );
      },
    );
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.socket.emit('add-band', {'name': name});
    }
    Navigator.pop(context);
  }
}
