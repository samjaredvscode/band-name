import 'package:flutter/material.dart';
import 'package:band_name/models/bands.dart';
import 'package:pie_chart/pie_chart.dart';

class ShowGraph extends StatelessWidget {
  const ShowGraph({
    Key? key,
    required this.bands,
    required this.context,
  }) : super(key: key);

  final List<Band> bands;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {};

    for (var bands in bands) {
      dataMap.putIfAbsent(
        (bands.name.isNotEmpty) ? bands.name : 'no hay',
        () => bands.votes.toDouble(),
      );
    }

    final List<Color> colorList = [
      Colors.blue,
      Colors.amber,
      Colors.yellow,
      Colors.redAccent,
      Colors.blueAccent,
      Colors.deepOrange,
    ];

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: PieChart(
        dataMap: dataMap,
        animationDuration: const Duration(seconds: 2),
        chartLegendSpacing: 32,
        chartRadius: MediaQuery.of(context).size.width / 3.2,
        colorList: colorList,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 20,
        centerText: "BANDAS",
        legendOptions: const LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendShape: BoxShape.circle,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: const ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
          decimalPlaces: 1,
        ),
        // gradientList: ---To add gradient colors---
        // emptyColorGradient: ---Empty Color gradient---
      ),
    );
  }
}
