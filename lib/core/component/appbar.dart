import 'package:flutter/material.dart';

import '../../features/search/presentation/pages/search_page.dart';

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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SearchPage()))
                })
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
