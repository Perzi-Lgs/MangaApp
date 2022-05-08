import 'package:flutter/material.dart';

import '../../bloc/manga_info_bloc/manga_info_bloc.dart';
import '../../pages/Manga_list_chapters/manga_list_chapters.dart';


class MangaInfoListChapterButton extends StatelessWidget {
  const MangaInfoListChapterButton({
    Key? key,
    required this.state,
  }) : super(key: key);

  final MangaInfoState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Chapitres', style: Theme.of(context).textTheme.headline2),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.file_download_outlined),
                    ),
                    Icon(Icons.more_horiz)
                  ],
                )
              ],
            ),
            TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ListChaptersPage(info: state.info))),
              child: Text('Voir les ${state.info.scans.length} chapitres'),
            ),
          ],
        ),
      ),
    );
  }
}
