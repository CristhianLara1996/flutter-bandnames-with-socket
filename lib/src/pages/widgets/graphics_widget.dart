import 'package:band_names/src/models/band_model.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

final gradientList = <List<Color>>[
  [
    const Color.fromRGBO(223, 250, 92, 1),
    const Color.fromRGBO(129, 250, 112, 1),
  ],
  [
    const Color.fromRGBO(129, 182, 205, 1),
    const Color.fromRGBO(91, 253, 199, 1),
  ],
  [
    const Color.fromRGBO(175, 63, 62, 1.0),
    const Color.fromRGBO(254, 154, 92, 1),
  ]
];

// Map<String, double> dataMap = {
//   "Flutter": 5,
//   "React": 3,
//   "Xamarin": 2,
//   "Ionic": 2,
// };

class GraphicsWidget extends StatelessWidget {
  const GraphicsWidget({super.key, required this.bands});

  final List<Band> bands;

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {};
    bands
        .map(
          (band) => dataMap.putIfAbsent(band.name, () => band.votes.toDouble()),
        )
        .toList();
    if (bands.isEmpty) {
      return const Text('Data empty');
    }

    return PieChart(
      dataMap: dataMap,
      gradientList: gradientList,
      animationDuration: const Duration(milliseconds: 800),
      // chartLegendSpacing: 32,
      // chartRadius: MediaQuery.of(context).size.width / 3.2,
      // initialAngleInDegree: 0,
      // chartType: ChartType.ring,
      // ringStrokeWidth: 32,
      // centerText: "HYBRID",
      // legendOptions: const LegendOptions(
      //   showLegendsInRow: false,
      //   legendPosition: LegendPosition.right,
      //   showLegends: true,
      //   legendShape: BoxShape.circle,
      //   legendTextStyle: TextStyle(
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      // chartValuesOptions: const ChartValuesOptions(
      //   showChartValueBackground: true,
      //   showChartValues: true,
      //   showChartValuesInPercentage: false,
      //   showChartValuesOutside: false,
      //   decimalPlaces: 1,
      // ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    );
  }
}
