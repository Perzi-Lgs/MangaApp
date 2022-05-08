import 'package:dartz/dartz.dart';
import 'package:mobile/domain/entities/scan_image.dart';

import '../../constants/error_message_constant.dart';
import '../../core/errors/exception.dart';
import '../../core/errors/failures.dart';
import '../../core/network.dart';
import '../../domain/repositories/scan_manga_repository.dart';
import '../data_sources/scan_manga_remote_datasource.dart';

class ScanMangaRepositoryImpl implements ScanMangaRepository {
  final ScanMangaRemoteDatasource remoteDataSource;
  final NetworkInfo networkInfo;

  const ScanMangaRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<ScanImage>>> getMangaScan(
      String url) async {
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
