import '../../constants/error_message_constant.dart';
import '../../core/errors/exception.dart';
import '../../core/network.dart';
import '../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/CompleteMangaInfo.dart';
import '../../domain/repositories/manga_info_repository.dart';
import '../datasources/Manga_info_page_remote_data_source.dart';

class MangaInfoPageRepositoryImpl implements MangaInfoPageRepository {
  final MangaInfoPageRemoteDatasource remoteDataSource;
  final NetworkInfo networkInfo;

  const MangaInfoPageRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, CompleteMangaInfo>> getFullMangaInfo(String url) async {
    if (await networkInfo.isConnected) {
      try {
        final completeMangaInfo = await remoteDataSource.getMangaInfoPage(url);
        return Right(completeMangaInfo);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure(timeoutServerError));
    }
  }

}
