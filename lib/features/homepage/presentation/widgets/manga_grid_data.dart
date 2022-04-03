import 'package:flutter/material.dart';

import '../../../manga_info_page/presentation/pages/Manga_info_page/Manga_info_page.dart';
import '../../domain/entities/MangaInfo.dart';

class GridMangaData extends StatelessWidget {
  final MangaInfo info;

  const GridMangaData({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (InkWell(
      onTap: () => _showSheet(context, info),
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              info.img,
              headers: {'Referer': 'https://readmanganato.com/'},
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 45,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              info.name,
              style: TextStyle(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          )
        ],
      )),
    ));
  }

  void _showSheet(BuildContext context, MangaInfo info) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // set this to true
      builder: (_) {
        return MangaInfoPage(info: info);
      },
    );
  }
}
