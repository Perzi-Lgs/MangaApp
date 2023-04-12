import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobile/core/component/navbar/navbar_cubit/navbar_cubit.dart';

import '../../../../../dependency_injection.dart';
import '../../../config/themes/theme_config.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/manga_info.dart';
import '../../../domain/usecases/get_homepage_scans.dart';
import '../../widgets/gradient_circular_indicator/custom_refresh_indicator.dart';
import '../../widgets/manga_grid_body.dart';

class HomepageBody extends StatefulWidget {
  final int index;

  const HomepageBody({Key? key, required this.index}) : super(key: key);

  @override
  _HomepageBodyState createState() => _HomepageBodyState();
}

class _HomepageBodyState extends State<HomepageBody> with AutomaticKeepAliveClientMixin {
  static const _pageSize = 24;
  int index = 0;
  List<String> pageRoute = ['hot', 'home', 'favorite', 'newest'];

  final PagingController<int, MangaInfo> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      print(index);
      GetHomepageScans fetchHomepageManga = GetHomepageScans(sl());
      final newItems = await fetchHomepageManga(
          Params(route: pageRoute[index], page: pageKey));
      bool isLastPage;
      newItems.fold((l) => throw ServerFailure(l.message), (r) {
        isLastPage = r.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(r);
        } else {
          final nextPageKey = pageKey + r.length;
          if (nextPageKey == 24) {
            _pagingController.itemList = [];
          }
          _pagingController.appendPage(r, nextPageKey);
        }
      });
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Column(children: [
        Container(
          height: 50,
          color: CustomColors.darkGrey,
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: TabBar(
              tabs: [
                Tab(text: "Hot"),
                Tab(text: "Latest"),
                Tab(text: "Favorite"),
                Tab(text: "Newest"),
              ],

              onTap: (int i) {
                setState(() {
                  index = i;
                });
                _fetchPage(0);
              },
              physics: NeverScrollableScrollPhysics(),
              splashFactory: NoSplash.splashFactory,
              isScrollable: true,
              unselectedLabelColor: CustomColors.lightGrey,
              indicatorColor: Colors.transparent,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.transparent)),
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: children,
            ))
      ]),
    );
  }

  late List<Widget> children = [
    _pageRefresher(),
    _pageRefresher(),
    Container(color: CustomColors.darkGrey),
    _pageRefresher(),
  ];

  Widget _pageRefresher() {
    final size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return ((CustomExtendIndicator(
      onRefresh: () {
        return Future.sync(
          () => _pagingController.refresh(),
        );
      },
      child: PagedGridView<int, MangaInfo>(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: size.width / 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: itemWidth / itemHeight,
          ),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MangaInfo>(
              firstPageProgressIndicatorBuilder: (_) => Container(),
              newPageProgressIndicatorBuilder: (_) => Container(),
              itemBuilder: (context, item, index) =>
                  buildCardView(context, item))),
    )));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Widget buildCardView(BuildContext context, MangaInfo info) {
    return (GridMangaBody(info: info));
  }
  
  @override
  bool get wantKeepAlive => true;
}
