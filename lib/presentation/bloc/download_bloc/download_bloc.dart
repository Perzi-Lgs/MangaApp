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

    void downloadStatusCallback(int status, double progress) async {
      if (status == 1) {
        emit(
            state.copyWith(status: DownloadStatus.success));
      }
    }
    
    try {
      for (var i in event.chapters) {
      emit(
            state.copyWith(status: DownloadStatus.loading));
        await downloadChapter(
            DownloadChapterParams(chapter: i, info: event.info, statusCallback: downloadStatusCallback));
      }
      while (state.status != DownloadStatus.success) {
        await Future.delayed(const Duration(milliseconds: 300));
      }
      emit(state.copyWith(status: DownloadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: DownloadStatus.error));
    }
  }
}


// callback(id, progress) {
//  emit([id] = progress)
// }