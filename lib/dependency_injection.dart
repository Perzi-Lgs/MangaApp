import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile/features/homepage/data/datasources/Homepage_remote_data_source.dart';
import 'package:mobile/features/homepage/data/repositories/HomePage_repository_impl.dart';
import 'package:mobile/features/homepage/domain/repositories/HomePage_repository.dart';
import 'package:mobile/features/homepage/presentation/bloc/homepage_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/features/manga_info_page/data/datasources/Manga_info_page_remote_data_source.dart';
import 'package:mobile/features/manga_info_page/domain/usecases/get_manga_full_info.dart';

import 'core/network.dart';
import 'features/homepage/domain/usecases/get_homepage_scans.dart';
import 'features/homepage/domain/usecases/get_list_manga_per_sources.dart';
import 'features/manga_info_page/data/repositories/Manga_info_page_repository_impl.dart';
import 'features/manga_info_page/domain/repositories/HomePage_repository.dart';
import 'features/manga_info_page/presentation/bloc/mangainfo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => HomepageBloc(getHomepageScans: sl()));
  sl.registerFactory(() => MangainfoBloc(getFullMangaInfo: sl()));

  //usecase

  sl.registerLazySingleton(() => GetHomepageScans(sl()));
  sl.registerLazySingleton(() => GetListMangaPerSource(sl()));
  sl.registerLazySingleton(() => GetFullMangaInfo(sl()));

  //repository
  sl.registerLazySingleton<HomePageRepository>(
      () => HomePageRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<MangaInfoPageRepository>(
      () => MangaInfoPageRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  //Data Sources
  sl.registerLazySingleton<HomepageRemoteDataSource>(
      () => HomepageRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<MangaInfoPageRemoteDatasource>(
      () => MangaInfoPageRemoteDatasourceImpl(client: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
