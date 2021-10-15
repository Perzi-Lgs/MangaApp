import 'package:equatable/equatable.dart';
import 'package:mobile/features/homepage/domain/entities/MangaLink.dart';

class MangaInfo extends Equatable {
  final String cover;
  final MangaLink linkMangaName;
  final MangaLink linkChapter;

  MangaInfo(
      {required this.cover,
      required this.linkMangaName,
      required this.linkChapter});

  @override
  List<Object?> get props => [cover, linkMangaName, linkChapter];
}
