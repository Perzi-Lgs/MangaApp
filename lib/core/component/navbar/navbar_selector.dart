import 'package:flutter/material.dart';

import '../../../presentation/pages/download_page/download_page.dart';
import '../../../presentation/pages/favorite_page/favorite_page.dart';
import '../../../presentation/pages/homePage/homePage.dart';
import '../../../presentation/pages/recent_page/recent_page.dart';

class NavbarSelector extends StatelessWidget {
  const NavbarSelector({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return FavoritePage();
      case 2:
        return RecentPage();
      case 3:
        return MangaDownloadPage();
      default:
        return HomePage();
    }
  }
}
