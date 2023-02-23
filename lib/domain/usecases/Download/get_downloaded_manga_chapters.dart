import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../../repositories/download_repository.dart';

class GetDownloadedMangaChapters
    extends UseCase<List<String>, GetDownloadedMangaChaptersParams> {
  final DownloadRepository repository;

  GetDownloadedMangaChapters(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(
      GetDownloadedMangaChaptersParams? params) async {
    return await repository.getdownloadedMangaChapters(params!.name);
  }
}

class GetDownloadedMangaChaptersParams extends Equatable {
  final String name;

  GetDownloadedMangaChaptersParams({required this.name});

  @override
  List<Object?> get props => [name];
}
