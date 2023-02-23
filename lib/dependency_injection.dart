import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/data/data_sources/manga_info_page_remote_data_source.dart';
import 'package:mobile/domain/repositories/download_repository.dart';
import 'package:mobile/domain/usecases/Download/download_chapter.dart';
import 'package:mobile/domain/usecases/Download/get_downloaded_manga_chapters.dart';
import 'package:mobile/domain/usecases/get_manga_full_info.dart';
import 'package:mobile/domain/repositories/search_repository.dart';
import 'package:mobile/presentation/bloc/download_bloc/download_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network.dart';
import 'data/data_sources/download_data_sources/download_data_source.dart';
import 'data/data_sources/homepage_remote_data_source.dart';
import 'data/data_sources/search_data_sources/search_local_datasource.dart';
import 'data/data_sources/search_data_sources/search_remote_datasource.dart';
import 'data/repositories/download_repository_impl.dart';
import 'data/repositories/homepage_repository_impl.dart';
import 'data/repositories/manga_info_page_repository_impl.dart';
import 'domain/repositories/homepage_repository.dart';
import 'domain/repositories/manga_info_repository.dart';
import 'data/data_sources/scan_manga_remote_datasource.dart';
import 'data/repositories/scan_manga_repository_impl.dart';
import 'domain/repositories/scan_manga_repository.dart';
import 'domain/usecases/Download/get_downloaded_chapter_data.dart';
import 'domain/usecases/Download/get_downloaded_mangas.dart';
import 'domain/usecases/delete_search_in_history.dart';
import 'domain/usecases/get_homepage_scans.dart';
import 'domain/usecases/get_list_manga_per_sources.dart';
import 'domain/usecases/get_manga_scan.dart';
import 'data/repositories/research_repository_impl.dart';
import 'domain/usecases/get_search_manga.dart';
import 'domain/usecases/get_search_manga_history.dart';
import 'presentation/bloc/homepage_bloc/homepage_bloc.dart';
import 'presentation/bloc/manga_info_bloc/manga_info_bloc.dart';
import 'presentation/bloc/manga_reader_bloc/mangareader_bloc.dart';
import 'presentation/bloc/search_bloc/search_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => HomepageBloc(getHomepageScans: sl()));
  sl.registerFactory(() => MangaInfoBloc(getFullMangaInfo: sl()));
  sl.registerFactory(() => MangareaderBloc(getMangaScan: sl()));
  sl.registerFactory(() => DownloadBloc(
      downloadChapter: sl(),
      getDownloadedManga: sl(),
      getDownloadedMangaChapters: sl(),
      getDownloadedChapterData: sl()));
  sl.registerFactory(() => SearchBloc(
      getResearchScans: sl(),
      deleteSearchInHistory: sl(),
      getResearchHistory: sl()));

  //usecase
  sl.registerLazySingleton(() => GetHomepageScans(sl()));
  sl.registerLazySingleton(() => GetListMangaPerSource(sl()));
  sl.registerLazySingleton(() => GetFullMangaInfo(sl()));
  sl.registerLazySingleton(() => GetMangaScan(sl()));
  sl.registerLazySingleton(() => GetSearchScans(sl()));
  sl.registerLazySingleton(() => DeleteSearchInHistory(sl()));
  sl.registerLazySingleton(() => GetSearchHistory(sl()));
  sl.registerLazySingleton(() => DownloadChapter(sl()));
  sl.registerLazySingleton(() => GetDownloadedManga(sl()));
  sl.registerLazySingleton(() => GetDownloadedMangaChapters(sl()));
  sl.registerLazySingleton(() => GetDownloadedChapterData(sl()));

  //repository
  sl.registerLazySingleton<HomepageRepository>(
      () => HomePageRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<MangaInfoPageRepository>(() =>
      MangaInfoPageRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ScanMangaRepository>(
      () => ScanMangaRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()));
  sl.registerLazySingleton<DownloadRepository>(() => DownloadRepositoryImpl(
      downloadLocalDataSource: sl(),
      networkInfo: sl(),
      scanMangaRemoteDatasource: sl()));

  //Data Sources
  sl.registerLazySingleton<DownloadDataSource>(
      () => DownloadDataSourceImpl(sharedPreferences: sl(), client: sl()));
  sl.registerLazySingleton<HomepageRemoteDataSource>(
      () => HomepageRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<MangaInfoPageRemoteDatasource>(
      () => MangaInfoPageRemoteDatasourceImpl(client: sl()));
  sl.registerLazySingleton<ScanMangaRemoteDatasource>(
      () => ScanMangaRemoteDatasourceImpl(client: sl()));
  sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<SearchLocalDataSource>(
      () => SearchLocalDataSourceImpl(sharedPreferences: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
}
