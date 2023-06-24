import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/domain/entities/chapter.dart';
import 'package:mobile/domain/entities/complete_manga_info.dart';
import 'package:mobile/presentation/bloc/bookmark_cubit/bookmark_cubit.dart';

import '../../../domain/entities/scan_image.dart';
import '../../bloc/manga_reader_bloc/mangareader_bloc.dart';

class WebtoonsReader extends StatelessWidget {
  const WebtoonsReader({
    required this.images,
    required this.index,
    required this.data,
    Key? key,
  }) : super(key: key);

  final List<ScanImage> images;
  final int index;
  final CompleteMangaInfo data;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollNotification>(
        onNotification: (notification) {
          if (index > 0 &&
              notification.velocity > 0 &&
              notification.velocity < 4000) {
            context.read<BookmarkCubit>().setLastRead(data.scans[index - 1].name, data.name);
            context
                .read<MangareaderBloc>()
                .add(GetScans(index: index - 1, url: data.scans[index - 1].url));
          }
          if (index < data.scans.length &&
              notification.velocity < 0 &&
              notification.velocity > -4000) {
            context
                .read<BookmarkCubit>()
                .setLastRead(data.scans[index + 1].name, data.name);
            context
                .read<MangareaderBloc>()
                .add(GetScans(index: index + 1, url: data.scans[index + 1].url));
          }
          return true;
        },
        child: SingleChildScrollView(
          child: InteractiveViewer(
            child: Column(
              children: images.map((e) => PageWidget(images: e)).toList(),
            ),
          ),
        ));
  }
}

class PageWidget extends StatelessWidget {
  const PageWidget({
    Key? key,
    required this.images,
  }) : super(key: key);

  final ScanImage images;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      images.imageLink,
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
    );
  }
}
