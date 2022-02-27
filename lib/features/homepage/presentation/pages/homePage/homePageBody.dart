import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/homepage/presentation/bloc/homepage_bloc.dart';

import '../../../../../dependency_injection.dart';
import '../../widgets/manga_grid_view.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomepageBloc(getHomepageScans: sl()),
      child: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              return BlocProvider.of<HomepageBloc>(context).add(FetchHomeMangaPage());
            },
            child: Stack(children: [
              MangaGridView(mangaData: state.infos, status: state.status),
              Container(
              color: Colors.red,
              child: FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<HomepageBloc>(context).add(FetchHomeMangaPage());
                  },
                  backgroundColor: Colors.green),
            )
            ],),
          );
        },
      ),
    );
  }
}
