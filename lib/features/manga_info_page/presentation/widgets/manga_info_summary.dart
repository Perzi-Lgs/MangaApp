import 'package:flutter/material.dart';

import '../../../../config/themes/theme_config.dart';
import '../bloc/mangainfo_bloc.dart';
import 'genres _button_list.dart';

class SummaryMangaInfo extends StatelessWidget {
  const SummaryMangaInfo({
    Key? key,
    required this.state,
  }) : super(key: key);

  final MangainfoState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sommaire', style: Theme.of(context).textTheme.headline2),
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
    );
  }
}
