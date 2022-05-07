import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile/features/homepage/data/datasources/Homepage_remote_data_source.dart';
import 'package:mobile/features/homepage/data/repositories/HomePage_repository_impl.dart';
import 'package:mobile/features/homepage/domain/repositories/HomePage_repository.dart';
import 'package:mobile/features/homepage/presentation/bloc/homepage_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/features/manga_info_page/data/datasources/Manga_info_page_remote_data_source.dart';
import 'package:mobile/features/manga_info_page/domain/usecases/get_manga_full_info.dart';
import 'package:mobile/features/manga_reader/presentation/bloc/mangareader_bloc.dart';
import 'package:mobile/features/search/data/datasources/research_remote_datasource.dart';
import 'package:mobile/features/search/domain/repositories/research_repository.dart';
import 'package:mobile/features/search/domain/usecases/get_research_manga.dart';
import 'package:mobile/features/search/presentation/bloc/search_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network.dart';
import 'features/homepage/domain/usecases/get_homepage_scans.dart';
import 'features/homepage/domain/usecases/get_list_manga_per_sources.dart';
import 'features/manga_info_page/data/repositories/Manga_info_page_repository_impl.dart';
import 'features/manga_info_page/domain/repositories/HomePage_repository.dart';
import 'features/manga_info_page/presentation/bloc/mangainfo_bloc.dart';
import 'features/manga_reader/data/datasources/scan_manga_remote_datasource.dart';
import 'features/manga_reader/data/repositories/scan_manga_repository_impl.dart';
import 'features/manga_reader/domain/repositories/scan_manga_repository.dart';
import 'features/manga_reader/domain/usecases/get_manga_scan.dart';
import 'features/search/data/datasources/research_local_datasource.dart';
import 'features/search/data/repositories/research_repository_impl.dart';
import 'features/search/domain/usecases/delete_search_in_history.dart';
import 'features/search/domain/usecases/get_research_manga copy.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => HomepageBloc(getHomepageScans: sl()));
  sl.registerFactory(() => MangainfoBloc(getFullMangaInfo: sl()));
  sl.registerFactory(() => MangareaderBloc(getMangaScan: sl()));
  sl.registerFactory(() => SearchBloc(
      getResearchScans: sl(),
      deleteSearchInHistory: sl(),
      getResearchHistory: sl()));

  //usecase
  sl.registerLazySingleton(() => GetHomepageScans(sl()));
  sl.registerLazySingleton(() => GetListMangaPerSource(sl()));
  sl.registerLazySingleton(() => GetFullMangaInfo(sl()));
  sl.registerLazySingleton(() => GetMangaScan(sl()));
  sl.registerLazySingleton(() => GetResearchScans(sl()));
  sl.registerLazySingleton(() => DeleteSearchInHistory(sl()));
  sl.registerLazySingleton(() => GetResearchHistory(sl()));

  //repository
  sl.registerLazySingleton<HomePageRepository>(
      () => HomePageRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<MangaInfoPageRepository>(() =>
      MangaInfoPageRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ScanMangaRepository>(
      () => ScanMangaRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ResearchRepository>(() => ResearchRepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()));

  //Data Sources
  sl.registerLazySingleton<HomepageRemoteDataSource>(
      () => HomepageRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<MangaInfoPageRemoteDatasource>(
      () => MangaInfoPageRemoteDatasourceImpl(client: sl()));
  sl.registerLazySingleton<ScanMangaRemoteDatasource>(
      () => ScanMangaRemoteDatasourceImpl(client: sl()));
  sl.registerLazySingleton<ResearchRemoteDataSource>(
      () => ResearchRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ResearchLocalDataSource>(
      () => ResearchLocalDataSourceImpl(sharedPreferences: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
}
