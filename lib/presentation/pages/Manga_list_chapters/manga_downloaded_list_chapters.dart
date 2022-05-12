import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/component/appbar.dart';
import '../../../dependency_injection.dart';
import '../../../domain/entities/chapter.dart';
import '../../../domain/entities/manga_info.dart';
import '../../bloc/download_bloc/download_bloc.dart';
import '../../bloc/list_selector_cubit/list_selector_cubit.dart';
import 'manga_downloaded_list_chapters_body.dart';

class ListDownloadedChaptersPage extends StatelessWidget {
  const ListDownloadedChaptersPage(
      {Key? key, required this.info, required this.scansData})
      : super(key: key);

  final MangaInfo info;
  final List<Chapter> scansData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MangaAppBar(title: "Manga Rock"),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  DownloadBloc(downloadChapter: sl())..add(GetDownloadedChaptersList(url: info.url)),
            ),
            BlocProvider(
              create: (context) => ListSelectorCubit(scansData.length),
            )
          ],
          child:
              ListDownloadedChaptersPageBody(info: info, scansData: scansData),
        ));
    //
  }
}
