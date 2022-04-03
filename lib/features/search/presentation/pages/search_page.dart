import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/search/presentation/pages/search_page_body.dart';

import '../bloc/search_bloc.dart';

final List<String> suggestions = ['victor', 'pierre', 'maman', 'yuan', 'alex'];

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: Scaffold(body: NewWidget()),
    );
  }
}
