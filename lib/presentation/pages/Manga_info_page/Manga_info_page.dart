import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/component/navbar/bloc/navbar_bloc.dart';

import '../../../../../dependency_injection.dart';
import '../../../domain/entities/MangaInfo.dart';
import '../../bloc/manga_info_bloc/mangainfo_bloc.dart';
import 'Manga_info_page_body.dart';

class MangaInfoPage extends StatelessWidget {
  const MangaInfoPage({Key? key, required this.info}) : super(key: key);

  final MangaInfo info;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(
      bloc: context.read<NavbarBloc>(),
      builder: (context, state) {
        print(state.index);
        return BlocProvider(
          create: (context) => MangainfoBloc(getFullMangaInfo: sl())
            ..add(FetchMangaInfo(url: info.url)),
          child: MangaInfoPageBody(info: info),
        );
      },
    );
  }
}
