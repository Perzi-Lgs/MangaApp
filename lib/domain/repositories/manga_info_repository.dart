import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/complete_manga_info.dart';

abstract class MangaInfoPageRepository {
  Future<Either<Failure, CompleteMangaInfo>> getFullMangaInfo(String url);
}
