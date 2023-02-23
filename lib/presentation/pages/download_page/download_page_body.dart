import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/download_bloc/download_bloc.dart';
import 'download_page_chapter_list.dart';

class MangaDownloadPageBody extends StatelessWidget {
  const MangaDownloadPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadBloc, DownloadState>(
      builder: (context, state) {
        if (state.status == DownloadStatus.loading)
          return Center(child: CircularProgressIndicator());
        else if (state.status == DownloadStatus.success) {
          return ListView.builder(
            itemCount: state.downloadedMangas.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: TextButton(
                  onPressed: () {
                    context.read<DownloadBloc>().add(GetDownloadedChaptersList(
                        name: state.downloadedMangas[index]));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DownaloadedListChaptersPage(
                                mangaName: state.downloadedMangas[index])));
                  },
                  child: Text(state.downloadedMangas[index],
                      style: Theme.of(context).textTheme.bodyText2),
                ),
              );
            },
          );
        } else
          return Center(child: Text("Could not load downloaded mangas"));
      },
    );
  }
}
