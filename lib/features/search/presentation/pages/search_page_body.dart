import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:mobile/features/homepage/presentation/widgets/manga_grid_data.dart';
import 'package:mobile/features/search/presentation/bloc/search_bloc.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return FloatingSearchAppBar(
          autocorrect: true,
          color: Theme.of(context).primaryColor,
          hintStyle: Theme.of(context).textTheme.bodyText2,
          iconColor: Theme.of(context).secondaryHeaderColor,
          titleStyle: Theme.of(context).textTheme.headline3,
          hint: "Chercher des mangas, auteurs",
          actions: [
            FloatingSearchBarAction.searchToClear(),
          ],
          debounceDelay: const Duration(milliseconds: 500),
          onQueryChanged: (String query) {
            BlocProvider.of<SearchBloc>(context).add(Research(keyword: query));
          },
          body: SearchResultDisplay(state: state),
        );
      },
    );
  }
}

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

    return FloatingSearchBarScrollNotifier(
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
