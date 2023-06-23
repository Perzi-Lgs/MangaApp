import 'package:flutter/material.dart';

import '../../config/themes/theme_config.dart';
import '../../core/component/appbar.dart';
import 'homepage/homepage.dart';

List<Widget> childs = [
  Container(color: CustomColors.darkGrey),
  HomePage(),
  Container(color: Colors.purple[100]),
];

class AppBody extends StatelessWidget {
  const AppBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MangaAppBar(),
      body: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Column(
          children: [
            Container(
              height: 50,
              color: CustomColors.darkGrey,
              child: FractionallySizedBox(
                widthFactor: 0.80,
                child: TabBar(
                  labelPadding: EdgeInsets.symmetric(horizontal: 0),
                  unselectedLabelColor: CustomColors.lightGrey,
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: UnderlineTabIndicator(
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.only(top: 10),
                  indicatorWeight: 3,
                  tabs: [
                    Tab(text: "Download"),
                    Tab(text: "Home"),
                    Tab(text: "Timetable"),
                  ],
                ),
              ),
            ),
            FractionallySizedBox(
                widthFactor: 0.95,
                child: Divider(
                    height: 1, color: CustomColors.lightGrey, thickness: 1)),
            Expanded(
              flex: 1,
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: childs,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Test extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return NestedScrollView(
//       body: Container(
//         color: Colors.red,
//       ),
//       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
//           [MangaAppBar()],
//     );
//   }
// }

// Scaffold(
//               body: NestedScrollView(
//                 body: LoopPageView.builder(),
//                 headerSliverBuilder:
//                     (BuildContext context, bool innerBoxIsScrolled) =>
//                         [MangaAppBar()],
//               ),

// Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       TextButton(
//                         child: Text("Download"),
//                         onPressed: () {},
//                         style: TextButton.styleFrom(
//                           backgroundColor: Colors.transparent,
//                           foregroundColor: Colors.white
//                         ),
//                       ),
//                       TextButton(
//                         child: Text("Home"),
//                         onPressed: () {},
//                       ),
//                       TextButton(
//                         child: Text("Timetable"),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 ),
//               ),