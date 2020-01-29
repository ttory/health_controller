import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_controller/features/catalog/data/models/food_model.dart';

import 'indicator.dart';

class PieStatisticChart extends StatefulWidget {
  const PieStatisticChart({@required this.foodData, this.total = 0});

  final List<Map<String, List<FoodModel>>> foodData;
  final double total;

  @override
  _PieStatisticChartState createState() => _PieStatisticChartState();
}

class _PieStatisticChartState extends State<PieStatisticChart> {
  int touchedIndex;
  Random _random;
  List<Color> colors;

  @override
  void initState() {
    this._random = Random();
    this.colors = List.generate(100, (i) => Color.fromRGBO(next(10, 250), next(10, 250), next(10, 250), 1.0));
    super.initState();
  }

  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: 350,
                  width: double.infinity,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd || pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 5,
                      centerSpaceRadius: 75,
                      sections: showingSections(),
                    ),
                  ),
                ),
                Positioned(
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Всего',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(widget.total.toStringAsFixed(0),
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 36.0,
                          )),
                      Text(
                        'Килокалорий',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Wrap(
                children: showingProducts(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> showingProducts() {
    int counter = 0;

    return widget.foodData.map((item) {
      return item[DateTime.now().weekday.toString()].map((item) {
        counter++;
        return Container(
          margin: const EdgeInsets.only(bottom: 6.0),
          child: Indicator(
            color: colors[counter],
            text: item.label,
            isSquare: false,
            size: 26,
          ),
        );
      }).toList();
    }).last;
  }

  List<PieChartSectionData> showingSections() {
    int counter = 0;

    return widget.foodData.map((item) {
      return item[DateTime.now().weekday.toString()].map((item) {
        //! Index = i
        final isTouched = false;
        final double fontSize = isTouched ? 22 : 16;
        final double radius = isTouched ? 60 : 55;
        counter++;

        return PieChartSectionData(
          color: colors[counter],
          value: item.colories,
          title: item.colories.toStringAsFixed(0),
          radius: radius,
          titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
        );
      }).toList();
    }).last;
  }
}

showingProducts() {}
