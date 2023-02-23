import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../dependency_injection.dart';
import '../../bloc/download_bloc/download_bloc.dart';

class DownloadedMangaReader extends StatelessWidget {
  const DownloadedMangaReader({
    required this.chapter,
    required this.mangaName,
    Key? key,
  }) : super(key: key);

  final String chapter;
  final String mangaName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DownloadBloc(
            downloadChapter: sl(),
            getDownloadedManga: sl(),
            getDownloadedMangaChapters: sl(),
            getDownloadedChapterData: sl())
          ..add(GetDownloadedChaptersData(chapter: chapter, mangaName: mangaName)),
        child: DownloadedMangaReaderBody());
  }
}

class DownloadedMangaReaderBody extends StatelessWidget {
  const DownloadedMangaReaderBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadBloc, DownloadState>(
      builder: (context, state) {
        if (state.status == DownloadStatus.success) {
          return Center(
            child: PhotoViewGallery.builder(
              itemCount: state.chapterDataList.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider:
                      Image.memory(state.chapterDataList[index]).image,
                  // Contained = the smallest possible size to fit one dimension of the screen
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  // Covered = the smallest possible size to fit the whole screen
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
              scrollPhysics: BouncingScrollPhysics(),
              // Set the background color to the "classic white"
              backgroundDecoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
              ),
              // loadingChild: Center(
              //   child: CircularProgressIndicator(),
              // ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
