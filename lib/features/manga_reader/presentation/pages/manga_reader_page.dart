import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/component/appbar.dart';
import 'package:mobile/features/manga_info_page/domain/entities/CompleteMangaInfo.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../dependency_injection.dart';
import '../bloc/mangareader_bloc.dart';

class MangaReader extends StatelessWidget {
  const MangaReader({required this.info, required this.index, Key? key})
      : super(key: key);

  final CompleteMangaInfo info;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MangareaderBloc(getMangaScan: sl())
        ..add(GetScans(url: info.scans[index].url)),
      child: Scaffold(
        appBar: MangaAppBar(title: info.scans[index].name),
        body: MangaReaderBody(info: info, index: index),
      ),
    );
  }
}

class MangaReaderBody extends StatelessWidget {
  const MangaReaderBody({required this.info, required this.index, Key? key})
      : super(key: key);

  final CompleteMangaInfo info;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MangareaderBloc, MangareaderState>(
      builder: (context, state) {
        if (state.status == MangareaderStateStatus.success) {
          return Builder(
            builder: (context) {
              return Center(
                child: PhotoViewGallery.builder(
                  itemCount: state.images.length,
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: Image.network(
                        state.images[index].imageLink,
                        headers: {'Referer': 'https://readmanganato.com/'},
                        fit: BoxFit.cover,
                      ).image,
                      // Contained = the smallest possible size to fit one dimension of the screen
                      minScale: PhotoViewComputedScale.contained * 0.8,
                      // Covered = the smallest possible size to fit the whole screen
                      maxScale: PhotoViewComputedScale.covered * 2,
                    );
                  },
                  scrollPhysics: BouncingScrollPhysics(),
                  // Set the background color to the "classic white"
                  backgroundDecoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                  ),
                  // loadingChild: Center(
                  //   child: CircularProgressIndicator(),
                  // ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}


// CarouselSlider(
//                   options: CarouselOptions(
//                     enableInfiniteScroll: false,
//                     aspectRatio: 0.7,
//                     viewportFraction: 1.0,
//                     enlargeCenterPage: false,
//                     autoPlay: false,
//                   ),
//                   items: state.images
//                       .map((item) => Container(
//                             child: Center(
//                                 child: Image.network(
//                               item.imageLink,
//                               headers: {
//                                 'Referer': 'https://readmanganato.com/'
//                               },
//                               fit: BoxFit.cover,
//                             )),
//                           ))
//                       .toList(),
//                 ),


