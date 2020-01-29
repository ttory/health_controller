import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';

import 'core/client/request_edamam.dart';
import 'core/client/request_pixels.dart';
import 'core/network/network_info.dart';
import 'features/catalog/data/datasources/catalog_remote_data_source.dart';
import 'features/catalog/data/repositories/catalog_repository_impl.dart';
import 'features/catalog/domain/repositories/catalog_repository.dart';
import 'features/catalog/domain/usecases/get_food_by_name.dart';
import 'features/catalog/presentation/bloc/bloc.dart';

final sl = GetIt.instance;

void injectCatalog() {
  // Bloc
  sl.registerFactory(() => CatalogBloc(food: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetFoodByName(sl()));

  // Repository
  sl.registerLazySingleton<CatalogRepository>(() => CatalogRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<CatalogRemoteDataSource>(() => CatalogRemoteDataSourceImpl(clientEdamam: sl(), clientPixels: sl()));
}

void init() {
  //! Features - Catalog
  injectCatalog();

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => RequestEdamam());
  sl.registerLazySingleton(() => RequestPixels());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
