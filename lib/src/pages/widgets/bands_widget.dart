import 'package:band_names/src/models/band_model.dart';
import 'package:band_names/src/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BansWidget extends StatelessWidget {
  const BansWidget({super.key, required this.bands});
  final List<Band> bands;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bands.length,
      itemBuilder: (context, i) {
        final band = bands[i];
        return Dismissible(
          key: Key(band.id),
          direction: DismissDirection.startToEnd,
          background: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
            child: const Text(
              'Delete band',
              style: TextStyle(color: Colors.white),
            ),
          ),
          onDismissed: (direction) => _deleteBand(context, id: band.id),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text(
                band.name.substring(0, 2),
              ),
            ),
            title: Text(band.name),
            trailing: Text(
              '${band.votes}',
              style: const TextStyle(fontSize: 20),
            ),
            onTap: () => voteByBand(context, id: band.id),
          ),
        );
      },
    );
  }

  void voteByBand(BuildContext context, {required String id}) {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.emit('vote-band', {'id': id});
  }

  void _deleteBand(BuildContext context, {required String id}) {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.emit('delete-band', {
      'id': id,
    });
  }
}
