import 'package:flutter/material.dart';
import 'package:mobile/features/manga_info_page/domain/entities/CompleteMangaInfo.dart';

import '../../../../../core/component/appbar.dart';
import 'Manga_list_chapters_body.dart';

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
