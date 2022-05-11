import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/component/navbar/navbar_cubit/navbar_cubit.dart';

import '../../../../../dependency_injection.dart';
import '../../../domain/entities/manga_info.dart';
import '../../bloc/manga_info_bloc/manga_info_bloc.dart';
import 'Manga_info_page_body.dart';

class MangaInfoPage extends StatelessWidget {
  const MangaInfoPage({Key? key, required this.info}) : super(key: key);

  final MangaInfo info;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, int>(
      bloc: context.read<NavbarCubit>(),
      builder: (context, state) {
        return BlocProvider(
          create: (context) => MangaInfoBloc(getFullMangaInfo: sl())
            ..add(FetchMangaInfo(url: info.url)),
          child: MangaInfoPageBody(info: info),
        );
      },
    );
  }
}
