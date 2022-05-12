import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/component/appbar.dart';
import '../../core/component/navbar/navbar.dart';
import '../../core/component/navbar/navbar_cubit/navbar_cubit.dart';
import '../../core/component/navbar/navbar_selector.dart';

class AppBody extends StatelessWidget {
  const AppBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, int>(
      bloc: context.read<NavbarCubit>(),
      builder: (context, state) {
        return Scaffold(
            appBar: MangaAppBar(title: "Manga Rock"),
            body: SafeArea(child: NavbarSelector(index: state)),
            bottomNavigationBar: MangaNavbar(index: state));
      },
    );
  }
}
