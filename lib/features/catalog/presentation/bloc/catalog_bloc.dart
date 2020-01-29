import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_health_controller/core/error/exceptions.dart';
import 'package:flutter_health_controller/core/error/failures.dart';
import 'package:flutter_health_controller/features/catalog/domain/entities/food.dart';
import 'package:flutter_health_controller/features/catalog/domain/usecases/get_food_by_name.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final GetFoodByName getFood;

  CatalogBloc({
    @required GetFoodByName food,
  })  : assert(food != null),
        getFood = food;

  @override
  CatalogState get initialState => InitialCatalogState();

  @override
  Stream<CatalogState> mapEventToState(CatalogEvent event) async* {
    if (event is NavigationComplete) {
      yield InitialCatalogState();
    }

    if (event is GetFood) {
      yield CatalogLoading();
      final failureOrFood = await getFood(Params(name: event.name));
      yield* _eitherLoadedOrErrorState(failureOrFood);
    }
  }

  Stream<CatalogState> _eitherLoadedOrErrorState(Either<Failure, Food> failureOrFood) async* {
    yield failureOrFood.fold(
      (failure) => CatalogError(message: _mapFailureToMessage(failure)),
      (food) => CatalogLoaded(foodData: food),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
