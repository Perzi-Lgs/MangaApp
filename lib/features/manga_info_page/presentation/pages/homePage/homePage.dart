import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/component/appbar.dart';
import 'package:mobile/core/component/navbar/bloc/navbar_bloc.dart';
import 'package:mobile/core/component/navbar/navbar.dart';
import 'package:mobile/features/homepage/domain/entities/MangaInfo.dart';

class MangaInfoPage extends StatelessWidget {
  const MangaInfoPage({Key? key, required MangaInfo info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(
      bloc: context.read<NavbarBloc>(),
      builder: (context, state) {
        print(state.index);
        return Scaffold(
          appBar: MangaAppBar(title: "Manga Rock"),
          body: Container(color: Colors.red, height: 100, width: 100),
          bottomNavigationBar: MangaNavbar(index: state.index)
        );
      },
    );
  }
}
