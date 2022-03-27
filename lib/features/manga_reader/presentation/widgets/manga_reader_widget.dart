import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../domain/entities/ScanImage.dart';

class MangaReader extends StatelessWidget {
  const MangaReader({
    required this.images,
    Key? key,
  }) : super(key: key);

  final List<ScanImage> images;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Center(
          child: PhotoViewGallery.builder(
            itemCount: images.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: Image.network(
                  images[index].imageLink,
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
  }
}
