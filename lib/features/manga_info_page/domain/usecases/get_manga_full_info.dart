import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/manga_info_page/domain/entities/CompleteMangaInfo.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../repositories/HomePage_repository.dart';

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
