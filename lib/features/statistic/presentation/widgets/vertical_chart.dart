import 'dart:math';
import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

class VerticalChart extends StatelessWidget {
  const VerticalChart({@required this.barGroupsData});

  final List<BarChartGroupData> barGroupsData;

  double get maxY {
    final maxValue = barGroupsData.map((i) => (i.barRods.map((i) => i.y).reduce(max))).reduce(max);
    if (maxValue < 51) {
      return 50;
    } else if (maxValue > 101) {
      return 100;
    } else if (maxValue > 151) {
      return 150;
    } else {
      return 200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          barTouchData: BarTouchData(
            enabled: false,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.transparent,
              tooltipPadding: const EdgeInsets.all(0),
              tooltipBottomMargin: 4,
              getTooltipItem: (BarChartGroupData group, int groupIndex, BarChartRodData rod, int rodIndex) {
                return BarTooltipItem(
                  rod.y.round().toString(),
                  TextStyle(
                    color: Colors.white.withAlpha(175),
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              textStyle: TextStyle(color: Colors.amber, fontWeight: FontWeight.w300, fontSize: 18),
              margin: 10,
              getTitles: (double value) {
                switch (value.toInt()) {
                  case 0:
                    return 'Пн';
                  case 1:
                    return 'Вт';
                  case 2:
                    return 'Ср';
                  case 3:
                    return 'Чт';
                  case 4:
                    return 'Пт';
                  case 5:
                    return 'Сб';
                  case 6:
                    return 'Вс';
                  default:
                    return '';
                }
              },
            ),
            leftTitles: const SideTitles(showTitles: false),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: barGroupsData,
        ),
      ),
    );
  }
}
