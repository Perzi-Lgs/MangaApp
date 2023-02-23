import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/usecases.dart';
import 'package:mobile/domain/entities/manga_info.dart';

import '../../../domain/entities/chapter.dart';
import '../../../domain/usecases/Download/download_chapter.dart';
import '../../../domain/usecases/Download/get_downloaded_chapter_data.dart';
import '../../../domain/usecases/Download/get_downloaded_manga_chapters.dart';
import '../../../domain/usecases/Download/get_downloaded_mangas.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final DownloadChapter downloadChapter;
  final GetDownloadedManga getDownloadedManga;
  final GetDownloadedMangaChapters getDownloadedMangaChapters;
  final GetDownloadedChapterData getDownloadedChapterData;

  DownloadBloc(
      {required this.downloadChapter,
      required this.getDownloadedManga,
      required this.getDownloadedMangaChapters,
      required this.getDownloadedChapterData})
      : super(DownloadState()) {
    on<GetDownloadedMangaList>(_onGetDownloadedMangaInfos);
    on<GetDownloadedChaptersList>(_onGetDownloadedChaptersList);
    on<LaunchChaptersDownload>(_onLaunchChaptersDownload);
    on<GetDownloadedChaptersData>(_onGetDownloadedChaptersData);
  }

  void _onGetDownloadedMangaInfos(
      GetDownloadedMangaList event, Emitter<DownloadState> emit) async {
    emit(state.copyWith(status: DownloadStatus.loading));

    try {
      final mangas = await getDownloadedManga(NoParams());

      mangas.fold(
          (l) => emit(state.copyWith(status: DownloadStatus.error)),
          (r) => emit(state.copyWith(
              status: DownloadStatus.success, downloadedMangas: r)));
    } catch (e) {
      emit(state.copyWith(status: DownloadStatus.error));
    }
  }

  void _onGetDownloadedChaptersList(
      GetDownloadedChaptersList event, Emitter<DownloadState> emit) async {
    emit(state.copyWith(status: DownloadStatus.loading));

    try {
      final mangas = await getDownloadedMangaChapters(
          GetDownloadedMangaChaptersParams(name: event.name));

      mangas.fold(
          (l) => emit(state.copyWith(status: DownloadStatus.error)),
          (r) => emit(state.copyWith(
              status: DownloadStatus.success, downloadedChapterList: r)));
    } catch (e) {
      emit(state.copyWith(status: DownloadStatus.error));
    }
  }

  void _onLaunchChaptersDownload(
      LaunchChaptersDownload event, Emitter<DownloadState> emit) async {
    void downloadStatusCallback(int status, double progress) async {
      if (status == 1) {
        emit(state.copyWith(status: DownloadStatus.success));
      }
    }

    try {
      for (var i in event.chapters) {
        emit(state.copyWith(status: DownloadStatus.loading));
        await downloadChapter(DownloadChapterParams(
            chapter: i,
            info: event.info,
            statusCallback: downloadStatusCallback));
      }
      while (state.status != DownloadStatus.success) {
        await Future.delayed(const Duration(milliseconds: 300));
      }
      emit(state.copyWith(status: DownloadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: DownloadStatus.error));
    }
  }

  _onGetDownloadedChaptersData(
      GetDownloadedChaptersData event, Emitter<DownloadState> emit) async {
    emit(state.copyWith(status: DownloadStatus.loading));

    try {
      final chapter = await getDownloadedChapterData(
          GetDownloadedChapterDataParams(chapter: event.chapter, mangaName: event.mangaName));

      chapter.fold(
          (l) => emit(state.copyWith(status: DownloadStatus.error)),
          (r) => emit(state.copyWith(
              status: DownloadStatus.success, chapterDataList: r)));
    } catch (e) {
      emit(state.copyWith(status: DownloadStatus.error));
    }
  }
}
