import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  @override
  StatisticState get initialState => InitialStatisticState();

  @override
  Stream<StatisticState> mapEventToState(
    StatisticEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
