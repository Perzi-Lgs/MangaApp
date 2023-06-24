import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/domain/entities/complete_manga_info.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../domain/entities/scan_image.dart';
import '../../bloc/bookmark_cubit/bookmark_cubit.dart';
import '../../bloc/manga_reader_bloc/mangareader_bloc.dart';

class MangaReader extends StatelessWidget {
  const MangaReader({
    required this.images,
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final List<ScanImage> images;
  final CompleteMangaInfo data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Center(
          child: NotificationListener<OverscrollNotification>(
            onNotification: (notification) {
              if (index > 0 &&
                  notification.overscroll > 0 &&
                  notification.overscroll < 20) {
                context
                    .read<BookmarkCubit>()
                    .setLastRead(data.scans[index - 1].name, data.name);
                context.read<MangareaderBloc>().add(
                    GetScans(index: index - 1, url: data.scans[index - 1].url));
              }
              if (index < data.scans.length &&
                  notification.overscroll < 0 &&
                  notification.overscroll > -20) {
                context
                    .read<BookmarkCubit>()
                    .setLastRead(data.scans[index + 1].name, data.name);
                context.read<MangareaderBloc>().add(
                    GetScans(index: index + 1, url: data.scans[index + 1].url));
              }
              return true;
            },
            child: PhotoViewGallery.builder(
              onPageChanged: (pageIndex) {
                // if (pageIndex + 1 == images.length) {
                //   context
                //       .read<BookmarkCubit>()
                //       .setLastRead(data.scans[index - 1].name, data.name);
                //   context.read<MangareaderBloc>().add(
                //       GetScans(index: index - 1, url: data.scans[index - 1].url));
                // } else if (pageIndex == 0) {
                //   context
                //       .read<BookmarkCubit>()
                //       .setLastRead(data.scans[index + 1].name, data.name);
                //   context.read<MangareaderBloc>().add(
                //       GetScans(index: index + 1, url: data.scans[index + 1].url));
                // }
              },
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
              // scrollPhysics: BouncingScrollPhysics(),
              // Set the background color to the "classic white"
              backgroundDecoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
