import '../../domain/entities/MangaInfo.dart';

class MangaInfoModel extends MangaInfo {
  MangaInfoModel({
    required String img,
    required String url,
    required String name,
  }) : super(img: img, url: url, name: name);

  factory MangaInfoModel.fromJson(Map<String, dynamic> json) {
    return MangaInfoModel(
      url: json['url'],
      img: json['img'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'img': img, 'name': name, 'url': url};
  }
}
