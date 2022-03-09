
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/component/navbar/bloc/navbar_bloc.dart';

class MangaNavbar extends StatelessWidget {
  final index;

  const MangaNavbar({required this.index});

  @override
  Widget build(BuildContext context) {
      return BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        onTap: (index) =>  
          context.read<NavbarBloc>().add(UpdateNavabar(index: index)),
        items: [
          BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Icon(Icons.explore),
          ),
          label: "DECOUVRIR",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Icon(Icons.favorite),
          ),
          label: "FAVORIS",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Icon(Icons.history),
          ),
          label: "RECENT",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Icon(Icons.download),
          ),
          label: "TELECHARGEMENT",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Icon(Icons.more_horiz),
          ),
          label: "PLUS...",
        )
        ],
      );
  }
}