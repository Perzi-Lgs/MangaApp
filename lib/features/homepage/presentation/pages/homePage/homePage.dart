import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/component/appbar.dart';
import 'package:mobile/core/component/navbar/bloc/navbar_bloc.dart';
import 'package:mobile/core/component/navbar/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(
      bloc: context.read<NavbarBloc>(),
      builder: (context, state) {
        print(state.index);
        return Scaffold(
          appBar: MangaAppBar(title: "Manga Rock"),
          bottomNavigationBar: MangaNavbar(index: state.index)
        );
      },
    );
  }
}
