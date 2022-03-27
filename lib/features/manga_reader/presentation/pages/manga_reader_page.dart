import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/component/appbar.dart';
import 'package:mobile/features/manga_info_page/domain/entities/CompleteMangaInfo.dart';

import '../../../../dependency_injection.dart';
import '../bloc/mangareader_bloc.dart';
import 'manga_reader_page_body.dart';

class MangaReader extends StatelessWidget {
  const MangaReader({required this.info, required this.index, Key? key})
      : super(key: key);

  final CompleteMangaInfo info;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MangareaderBloc(getMangaScan: sl())
        ..add(GetScans(url: info.scans[index].url)),
      child: Scaffold(
        appBar: MangaAppBar(title: info.scans[index].name),
        body: MangaReaderBody(info: info, index: index),
      ),
    );
  }
}
