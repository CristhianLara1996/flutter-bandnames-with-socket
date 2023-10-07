import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus {
  online('Online'),
  offline('Offline'),
  connecting('Connecting');

  const ServerStatus(this.status);

  final String status;
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  IO.Socket get socket => _socket;
  ServerStatus get serverStatus => _serverStatus;

  SocketService() {
    _initSetup();
  }

  void _initSetup() {
// Dart client
    _socket = IO.io(
        'http://192.168.18.75:3000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setExtraHeaders({'foo': 'bar'})
            .build());
    _socket.connect();

    _socket.onConnect((_) {
      print('😀 connect');
      _serverStatus = ServerStatus.online;
      notifyListeners();
      // socket.emit('msg', 'test');
    });
    _socket.onDisconnect((_) {
      print('😀 disconnect');
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    socket.on('new-message', (payload) {
      print('😀 new-message: $payload');
    });
  }
}
