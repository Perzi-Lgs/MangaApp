import 'package:flutter/material.dart';
import 'package:mobile/config/themes/theme_config.dart';
import 'package:mobile/features/manga_info_page/domain/entities/CompleteMangaInfo.dart';

import '../../../../../core/component/appbar.dart';
import '../../../../manga_reader/presentation/pages/manga_reader_page.dart';

class ListChaptersPage extends StatelessWidget {
  ListChaptersPage({required this.info});

  final CompleteMangaInfo info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MangaAppBar(title: "Manga Rock"),
      body: ListChaptersPageBody(info: info),
    );
  }
}

class ListChaptersPageBody extends StatelessWidget {
  ListChaptersPageBody({required this.info});

  final CompleteMangaInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.darkGrey,
      child: ListView.builder(
          itemCount: info.scans.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MangaReader(info: info, index: index))),
              child: Container(
                height: 50,
                child: Center(
                    child: Text(
                  '${info.scans[index].name}',
                  style: TextStyle(color: CustomColors.white),
                )),
              ),
            );
          }),
    );
  }
}
