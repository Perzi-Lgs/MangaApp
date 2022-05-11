import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/domain/entities/Chapter.dart';

import '../../../domain/entities/manga_info.dart';
import '../../bloc/download_bloc/download_bloc.dart';
import 'manga_downloaded_list_chapters_body.dart';

class ListDownloadedChaptersPage extends StatelessWidget {
  const ListDownloadedChaptersPage({Key? key, required this.info, required this.scansData})
      : super(key: key);

  final MangaInfo info;
  final List<Chapter> scansData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DownloadBloc()..add(GetDownloadedChaptersList(url: info.url)),
      child: ListDownloadedChaptersPageBody(info: info),
    );
  }
}
