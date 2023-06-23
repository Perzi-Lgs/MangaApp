import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/presentation/bloc/favorite_cubit/favorite_cubit.dart';

import '../../../dependency_injection.dart';
import 'favorite_body.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit(
          getAllFavoriteUsecase: sl(),
          getIsFavoriteUsecase: sl(),
          switchFavoriteUsecase: sl()),
      child: FavoriteBody(),
    );
  }
}
