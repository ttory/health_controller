import 'package:equatable/equatable.dart';

abstract class StatisticState extends Equatable {
  const StatisticState();
}

class InitialStatisticState extends StatisticState {
  @override
  List<Object> get props => [];
}
