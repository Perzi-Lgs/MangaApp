import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/homepage/presentation/bloc/homepage_bloc.dart';

import '../../domain/entities/MangaInfo.dart';

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
    final data = mangaData.map((e) => _buildCardView(e)).toList();

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return DefaultTabController(
      length: homepageTabs.length,
      child: Builder(builder: (context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            return BlocProvider.of<HomepageBloc>(context)
                .add(ChangeTabMangaPage(tab: HomepageTab.values[tabController.index]));
          }
        });
        return Column(
          children: [
            TabBar(tabs: homepageTabs),
            Flexible(
              child: GridView.count(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  childAspectRatio: itemWidth / itemHeight,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: data),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildCardView(MangaInfo info) {
    switch (status) {
      case HomepageStatus.initial:
        return Center(
            child: Text('init', style: TextStyle(color: Colors.grey)));
      case HomepageStatus.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      case HomepageStatus.success:
        return Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                info.img,
                headers: {'Referer': 'https://readmanganato.com/'},
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 45,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                info.name,
                style: TextStyle(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            )
          ],
        ));
      case HomepageStatus.failure:
        return Center(
            child: Text('error', style: TextStyle(color: Colors.red)));
      default:
        return Center(
            child: Text('error', style: TextStyle(color: Colors.red)));
    }
  }
}
