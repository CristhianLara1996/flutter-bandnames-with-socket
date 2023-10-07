import 'package:band_names/src/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      body: Center(
        child: Text('Server Status: ${socketService.serverStatus.status}'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          print('entro');
          socketService.socket
              .emit('emit-message', {'name': 'pepe', 'msg': "Hey I'm Flutter"});
        },
      ),
    );
  }

  void emitEvent() {}
}
