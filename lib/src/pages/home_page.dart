import 'package:band_names/src/models/band_model.dart';
import 'package:band_names/src/pages/widgets/bands_widget.dart';
import 'package:band_names/src/pages/widgets/graphics_widget.dart';
import 'package:band_names/src/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [];

  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-bands', _handleActiveBands);
    super.initState();
  }

  void _handleActiveBands(dynamic payload) {
    print('new List $payload');
    bands = List.from(payload).map((e) => Band.fromMap(e)).toList();
    setState(() {});
    print(payload);
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('active-bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Band Names'),
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            child: socketService.serverStatus == ServerStatus.online
                ? Icon(
                    Icons.check_circle,
                    color: Colors.blue[300],
                  )
                : const Icon(
                    Icons.check_circle,
                    color: Colors.red,
                  ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
                child: GraphicsWidget(
              bands: bands,
            )),
            Expanded(flex: 1, child: BansWidget(bands: bands)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _modalAddNewBand(),
      ),
    );
  }

  void _modalAddNewBand() {
    final txtName = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => Material(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'New band name:',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextField(
                    controller: txtName,
                  ),
                  ElevatedButton(
                    onPressed: () => _createBand(txtName.text),
                    child: const Text('add'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _createBand(String name) {
    if (name.isNotEmpty) {
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.socket.emit('create-band', {
        'name': name,
      });

      Navigator.pop(context);
      setState(() {});
    }
  }
}
