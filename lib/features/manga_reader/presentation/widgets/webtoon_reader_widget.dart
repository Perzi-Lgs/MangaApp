import 'package:flutter/material.dart';

import '../../domain/entities/ScanImage.dart';

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
