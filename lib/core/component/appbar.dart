import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/bloc/search_bloc/search_bloc.dart';
import '../../presentation/pages/search_pages/search_page.dart';


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
