import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/error.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../datasources/catalog_remote_data_source.dart';
import '../models/food_model.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  final CatalogRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CatalogRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, FoodModel>> getFoodsByName(String name) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategory = await remoteDataSource.getFoodsByName(name);
        return Right(remoteCategory);
      } on ServerException {
        return Left(ServerFailure());
      }
    }

    return Left(ServerFailure());
  }
}
