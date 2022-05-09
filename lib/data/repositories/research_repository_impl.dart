import 'package:mobile/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile/domain/repositories/search_repository.dart';

import '../../constants/error_message_constant.dart';
import '../../core/errors/exception.dart';
import '../../core/network.dart';
import '../../domain/entities/manga_info.dart';
import '../data_sources/search_data_sources/search_local_datasource.dart';
import '../data_sources/search_data_sources/search_remote_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  final SearchLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  // TODO impl avec cache
  @override
  Future<Either<Failure, List<MangaInfo>>> getSearchScans(
      String query, int page) async {
    if (await networkInfo.isConnected) {
      try {
        final mangaList = await remoteDataSource.getSearchScans(query, page);

        List<String> history = await localDataSource.getSearchHistory();
        history.remove(query);
        history.insert(0, query);
        await localDataSource.saveSearchHistory(history);

        return Right(mangaList);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    } else {
      return Left(ServerFailure(timeoutServerError));
    }
  }

  @override
  Future<Either<Failure, List<String>>> deleteSearchInHistory(
      String query) async {
    try {
      return Right(await localDataSource.deleteSearchInHistory(query));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getSearchHistory() async {
    try {
      return Right(await localDataSource.getSearchHistory());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
