import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases.dart';
import '../../entities/chapter.dart';
import '../../entities/manga_info.dart';
import '../../repositories/download_repository.dart';

class DownloadChapter extends UseCase<bool, DownloadChapterParams> {
  final DownloadRepository repository;

  DownloadChapter(this.repository);

  @override
  Future<Either<Failure, bool>> call(DownloadChapterParams? params) async {
    return await repository.downloadChapter(params!.info, params.chapter, params.statusCallback);
  }
}

class DownloadChapterParams extends Equatable {
  final MangaInfo info;
  final Chapter chapter;
  final void Function(int status, double progress) statusCallback;

  DownloadChapterParams({required this.chapter, required this.info, required this.statusCallback});

  @override
  List<Object?> get props => [info, chapter, statusCallback];
}
