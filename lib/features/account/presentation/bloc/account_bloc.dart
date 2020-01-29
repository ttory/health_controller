import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import './bloc.dart';
import '../../../catalog/data/models/food_model.dart';
import '../../data/models/account_model.dart';

class AccountBloc extends HydratedBloc<AccountEvent, AccountState> {
  @override
  AccountState get initialState {
    return super.initialState ?? InitialAccountState();
  }

  @override
  AccountState fromJson(Map<String, dynamic> json) {
    try {
      final account = AccountModel.fromJson(json);
      return AccountInitialized(account: account);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(AccountState state) {
    if (state is AccountInitialized) {
      return state.account.toJson();
    }

    return null;
  }

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    final currentState = state;

    if (currentState is InitialAccountState && event is InitAccount) {
      yield AccountInitialized(
        account: AccountModel(
          name: '',
          birthday: null,
          height: null,
          weight: null,
          goalWeight: null,
          foodStatistic: [],
          weightStatistic: [
            {
              '1': 0.0,
              '2': 0.0,
              '3': 0.0,
              '4': 0.0,
              '5': 0.0,
              '6': 0.0,
              '7': 0.0,
            }
          ],
        ),
      );
      return;
    }

    if (currentState is AccountInitialized) {
      if (event is AddWeightStatistic)
        yield currentState.copyWith(weightStatistic: addWeightStatistic(event, currentState.account.weightStatistic));
      if (event is AddFoodStatistic)
        yield currentState.copyWith(foodStatistic: addFoodStatistic(event, currentState.account.foodStatistic));

      if (event is SetName) yield currentState.copyWith(name: event.name);
      if (event is SetBirthday) yield currentState.copyWith(birthday: event.date);
      if (event is SetHeight) yield currentState.copyWith(height: event.height);
      if (event is SetWeight) yield currentState.copyWith(weight: event.weight);
      if (event is SetGoalWeight) yield currentState.copyWith(goalWeight: event.weight);
    }
  }

  List<Map<String, double>> addWeightStatistic(AddWeightStatistic event, List<Map<String, double>> weightStatistic) {
    List<Map<String, double>> data = [];

    data.addAll(weightStatistic);

    final String weekday = DateTime.now().weekday.toString();

    // Проверяем следующая ли это неделя (простая проверка, не учитываем, что может пройти две недели :))) Можно поменять на List.skip(7) в цикле, и это исправит эту прблему )
    if (int.parse(weekday) < int.parse(data.last.keys.last.toString()) && data.last.values.last.toDouble() > 0) {
      data.add({'1': 0.0, '2': 0.0, '3': 0.0, '4': 0.0, '5': 0.0, '6': 0.0, '7': 0.0});
    }

    data.forEach((week) {
      week[weekday] = event.calculatedWeight;
    });

    return data;
  }

  List<Map<String, List<FoodModel>>> addFoodStatistic(AddFoodStatistic event, List<Map<String, List<FoodModel>>> foodData) {
    List<Map<String, List<FoodModel>>> data = [];

    data.addAll(foodData);

    final String weekday = DateTime.now().weekday.toString();

    if (data.length < 1) {
      data.add({weekday: []});
    }

    data.forEach((days) {
      if (!days.containsKey(weekday)) {
        days[weekday] = [];
      }

      days[weekday].add(event.foodData);
    });

    print(data);

    return data;
  }
}
