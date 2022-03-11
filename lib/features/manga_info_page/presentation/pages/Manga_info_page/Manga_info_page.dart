import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/component/appbar.dart';
import 'package:mobile/core/component/navbar/bloc/navbar_bloc.dart';
import 'package:mobile/core/component/navbar/navbar.dart';
import 'package:mobile/features/homepage/domain/entities/MangaInfo.dart';
import 'package:mobile/features/manga_info_page/presentation/pages/Manga_info_page/Manga_info_page_body.dart';

import '../../../../../dependency_injection.dart';
import '../../bloc/mangainfo_bloc.dart';

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
