import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/errors/failures.dart';
import '../../core/usecases.dart';
import '../entities/ScanImage.dart';
import '../repositories/scan_manga_repository.dart';

class GetMangaScan extends UseCase<List<ScanImage>, Params> {
  final ScanMangaRepository repository;

  GetMangaScan(this.repository);

  @override
  Future<Either<Failure, List<ScanImage>>> call(Params? params) async {
    return await repository.getMangaScan(params!.url);
  }
}

class Params extends Equatable {
  final String url;

  Params({required this.url});

  @override
  List<Object?> get props => [url];
}
