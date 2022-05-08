import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../entities/manga_info.dart';
import '../repositories/homepage_repository.dart';

class GetListMangaPerSource extends UseCase<List<MangaInfo>, Params> {
  final HomePageRepository repository;

  GetListMangaPerSource(this.repository);

  @override
  Future<Either<Failure, List<MangaInfo>>> call(Params? params) async {
    return await repository.getListMangaPerSource(params!.sourceName);
  }
}

class Params extends Equatable {
  final String sourceName;

  Params({required this.sourceName});

  @override
  List<Object?> get props => [];
}
