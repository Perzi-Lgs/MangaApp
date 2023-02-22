import 'package:dartz/dartz.dart';
import 'package:mobile/domain/entities/chapter.dart';
import '../../../../core/errors/failures.dart';
import '../entities/manga_info.dart';

abstract class DownloadRepository {
  Future<Either<Failure, bool>> downloadChapter(MangaInfo url, Chapter chapter, void Function(int status, double progress) statusCallback);
}
