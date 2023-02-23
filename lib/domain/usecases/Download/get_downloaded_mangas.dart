import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../../repositories/download_repository.dart';

class GetDownloadedManga extends UseCase<List<String>, NoParams> {
  final DownloadRepository repository;

  GetDownloadedManga(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams? params) async {
    return await repository.getDownloadedManga();
  }
}