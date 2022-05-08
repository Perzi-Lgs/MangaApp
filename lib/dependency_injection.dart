import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/data/datasources/Manga_info_page_remote_data_source.dart';
import 'package:mobile/domain/usecases/get_manga_full_info.dart';
import 'package:mobile/domain/repositories/research_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network.dart';
import 'data/datasources/Homepage_remote_data_source.dart';
import 'data/datasources/search_datasources/research_local_datasource.dart';
import 'data/datasources/search_datasources/research_remote_datasource.dart';
import 'data/repositories/HomePage_repository_impl.dart';
import 'data/repositories/Manga_info_page_repository_impl.dart';
import 'domain/repositories/HomePage_repository.dart';
import 'domain/repositories/manga_info_repository.dart';
import 'data/datasources/scan_manga_remote_datasource.dart';
import 'data/repositories/scan_manga_repository_impl.dart';
import 'domain/repositories/scan_manga_repository.dart';
import 'domain/usecases/delete_search_in_history.dart';
import 'domain/usecases/get_homepage_scans.dart';
import 'domain/usecases/get_list_manga_per_sources.dart';
import 'domain/usecases/get_manga_scan.dart';
import 'data/repositories/research_repository_impl.dart';
import 'domain/usecases/get_research_manga copy.dart';
import 'domain/usecases/get_research_manga.dart';
import 'presentation/bloc/homepage_bloc/homepage_bloc.dart';
import 'presentation/bloc/manga_info_bloc/mangainfo_bloc.dart';
import 'presentation/bloc/manga_reader_bloc/mangareader_bloc.dart';
import 'presentation/bloc/search_bloc/search_bloc.dart';

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
