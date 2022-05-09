import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/domain/entities/scan_image.dart';

abstract class ScanMangaRepository {
  Future<Either<Failure, List<ScanImage>>> getMangaScan(String url);
}