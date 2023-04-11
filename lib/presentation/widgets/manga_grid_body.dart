import 'package:flutter/material.dart';

import '../../domain/entities/manga_info.dart';
import '../pages/manga_info_page/manga_info_page.dart';

class GridMangaBody extends StatelessWidget {
  final MangaInfo info;

  const GridMangaBody({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MangaInfoPage(info: info))),
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Hero(
              tag: info.img,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  info.img,
                  headers: {'Referer': 'https://readmanganato.com/'},
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Container(
          //   height: 45,
          //   padding: EdgeInsets.symmetric(vertical: 5),
          //   child: Text(
          //     info.name,
          //     style: TextStyle(color: Colors.grey),
          //     overflow: TextOverflow.ellipsis,
          //     maxLines: 2,
          //   ),
          // )
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
