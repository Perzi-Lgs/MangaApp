import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/component/appbar.dart';

import '../../../config/themes/theme_config.dart';
import '../../../dependency_injection.dart';
import '../../bloc/download_bloc/download_bloc.dart';
import 'download_page_manga_reader.dart';

class DownaloadedListChaptersPage extends StatelessWidget {
  const DownaloadedListChaptersPage({required this.mangaName});

  final String mangaName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DownloadBloc(
            downloadChapter: sl(),
            getDownloadedManga: sl(),
            getDownloadedMangaChapters: sl(),
            getDownloadedChapterData: sl())
          ..add(GetDownloadedChaptersList(name: mangaName)),
        child: Scaffold(
          body: DownaloadedListChaptersPageBody(mangaName: mangaName),
          appBar: MangaAppBar(),
        ));
  }
}

class DownaloadedListChaptersPageBody extends StatelessWidget {
  const DownaloadedListChaptersPageBody({required this.mangaName});

  final String mangaName;
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadBloc, DownloadState>(
      builder: (context, state) {
        if (state.status == DownloadStatus.loading)
          return Center(child: CircularProgressIndicator());
        else if (state.status == DownloadStatus.success) {
          return Container(
            color: CustomColors.darkGrey,
            child: ListView.builder(
                itemCount: state.downloadedChapterList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DownloadedMangaReader(
                                  chapter: state.downloadedChapterList[index],
                                  mangaName: mangaName,
                                ))),
                    child: Container(
                      height: 50,
                      child: Center(
                          child: Text(
                        '${state.downloadedChapterList[index]}',
                        style: TextStyle(color: CustomColors.white),
                        overflow: TextOverflow.ellipsis,
                      )),
                    ),
                  );
                }),
          );
        } else
          return Center(child: Text("Could not load downloaded mangas"));
      },
    );
  }
}
