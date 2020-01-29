import 'package:equatable/equatable.dart';

const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

abstract class Failure extends Equatable {
  final List properties;

  Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
