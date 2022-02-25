import 'package:equatable/equatable.dart';
import 'package:mobile/features/homepage/domain/entities/MangaLink.dart';

class MangaInfo extends Equatable {
  final String cover; //urlCover
  final MangaLink linkMangaName;
  final MangaLink linkChapter;

  MangaInfo(
      {required this.cover,
      required this.linkMangaName,
      required this.linkChapter});

  static final empty = MangaInfo(
    cover: '',
    linkChapter: MangaLink.empty,
    linkMangaName: MangaLink.empty
  );

  MangaInfo copyWith({String? cover, MangaLink? linkMangaName, MangaLink? linkChapter}) {
    return MangaInfo(cover: cover ?? this.cover,linkMangaName: linkMangaName ?? this.linkMangaName, linkChapter: linkChapter ?? this.linkChapter);
  }

  @override
  List<Object?> get props => [cover, linkMangaName, linkChapter];
}
