import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:band_name/models/bands.dart';
import 'package:band_name/services/socket_services.dart';

class BandTitleCustom extends StatelessWidget {
  const BandTitleCustom({
    Key? key,
    required this.context,
    required this.band,
  }) : super(key: key);

  final BuildContext context;
  final Band band;

  @override
  Widget build(BuildContext context) {
    final socketServices = Provider.of<SocketService>(context, listen: false);
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) {
        socketServices.socket.emit('delete-band', {'id': band.id});
      },
      background: Container(
        alignment: const AlignmentDirectional(-0.85, 0),
        color: Colors.redAccent,
        child: const Icon(
          Icons.auto_delete_rounded,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            band.name.substring(0, 2),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.blue[300],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          socketServices.socket.emit('vote-band', {'id': band.id});
        },
      ),
    );
  }
}
