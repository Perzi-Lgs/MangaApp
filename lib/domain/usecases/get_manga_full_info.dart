import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases.dart';
import '../entities/CompleteMangaInfo.dart';
import '../repositories/manga_info_repository.dart';

class GetFullMangaInfo extends UseCase<CompleteMangaInfo, Params> {
  final MangaInfoPageRepository repository;

  GetFullMangaInfo(this.repository);

  @override
  Future<Either<Failure, CompleteMangaInfo>> call(Params? params) async {
    return await repository.getFullMangaInfo(params!.url);
  }
}

class Params extends Equatable {
  final String url;

  Params({required this.url});

  @override
  List<Object?> get props => [url];
}
