import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/homepage/presentation/bloc/homepage_bloc.dart';

import '../../../../../dependency_injection.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomepageBloc(getHomepageScans: sl()),
      child: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          switch (state.status) {
            case HomepageStatus.initial:
              print('initial');
              break;
            case HomepageStatus.loading:
              print('loading');
              break;
            case HomepageStatus.success:
              print(state.infos);
              break;
            case HomepageStatus.failure:
              print('failure');
              break;
          }
          return Container(
            color: Colors.red,
            child: FloatingActionButton(
                // child: Text(),
                onPressed: () {
                  print('plop');
                  BlocProvider.of<HomepageBloc>(context).add(FetchHomeMangaPage());
                },
                backgroundColor: Colors.green),
          );
        },
      ),
    );
  }
}
