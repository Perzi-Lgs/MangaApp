import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../dependency_injection.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/manga_info.dart';
import '../../../domain/usecases/get_homepage_scans.dart';
import '../../widgets/manga_grid_data.dart';

class HomepageBody extends StatefulWidget {
  @override
  _HomepageBodyState createState() => _HomepageBodyState();
}

class _HomepageBodyState extends State<HomepageBody> {
  static const _pageSize = 20;

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
      final newItems =
          await fetchHomepageManga(Params(route: 'home', page: pageKey));
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
    final size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return (RefreshIndicator(
      onRefresh: () => Future.sync(
        () => _pagingController.refresh(),
      ),
      child: PagedGridView<int, MangaInfo>(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: size.width / 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: itemWidth / itemHeight,
          ),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MangaInfo>(
              itemBuilder: (context, item, index) =>
                  buildCardView(context, item))),
    ));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Widget buildCardView(BuildContext context, MangaInfo info) {
    return (GridMangaData(info: info));
  }
}
