import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/favorite_cubit/favorite_cubit.dart';
import '../../widgets/gradient_circular_indicator/custom_refresh_indicator.dart';
import '../../widgets/manga_grid_body.dart';

class FavoriteBody extends StatelessWidget {
  const FavoriteBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      bloc: context.read<FavoriteCubit>()..getAllFavorite(),
      builder: (context, state) {
        return CustomExtendIndicator(
            onRefresh: () {
              return Future.sync(
                () => context.read<FavoriteCubit>().getAllFavorite(),
              );
            },
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: itemWidth / itemHeight,
              children: state.data.map((e) => GridMangaBody(info: e)).toList(),
            ));
      },
    );
  }
}
