import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health_controller/features/statistic/presentation/widgets/pie_chart.dart';

import '../../../account/presentation/bloc/bloc.dart';
import '../widgets/vertical_chart.dart';

class StatisticPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.8,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              color: Colors.blue[600],
              child: BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
                  if (state is AccountInitialized) {
                    return VerticalChart(
                      barGroupsData: state.account.weightStatistic.last.values.map((item) {
                        return BarChartGroupData(
                          x: 0,
                          barRods: [BarChartRodData(y: item, color: Colors.white)],
                          showingTooltipIndicators: item > 0 ? [0] : [],
                        );
                      }).toList(),
                    );
                  }

                  return Container();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Статистика еды',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccountInitialized && state.account.foodStatistic.isNotEmpty) {
                return PieStatisticChart(
                  foodData: state.account.foodStatistic,
                  total: state.account.totalColories,
                );
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
