import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile/domain/entities/searchableField.dart';

class MangaInfo extends Equatable {
  final String img; //urlimg
  final String name; //urlimg
  final String url; //urlimg
  final SearchableField author; //urlimg
  final Color color;

  MangaInfo( 
      {required this.author, required this.img,
      required this.name, required this.url, required this.color});

  static final empty = MangaInfo(
    img: '',
    url: '',
    name: '', author: SearchableField.empty(),
    color: Colors.black
  );

  MangaInfo copyWith({String? img, String? url, String? name, SearchableField? author, Color? color}) {
    return MangaInfo(img: img ?? this.img, url: url ?? this.url, name: name ?? this.name, author: author ?? this.author, color: color ?? this.color);
  }

  @override
  List<Object?> get props => [img, url, name, author, color];
}
