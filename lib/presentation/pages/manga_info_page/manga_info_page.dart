import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/presentation/bloc/favorite_cubit/favorite_cubit.dart';

import '../../../../../dependency_injection.dart';
import '../../../domain/entities/manga_info.dart';
import '../../bloc/manga_info_bloc/manga_info_bloc.dart';
import 'manga_info_page_body.dart';

class MangaInfoPage extends StatelessWidget {
  const MangaInfoPage({Key? key, required this.info}) : super(key: key);

  final MangaInfo info;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: info.img,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MangaInfoBloc(getFullMangaInfo: sl())
              ..add(FetchMangaInfo(url: info.url)),
          ),
          BlocProvider(
            create: (context) => FavoriteCubit(
                getAllFavoriteUsecase: sl(),
                getIsFavoriteUsecase: sl(),
                switchFavoriteUsecase: sl()),
          ),
        ],
        child: MangaInfoPageBody(info: info),
      ),
    );
  }
}
