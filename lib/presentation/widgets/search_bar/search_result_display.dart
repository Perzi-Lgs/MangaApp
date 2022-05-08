import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../bloc/search_bloc/search_bloc.dart';
import '../manga_grid_data.dart';

class SearchResultDisplay extends StatelessWidget {
  const SearchResultDisplay({
    Key? key,
    required this.state,
  }) : super(key: key);

  final SearchState state;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (state.status.isSuccess)
                  return GridMangaData(info: state.infos[index]);
                else if (state.status.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else
                  return Container();
              },
              childCount: state.infos.length,
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
    );
  }
}
