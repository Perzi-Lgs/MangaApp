import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/component/navbar/navbar_cubit/navbar_cubit.dart';
import 'package:mobile/presentation/bloc/download_bloc/download_bloc.dart';

import '../../../dependency_injection.dart';
import 'download_page_body.dart';

class MangaDownloadPage extends StatelessWidget {
  const MangaDownloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, int>(
      bloc: context.read<NavbarCubit>(),
      builder: (context, state) {
        return BlocProvider(
          create: (context) => DownloadBloc(
              downloadChapter: sl(),
              getDownloadedManga: sl(),
              getDownloadedMangaChapters: sl(),
              getDownloadedChapterData: sl())
            ..add(GetDownloadedMangaList()),
          child: MangaDownloadPageBody(),
        );
      },
    );
  }
}
