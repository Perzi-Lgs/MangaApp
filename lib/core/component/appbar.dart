import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/search/presentation/bloc/search_bloc.dart';
import '../../features/search/presentation/pages/search_page_body.dart';

class MangaAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const MangaAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: Theme.of(context).textTheme.headline1),
      actions: [
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {
                  showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(
                          searchBloc: BlocProvider.of<SearchBloc>(context)))
                })
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class CustomSearchDelegate extends SearchDelegate {
  final SearchBloc searchBloc;

  CustomSearchDelegate({required this.searchBloc});

  @override
  String? get searchFieldLabel => 'Chercher des mangas, auteurs';

  @override
  List<Widget>? buildActions(BuildContext context) {
    if (query.length > 0) {
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
      ];
    } else {
      return [];
    }
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchBloc.add(Research(keyword: query));
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.status == SearchStatus.initial)
          return Text('Please input a search.');
        else if (state.status == SearchStatus.loading)
          return Center(child: CircularProgressIndicator());
        else {
          return SearchResultDisplay(
            state: state,
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchBloc.add(GetHistory());
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.status == SearchStatus.loading)
          return Center(child: CircularProgressIndicator());
        else {
          final result = state.history
              .where((a) => a.toLowerCase().contains(query.toLowerCase()));
          return ListView(
            children: result
                .map((e) => ListTile(
                      title: Text(e, style: TextStyle(color: Colors.white)),
                      leading: Icon(Icons.search, color: Colors.white),
                      onTap: () => query = e,
                      trailing: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          searchBloc.add(DeleteHistory(query: e));
                        },
                      ),
                    ))
                .toList(),
          );
        }
      },
    );
  }
}
