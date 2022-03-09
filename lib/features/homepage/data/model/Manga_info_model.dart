import '../../domain/entities/MangaInfo.dart';

class MangaInfoModel extends MangaInfo {
  MangaInfoModel({
    required String img,
    required String url,
    required String name,
    required String author,
  }) : super(img: img, url: url, name: name, author: author);

  factory MangaInfoModel.fromJson(Map<String, dynamic> json) {
    return MangaInfoModel(
      url: json['url'],
      img: json['img'],
      name: json['name'],
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'img': img, 'name': name, 'url': url, 'author': author};
  }
}
