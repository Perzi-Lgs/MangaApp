import 'package:flutter/material.dart';

import '../../../domain/entities/manga_info.dart';
import '../../bloc/manga_info_bloc/manga_info_bloc.dart';
import '../../pages/Manga_list_chapters/Manga_list_chapters.dart';
import '../../pages/Manga_list_chapters/manga_downloaded_list_chapters.dart';

class MangaInfoListChapterButton extends StatelessWidget {
  const MangaInfoListChapterButton({
    Key? key,
    required this.state,
    required this.info,
  }) : super(key: key);

  final MangaInfoState state;
  final MangaInfo info;

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
                      child: IconButton(
                        icon: Icon(Icons.file_download_outlined),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ListDownloadedChaptersPage(info: info, scansData: state.info.scans))),
                      ),
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
