import 'package:flutter/material.dart';

import '../../../../../core/component/appbar.dart';
import '../../../domain/entities/complete_manga_info.dart';
import 'manga_list_chapters_body.dart';

class ListChaptersPage extends StatelessWidget {
  ListChaptersPage({required this.info});

  final CompleteMangaInfo info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MangaAppBar(),
      body: ListChaptersPageBody(info: info),
    );
  }
}
