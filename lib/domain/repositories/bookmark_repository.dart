import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';

abstract class BookmarkRepository {
  Future<Either<Failure, bool>> setLastRead(String lastChapterRead, String mangaName);
  Future<Either<Failure, String>> getLastRead(String mangaName);
  Future<Either<Failure, List<String>>> getAllRead(String mangaName);
}