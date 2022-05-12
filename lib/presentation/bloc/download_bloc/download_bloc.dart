import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/domain/entities/manga_info.dart';

import '../../../domain/entities/chapter.dart';
import '../../../domain/usecases/Download/download_chapter.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final DownloadChapter downloadChapter;

  DownloadBloc({required this.downloadChapter}) : super(DownloadState()) {
    on<GetDownloadedMangaInfos>(_onGetDownloadedMangaInfos);
    on<GetDownloadedChaptersList>(_onGetDownloadedChaptersList);
    on<LaunchChaptersDownload>(_onLaunchChaptersDownload);
  }

  void _onGetDownloadedMangaInfos(
      GetDownloadedMangaInfos event, Emitter<DownloadState> emit) async {}

  void _onGetDownloadedChaptersList(
      GetDownloadedChaptersList event, Emitter<DownloadState> emit) async {}

  void _onLaunchChaptersDownload(
      LaunchChaptersDownload event, Emitter<DownloadState> emit) async {
    emit(state.copyWith(status: DownloadStatus.loading));
    try {
      for (var i in event.chapters) {
        final res = await downloadChapter(
            DownloadChapterParams(chapter: i, info: event.info));
        res.fold((l) => emit(state.copyWith(status: DownloadStatus.error)),
            (r) => emit(state.copyWith(status: DownloadStatus.success)));
      }
    } catch (e) {
      emit(state.copyWith(status: DownloadStatus.error));
    }
  }
}
