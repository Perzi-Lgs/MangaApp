import 'package:mobile/constants/error_message_constant.dart';
import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/core/network.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile/features/manga_info_page/domain/entities/CompleteMangaInfo.dart';

import '../../domain/repositories/HomePage_repository.dart';
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
