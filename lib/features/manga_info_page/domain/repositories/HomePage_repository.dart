import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/CompleteMangaInfo.dart';

abstract class MangaInfoPageRepository {
  Future<Either<Failure, CompleteMangaInfo>> getFullMangaInfo(String url);
}
