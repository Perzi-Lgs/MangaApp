import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../manga_info_page/domain/entities/CompleteMangaInfo.dart';
import '../bloc/mangareader_bloc.dart';
import '../widgets/manga_reader_widget.dart';
import '../widgets/webtoon_reader_widget.dart';

class MangaReaderBody extends StatelessWidget {
  const MangaReaderBody({required this.info, required this.index, Key? key})
      : super(key: key);

  final CompleteMangaInfo info;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MangareaderBloc, MangareaderState>(
      builder: (context, state) {
        if (state.status == MangareaderStateStatus.success) {
          if (info.genre.contains('Webtoons')) {
            return WebtoonsReader(images: state.images);
          } else
            return MangaReader(images: state.images);
        } else {
          return Container();
        }
      },
    );
  }
}
