import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/config/themes/theme_config.dart';

import '../../../domain/entities/manga_info.dart';
import '../../bloc/manga_info_bloc/manga_info_bloc.dart';
import '../../widgets/manga_info/manga_info_divider.dart';
import '../../widgets/manga_info/manga_info_list_chapter_button.dart';
import '../../widgets/manga_info/manga_info_page_selector.dart';
import '../../widgets/manga_info/manga_info_summary.dart';

class MangaInfoPageBody extends StatelessWidget {
  const MangaInfoPageBody({
    Key? key,
    required this.info,
  }) : super(key: key);

  final MangaInfo info;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<MangaInfoBloc, MangaInfoState>(
        builder: (context, state) {
          if (state.status == MangaInfoStateStatus.success)
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 1,
              minChildSize: 0.8,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  color: CustomColors.darkGrey,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: MangaInfoPageData(
                      state: state,
                      info: info,
                    ),
                  ),
                );
              },
            );
          else
            return Container(
              color: CustomColors.darkGrey,
            );
        },
      ),
    );
  }
}

class MangaInfoPageData extends StatelessWidget {
  const MangaInfoPageData({
    required this.state,
    required this.info,
    Key? key,
  }) : super(key: key);

  final MangaInfoState state;
  final MangaInfo info;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Image.network(
            state.info.img,
            headers: {'Referer': 'https://readmanganato.com/'},
            fit: BoxFit.scaleDown,
          ),
        ),
        // Manga name
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            state.info.name,
            style: TextStyle(color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // Manga author name + status
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            state.info.author.label + ' · ' + state.info.status,
            style: TextStyle(color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        MangaInfoPageSelector(state: state),
        MangaInfoDivider(),
        MangaInfoListChapterButton(state: state, info: info),
        MangaInfoDivider(),
        SummaryMangaInfo(state: state)
      ],
    );
  }
}
