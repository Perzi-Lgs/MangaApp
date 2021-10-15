import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../entities/MangaInfo.dart';
import '../repositories/HomePage_repository.dart';

class GetListScanPerSource extends UseCase<List<MangaInfo>, NoParams> {
  final HomePageRepository repository;

  GetListScanPerSource(this.repository);

  @override
  Future<Either<Failure, List<MangaInfo>>> call(NoParams? params) async {
    return await repository.getListScanPerSource();
  }
}

class Params extends Equatable {
  final String sourceName;

  Params({required this.sourceName});

  @override
  List<Object?> get props => [];
}
