import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadany/loadany_widget.dart';
import 'package:mobile/features/homepage/presentation/bloc/homepage_bloc.dart';

import '../../../manga_info_page/presentation/pages/Manga_info_page/Manga_info_page.dart';
import '../../domain/entities/MangaInfo.dart';
import 'manga_grid_data.dart';

class MangaGridView extends StatelessWidget {
  const MangaGridView(
      {Key? key,
      required this.mangaData,
      this.columnNumber = 3,
      required this.status})
      : super(key: key);

  final List<MangaInfo> mangaData;
  final int columnNumber;
  final HomepageStatus status;

  @override
  Widget build(BuildContext context) {
    List<Tab> homepageTabs = [];
    HomepageTab.values.forEach((element) {
      homepageTabs.add(Tab(
        text: element.name,
      ));
    });
    final size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return DefaultTabController(
        length: homepageTabs.length,
        child: Column(
          children: [
            TabBar(
              tabs: homepageTabs,
              onTap: (tabIndex) {
                BlocProvider.of<HomepageBloc>(context)
                    .add(ChangeTabMangaPage(tab: HomepageTab.values[tabIndex]));
              },
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoadAny(
                  errorMsg: 'Error',
                  finishMsg: 'Finished',
                  loadingMsg: 'Loading',
                  endLoadMore: false,
                  onLoadMore: () {
                    BlocProvider.of<HomepageBloc>(context).add(LoadMorePage());
                    return Future.value(0);
                  },
                  status: _getStatusFromState(),
                  child: CustomScrollView(
                    slivers: [
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return _buildCardView(context, mangaData[index]);
                          },
                          childCount: mangaData.length,
                        ),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: size.width / 3,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: itemWidth / itemHeight,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildCardView(BuildContext context, MangaInfo info) {
    switch (status) {
      case HomepageStatus.initial:
        return Center(
            child: Text('init', style: TextStyle(color: Colors.grey)));
      case HomepageStatus.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      case HomepageStatus.success:
        return (GridMangaData(
          info: info,
        ));
      case HomepageStatus.failure:
        return Center(
            child: Text('error', style: TextStyle(color: Colors.red)));
      default:
        return Center(
            child: Text('error', style: TextStyle(color: Colors.red)));
    }
  }

  _getStatusFromState() {
    switch (status) {
      case HomepageStatus.initial:
        return LoadStatus.normal;
      case HomepageStatus.failure:
        return LoadStatus.error;
      case HomepageStatus.success:
        return LoadStatus.normal;
      case HomepageStatus.loading:
        return LoadStatus.loading;
    }
  }
}
