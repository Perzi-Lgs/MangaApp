import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/config/themes/dark_theme.dart';
import 'package:mobile/core/component/navbar/bloc/navbar_bloc.dart';

import 'config/routes/route_generator.dart';
import 'dependency_injection.dart' as di;
import 'dependency_injection.dart';
import 'presentation/bloc/search_bloc/search_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(Manga());
}

class Manga extends StatelessWidget {
  const Manga({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavbarBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(
              getResearchScans: sl(),
              deleteSearchInHistory: sl(),
              getResearchHistory: sl()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: darkTheme,
      ),
    );
  }
}
