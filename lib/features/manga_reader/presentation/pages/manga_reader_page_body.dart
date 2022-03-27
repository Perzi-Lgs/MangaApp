import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../manga_info_page/domain/entities/CompleteMangaInfo.dart';
import '../../domain/entities/ScanImage.dart';
import '../bloc/mangareader_bloc.dart';

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
          if (info.genre.contains('Webtoons')) {
            return WebtoonsReader(images: state.images);
          } else
            return MangaReader(images: state.images);
        } else {
          return Container();
        }
      },
    );
  }
}

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

class WebtoonsReader extends StatelessWidget {
  const WebtoonsReader({
    required this.images,
    Key? key,
  }) : super(key: key);

  final List<ScanImage> images;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: images.length,
        itemBuilder: ((context, index) {
          return InteractiveViewer(
            child: Image.network(
              images[index].imageLink,
              headers: {'Referer': 'https://readmanganato.com/'},
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (BuildContext ctx, Object obj, StackTrace? stk) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.red,
                ));
              },
            ),
          );
        }));
  }
}
