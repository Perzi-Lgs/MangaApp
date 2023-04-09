import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../dependency_injection.dart';
import '../../../config/themes/theme_config.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/manga_info.dart';
import '../../../domain/usecases/get_homepage_scans.dart';
import '../../widgets/gradient_circular_indicator/custom_refresh_indicator.dart';
import '../../widgets/gradient_circular_indicator/gradient_circular_indicator.dart';
import '../../widgets/manga_grid_body.dart';

class HomepageBody extends StatefulWidget {
  @override
  _HomepageBodyState createState() => _HomepageBodyState();
}

class _HomepageBodyState extends State<HomepageBody> {
  static const _pageSize = 20;

  List<String> pageRoute = ['hot', 'home', 'favorite', 'newest'];
  int index = 1;

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
          _pagingController.appendPage(r, nextPageKey);
        }
      });
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
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
                _pagingController.refresh();
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
    // Test(),
    // Scaffold(body: HomePage()),
    _pageRefresher(),
    _pageRefresher(),
    Container(color: CustomColors.darkGrey),
    _pageRefresher(),
    // MangaGrid(),
    // Container(color: Colors.purple[100]),
  ];

  Widget _pageRefresher() {
    final size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return ((CustomExtendIndicator(
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
}
