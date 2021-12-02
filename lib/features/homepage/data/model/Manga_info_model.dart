import '../../domain/entities/MangaInfo.dart';

import 'Link_model.dart';

class MangaInfoModel extends MangaInfo {
  MangaInfoModel({
    required String cover,
    required LinkModel linkMangaName,
    required LinkModel linkChapter,
  }) : super(
            cover: cover,
            linkMangaName: linkMangaName,
            linkChapter: linkChapter);

  factory MangaInfoModel.fromJson(Map<String, dynamic> json) {
    return MangaInfoModel(
        cover: json['cover'],
        linkChapter: LinkModel.fromJson(json["linkChapter"]),
        linkMangaName: LinkModel.fromJson(json["linkMangaName"]));
  }

  Map<String, dynamic> toJson() {
    return {
      'cover': cover,
      'linkChapter': {"url": linkChapter.url, "name": linkChapter.name},
      'linkMangaName': {"url": linkMangaName.url, "name": linkMangaName.name}
    };
  }
}
