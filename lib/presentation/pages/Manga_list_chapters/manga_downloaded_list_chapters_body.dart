import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/domain/entities/manga_info.dart';

import '../../bloc/download_bloc/download_bloc.dart';

class ListDownloadedChaptersPageBody extends StatelessWidget {
  const ListDownloadedChaptersPageBody({Key? key, required this.info})
      : super(key: key);

  final MangaInfo info;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadBloc, DownloadState>(
      builder: (context, state) {
        if (state.status == DownloadStatus.success)
          return Container();
        else if (state.status == DownloadStatus.loading)
          return Center(child: CircularProgressIndicator());
        else
          return Text('An error happened... sad...',
              style: TextStyle(color: Colors.red));
      },
    );
  }
}
