import 'package:flutter/material.dart';

import '../../../../config/themes/theme_config.dart';
import '../../bloc/manga_info_bloc/manga_info_bloc.dart';
import 'logo_button.dart';

class MangaInfoPageSelector extends StatelessWidget {
  const MangaInfoPageSelector({
    Key? key,
    required this.state,
  }) : super(key: key);

  final MangaInfoState state;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LogoButton(title: 'Reprendre', icon: Icons.play_arrow_outlined),
          VerticalDivider(
            width: 10,
            thickness: 1,
            color: CustomColors.lightGrey,
          ),
          LogoButton(
              title: state.info.scans.length.toString() + ' Chapitres',
              icon: Icons.list),
          VerticalDivider(
            width: 20,
            thickness: 1,
            color: CustomColors.lightGrey,
          ),
          LogoButton(title: 'Ajoute aux favoris', icon: Icons.favorite),
        ],
      ),
    );
  }
}
