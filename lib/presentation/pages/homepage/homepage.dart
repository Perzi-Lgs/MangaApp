import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/component/navbar/navbar_cubit/navbar_cubit.dart';

import 'homepage_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, int>(
      bloc: context.read<NavbarCubit>(),
      builder: (context, state) {
        return HomePageBody();
      },
    );
  }
}
