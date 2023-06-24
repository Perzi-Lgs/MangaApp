import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../repositories/bookmark_repository.dart';

class SetLastRead extends UseCase<bool, SetLastReadParams> {
  final BookmarkRepository repository;

  SetLastRead(this.repository);

  @override
  Future<Either<Failure, bool>> call(SetLastReadParams? params) async {
    return await repository.setLastRead(params!.lastChapterRead, params.mangaName);
  }
}

class SetLastReadParams extends Equatable {
  final String lastChapterRead;
  final String mangaName;

  SetLastReadParams({required this.lastChapterRead, required this.mangaName});

  @override
  List<Object?> get props => [lastChapterRead, mangaName];
}

class GetLastRead extends UseCase<String, GetReadParams> {
  final BookmarkRepository repository;

  GetLastRead(this.repository);

  @override
  Future<Either<Failure, String>> call(GetReadParams? params) async {
    return await repository.getLastRead(params!.mangaName);
  }
}

class GetAllRead extends UseCase<List<String>, GetReadParams> {
  final BookmarkRepository repository;

  GetAllRead(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(GetReadParams? params) async {
    return await repository.getAllRead(params!.mangaName);
  }
}


class GetReadParams extends Equatable {
  final String mangaName;

  GetReadParams({required this.mangaName});

  @override
  List<Object?> get props => [mangaName];
}