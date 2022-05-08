import 'package:flutter/material.dart';

class MangaInfoDivider extends StatelessWidget {
  const MangaInfoDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.black,
      height: 60,
      thickness: 20,
    );
  }
}
