import 'package:flutter/material.dart';

class MangaAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const MangaAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: Theme.of(context).textTheme.headline1),
      actions: [
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {
                  showSearch(
                      context: context, delegate: MangaSearchDelelegate())
                  // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SearchPage()))
                })
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class MangaSearchDelelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [IconButton(
    onPressed: () {
      query = '';
    }, icon: Icon(Icons.clear))];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null));

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text(query, style: TextStyle(color: Colors.white),));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = List.empty();

    return ListView.builder(itemCount: suggestions.length, itemBuilder: (context, index) {
      return Text(suggestions[index]);
    });
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResearchAppBar(),
    );
  }
}

class ResearchAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
