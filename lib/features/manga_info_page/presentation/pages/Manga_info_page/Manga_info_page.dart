import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/component/appbar.dart';
import 'package:mobile/core/component/navbar/bloc/navbar_bloc.dart';
import 'package:mobile/core/component/navbar/navbar.dart';
import 'package:mobile/features/homepage/domain/entities/MangaInfo.dart';

import '../../../../../dependency_injection.dart';
import '../../bloc/mangainfo_bloc.dart';

class MangaInfoPage extends StatelessWidget {
  const MangaInfoPage({Key? key, required this.info}) : super(key: key);

  final MangaInfo info;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(
      bloc: context.read<NavbarBloc>(),
      builder: (context, state) {
        print(state.index);
        return Scaffold(
            appBar: MangaAppBar(title: "Manga Rock"),
            body: BlocProvider(
              create: (context) => MangainfoBloc(getFullMangaInfo: sl()),
              child: Body(info: info),
            ),
            bottomNavigationBar: MangaNavbar(index: state.index));
      },
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.info,
  }) : super(key: key);

  final MangaInfo info;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          BlocProvider.of<MangainfoBloc>(context)
              .add(FetchMangaInfo(url: info.url));
        },
        child: Container(color: Colors.red, height: 100, width: 100));
  }
}
