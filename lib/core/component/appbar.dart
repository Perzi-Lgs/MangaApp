import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/bloc/search_bloc/search_bloc.dart';
import '../../presentation/pages/search_pages/search_page.dart';

class MangaAppBar extends StatelessWidget with PreferredSizeWidget {
  const MangaAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => {}, icon: Icon(Icons.notifications_outlined)),
      actions: [
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {
                  showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(
                          searchBloc: BlocProvider.of<SearchBloc>(context)))
                }),
        IconButton(onPressed: () => {}, icon: Icon(Icons.more_vert))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(35);
}
