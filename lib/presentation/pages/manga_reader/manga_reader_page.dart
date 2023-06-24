import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/presentation/bloc/bookmark_cubit/bookmark_cubit.dart';
import '../../../core/component/appbar.dart';

import '../../../../dependency_injection.dart';
import '../../../domain/entities/complete_manga_info.dart';
import '../../bloc/manga_reader_bloc/mangareader_bloc.dart';
import 'manga_reader_page_body.dart';

class MangaReader extends StatelessWidget {
  const MangaReader({required this.info, required this.index, Key? key})
      : super(key: key);

  final CompleteMangaInfo info;
  final int index;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MangareaderBloc(getMangaScan: sl())
            ..add(GetScans(url: info.scans[index].url, index: index)),
        ),
        BlocProvider(
          create: (context) => BookmarkCubit(
              getAllReadUsecase: sl(),
              getLastReadUsecase: sl(),
              setLastReadUsecase: sl()),
        ),
      ],
      child: Scaffold(
        body: MangaReaderBody(info: info, index: index),
      ),
    );
  }
}
