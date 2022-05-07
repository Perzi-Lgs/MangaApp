import 'package:mobile/features/homepage/domain/entities/MangaInfo.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile/features/search/domain/repositories/research_repository.dart';

import '../../../../constants/error_message_constant.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/network.dart';
import '../datasources/research_local_datasource.dart';
import '../datasources/research_remote_datasource.dart';

class ResearchRepositoryImpl implements ResearchRepository {
  final ResearchRemoteDataSource remoteDataSource;
  final ResearchLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ResearchRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  // TODO impl avec cache
  @override
  Future<Either<Failure, List<MangaInfo>>> getResearchScans(
      String query, int page) async {
    if (await networkInfo.isConnected) {
      try {
        final mangaList = await remoteDataSource.getResearchScans(query, page);

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
