import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/component/appbar.dart';
import '../../../core/component/navbar/bloc/navbar_bloc.dart';
import '../../../core/component/navbar/navbar.dart';

import 'homepageBody.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(
      bloc: context.read<NavbarBloc>(),
      builder: (context, state) {
        return Scaffold(
            appBar: MangaAppBar(title: "Manga Rock"),
            body: HomePageBody(),
            bottomNavigationBar: MangaNavbar(index: state.index));
      },
    );
  }
}
