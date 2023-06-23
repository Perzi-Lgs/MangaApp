import 'package:flutter/material.dart';

import '../../domain/entities/manga_info.dart';
import '../../domain/entities/searchableField.dart';

class MangaInfoModel extends MangaInfo {
  MangaInfoModel({
    required String img,
    required String url,
    required String name,
    required SearchableField author,
    Color? color,
  }) : super(img: img, url: url, name: name, author: author, color: color ?? Colors.black);

  factory MangaInfoModel.fromJson(Map<String, dynamic> json) {
    return MangaInfoModel(
      url: json['url'],
      img: json['img'],
      name: json['name'],
      author: json['author'] == null ? SearchableField.empty() : SearchableField.fromJson(json['author']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'img': img, 'name': name, 'url': url, 'color': color.toString()};
  }
}
