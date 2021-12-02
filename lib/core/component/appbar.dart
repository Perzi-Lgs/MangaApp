
import 'package:flutter/material.dart';

class MangaAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const MangaAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: Theme.of(context).textTheme.headline1),
    );    
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
  
}