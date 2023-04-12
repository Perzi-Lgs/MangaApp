import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile/domain/entities/searchableField.dart';

import 'chapter.dart';

class CompleteMangaInfo extends Equatable {
  final String img; //urlimg
  final String name; //urlimg
  final String description; //urlimg
  final SearchableField author; //urlimg
  final List<SearchableField> genre; //urlimg
  final String update; //urlimg
  final String status; //urlimg
  final List<Chapter> scans; //urlimg
  final Color color;

  CompleteMangaInfo(
      {required this.color,
      required this.img,
      required this.name,
      required this.description,
      required this.author,
      required this.genre,
      required this.update,
      required this.scans,
      required this.status});

  static final empty = CompleteMangaInfo(
      img: '',
      name: '',
      author: SearchableField.empty(),
      description: '',
      genre: [],
      scans: [],
      update: '',
      status: '',
      color: Colors.black);

  CompleteMangaInfo copyWith({
    String? img,
    String? name,
    String? description,
    SearchableField? author,
    List<SearchableField>? genre,
    String? update,
    String? status,
    List<Chapter>? scans,
    Color? color,
  }) {
    return CompleteMangaInfo(
        color: color ?? this.color,
        img: img ?? this.img,
        name: name ?? this.name,
        author: author ?? this.author,
        description: description ?? this.description,
        genre: genre ?? this.genre,
        scans: scans ?? this.scans,
        update: update ?? this.update,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        img,
        name,
        author,
        description,
        genre,
        scans,
        update,
        status,
        color,
      ];
}
