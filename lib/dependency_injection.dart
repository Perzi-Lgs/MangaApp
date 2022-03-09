import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile/features/homepage/data/datasources/Homepage_remote_data_source.dart';
import 'package:mobile/features/homepage/data/repositories/HomePage_repository_impl.dart';
import 'package:mobile/features/homepage/domain/repositories/HomePage_repository.dart';
import 'package:mobile/features/homepage/presentation/bloc/homepage_bloc.dart';
import 'package:http/http.dart' as http;

import 'core/network.dart';
import 'features/homepage/domain/usecases/get_homepage_scans.dart';
import 'features/homepage/domain/usecases/get_list_manga_per_sources.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => HomepageBloc(
        getHomepageScans: sl(),
      ));

  //usecase

  sl.registerLazySingleton(() => GetHomepageScans(sl()));
  sl.registerLazySingleton(() => GetListMangaPerSource(sl()));

  //repository
  sl.registerLazySingleton<HomePageRepository>(() => HomePageRepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl()));

  //Data Sources
  sl.registerLazySingleton<HomepageRemoteDataSource>(
      () => HomepageRemoteDataSourceImpl(client: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
