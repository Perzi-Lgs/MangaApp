import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/config/themes/dark_theme.dart';
import 'package:mobile/config/themes/theme_config.dart';
import 'package:mobile/domain/entities/chapter.dart';
import 'package:mobile/domain/entities/manga_info.dart';

import '../../bloc/download_bloc/download_bloc.dart';
import '../../bloc/list_selector_cubit/list_selector_cubit.dart';

class ListDownloadedChaptersPageBody extends StatelessWidget {
  const ListDownloadedChaptersPageBody(
      {Key? key, required this.info, required this.scansData})
      : super(key: key);

  final MangaInfo info;
  final List<Chapter> scansData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadBloc, DownloadState>(
      builder: (context, state) {
        // if (state.status == DownloadStatus.success)
        return ListDownloadedChaptersPageBodyWidget(
            info: info, scansData: scansData);
        // else if (state.status == DownloadStatus.loading)
        //   return Center(child: CircularProgressIndicator());
        // else
        //   return Text('An error happened... sad...',
        //       style: TextStyle(color: Colors.red));
      },
    );
  }
}

class ListDownloadedChaptersPageBodyWidget extends StatelessWidget {
  final MangaInfo info;
  final List<Chapter> scansData;

  const ListDownloadedChaptersPageBodyWidget(
      {Key? key, required this.scansData, required this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListSelectorCubit, ListSelectorCubitState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${scansData.length} chapitres',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () =>
                          context.read<ListSelectorCubit>().selectAll(),
                      child: Text(
                        'TOUT SELECTIONNER',
                        style: TextStyle(color: CustomColors.mainBlue),
                      ))
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView.builder(
                  itemCount: scansData.length,
                  itemBuilder: (BuildContext context, int index) => ListTile(
                        title: Text(scansData[index].name,
                            style: Theme.of(context).textTheme.headline3),
                        leading: Icon(
                            state.list[index]
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: state.list[index]
                                ? CustomColors.mainBlue
                                : Colors.white),
                        onTap: () =>
                            context.read<ListSelectorCubit>().select(index),
                      )),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: CustomColors.darkGrey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                          flex: 20,
                          child:
                              Image.network(info.img, fit: BoxFit.scaleDown)),
                      Flexible(
                        flex: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Telecharger ${state.list.where((element) => element).length} chapitres de',
                                style: TextStyle(fontSize: 13)),
                            Text(
                              info.name,
                              style: darkTheme.textTheme.headline2,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 40,
                        child: TextButton(
                            onPressed: state.list.contains(true)
                                ? () => context.read<DownloadBloc>().add(
                                    LaunchChaptersDownload(
                                        info: info,
                                        chapters: _getDownloadList(state.list)))
                                : null,
                            child: Text('DOWNLOAD')),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  List<Chapter> _getDownloadList(List<bool> list) {
    List<Chapter> res = [];
    for (var i = 0; i < list.length; i++) {
      if (list[i]) {
        res.add(scansData[i]);
      }
    }
    return res;
  }
}
