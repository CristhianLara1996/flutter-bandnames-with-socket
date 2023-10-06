import 'package:band_names/src/models/band_model.dart';
import 'package:band_names/src/pages/widgets/bands_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metal', votes: 10),
    Band(id: '2', name: 'Regue', votes: 1),
    Band(id: '3', name: 'Salsa', votes: 9),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Band Names'),
      ),
      body: BansWidget(bands: bands),
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
      bands.add(Band(
        id: DateTime.now().toString(),
        name: name,
      ));
      Navigator.pop(context);
      setState(() {});
    }
  }
}
