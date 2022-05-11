import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/domain/entities/manga_info.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  DownloadBloc() : super(DownloadState()) {
    on<GetDownloadedMangaInfos>( _onGetDownloadedMangaInfos);
    on<GetDownloadedChaptersList>( _onGetDownloadedChaptersList);
  }

  void _onGetDownloadedMangaInfos(GetDownloadedMangaInfos event, Emitter<DownloadState> emit) async {
  }

  void _onGetDownloadedChaptersList(GetDownloadedChaptersList event, Emitter<DownloadState> emit) async {
  }
}
