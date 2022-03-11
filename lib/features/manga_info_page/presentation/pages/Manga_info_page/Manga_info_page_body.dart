import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/config/themes/theme_config.dart';
import 'package:mobile/features/manga_info_page/presentation/widgets/genres%20_button_list.dart';
import 'package:mobile/features/manga_info_page/presentation/widgets/genres_button.dart';
import 'package:mobile/features/manga_info_page/presentation/widgets/logo_button.dart';

import '../../../../homepage/domain/entities/MangaInfo.dart';
import '../../bloc/mangainfo_bloc.dart';

class MangaInfoPageBody extends StatelessWidget {
  const MangaInfoPageBody({
    Key? key,
    required this.info,
  }) : super(key: key);

  final MangaInfo info;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MangainfoBloc, MangainfoState>(
      builder: (context, state) {
        if (state.status == MangainfoStateStatus.success)
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 1,
            minChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                color: CustomColors.darkGrey,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Image.network(
                        state.info.img,
                        headers: {'Referer': 'https://readmanganato.com/'},
                        fit: BoxFit.cover,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          state.info.name,
                          style: TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          state.info.author + ' · ' + state.info.status,
                          style: TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            LogoButton(
                                title: 'Reprendre',
                                icon: Icons.play_arrow_outlined),
                            VerticalDivider(
                              width: 10,
                              thickness: 1,
                              color: CustomColors.lightGrey,
                            ),
                            LogoButton(
                                title: state.info.scans.length.toString() +
                                    ' Chapitres',
                                icon: Icons.list),
                            VerticalDivider(
                              width: 20,
                              thickness: 1,
                              color: CustomColors.lightGrey,
                            ),
                            LogoButton(
                                title: 'Ajoute aux favoris',
                                icon: Icons.favorite),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        height: 60,
                        thickness: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Chapitres',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child:
                                            Icon(Icons.file_download_outlined),
                                      ),
                                      Icon(Icons.more_horiz)
                                    ],
                                  )
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                    'Voir les ${state.info.scans.length} chapitres'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        height: 60,
                        thickness: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sommaire',
                                style: Theme.of(context).textTheme.headline2),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text(
                                state.info.description,
                                style: TextStyle(color: CustomColors.lightGrey),
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GenreButtonlist(genres: state.info.genre)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        else
          return Container();
      },
    );
  }
}
