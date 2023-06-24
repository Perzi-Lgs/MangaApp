import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/settings/duration_extention.dart';
import 'package:mobile/domain/entities/chapter.dart';
import 'package:mobile/domain/entities/complete_manga_info.dart';
import 'package:mobile/presentation/bloc/bookmark_cubit/bookmark_cubit.dart';
import 'package:mobile/presentation/bloc/favorite_cubit/favorite_cubit.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../domain/entities/manga_info.dart';
import '../../bloc/manga_info_bloc/manga_info_bloc.dart';
import '../manga_reader/manga_reader_page.dart';

String extractChapterNumber(String input) {
  RegExp chapterNumberRegex = RegExp(r'\bChapter\s*(\d+)');
  Match? match = chapterNumberRegex.firstMatch(input);

  if (match == null) {
    RegExp onlyDigitRegex = RegExp(r'^\d+$');
    Match? isDigit = onlyDigitRegex.firstMatch(input);

    if (isDigit != null) {
      return 'Chapter ' + isDigit.group(0)!;
    }
  } else {
    return match.group(0)!;
  }
  return input;
}

class MangaInfoPageBody extends StatelessWidget {
  const MangaInfoPageBody({
    Key? key,
    required this.info,
  }) : super(key: key);

  final MangaInfo info;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MangaInfoBloc, MangaInfoState>(
      builder: (context, state) {
        return Scaffold(
          body: MangaInfoPageData(state: state, info: info),
          backgroundColor: info.color,
        );
      },
    );
  }
}

class MangaInfoPageData extends StatelessWidget {
  final MangaInfoState state;
  final MangaInfo info;
  const MangaInfoPageData({Key? key, required this.state, required this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: info.color,
      child: ChapterBottomSheet(info: info, state: state),
    );
  }
}

const double minHeight = 160;
const double iconStartSize = 44; //<-- add edge values
const double iconEndSize = 120; //<-- add edge values
const double iconStartMarginTop = 36; //<-- add edge values
const double iconEndMarginTop = 80; //<-- add edge values
const double iconsVerticalSpacing = 24; //<-- add edge values
const double iconsHorizontalSpacing = 16;

class ChapterBottomSheet extends StatefulWidget {
  final MangaInfo info;
  final MangaInfoState state;

  const ChapterBottomSheet({Key? key, required this.info, required this.state})
      : super(key: key);

  @override
  State<ChapterBottomSheet> createState() => _ChapterBottomSheetState();
}

class _ChapterBottomSheetState extends State<ChapterBottomSheet>
    with SingleTickerProviderStateMixin {
  late DraggableScrollableController _controller;
  double initialPercentage = 0.25;
  double percent = 0.0;
  double get maxHeight => MediaQuery.of(context).size.height;
  double get maxWidth => MediaQuery.of(context).size.width;

  bool gridMode = false;
  double? get headerTopMargin =>
      lerp(20, 70 + MediaQuery.of(context).padding.top); //<-- Add new property

  double? get headerFontSize => lerp(14, 24); //<-- Add new property
  double? get informationOpacity =>
      (lerp(1, 0, scale: 2) ?? 1) < 0 ? 0 : (lerp(1, 0, scale: 2) ?? 1);
  double? get informationOpacitySec =>
      (lerp(1, 0, scale: 3) ?? 1) < 0 ? 0 : (lerp(1, 0, scale: 3) ?? 1);

  double? get informationTranslation => lerp(0, 60);

  @override
  void initState() {
    _controller = DraggableScrollableController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double? lerp(double min, double max, {double scale = 1}) {
    if (_controller.isAttached == false) {
      return null;
    }
    return lerpDouble(min, max, percent * scale);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return SafeArea(
              child: _MangaPageInformation(
            data: widget.info,
            state: widget.state,
            height: 600,
            opacityMain: informationOpacity ?? 0,
            opacitySec: informationOpacitySec ?? 0,
            informationTranslation: informationTranslation ?? 0,
            maxWidth: maxWidth,
            maxheight: maxHeight,
          ));
        },
      ),
      Positioned.fill(
        child: NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            setState(() {
              percent = (notification.extent - 0.25) / 0.75;
            });
            return true;
          },
          child: DraggableScrollableSheet(
              minChildSize: initialPercentage,
              initialChildSize: initialPercentage,
              controller: _controller,
              snap: true,
              snapAnimationDuration: 200.ms,
              builder: (context, scrollController) {
                return AnimatedBuilder(
                    animation: scrollController,
                    builder: (context, child) {
                      return Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: widget.info.color,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: (headerTopMargin ?? 0) + 50),
                                child: gridMode == false
                                    ? BlocBuilder<BookmarkCubit, BookmarkState>(
                                        bloc: BlocProvider.of<BookmarkCubit>(
                                            context)
                                          ..getAllRead(widget.state.info.name),
                                        builder: (context, state) {
                                          return ListView.builder(
                                              itemCount: widget
                                                  .state.info.scans.length,
                                              controller: scrollController,
                                              itemBuilder: ((context, index) {
                                                return widget.state.info.scans
                                                            .length ==
                                                        0
                                                    ? Container()
                                                    : TextButton(
                                                        style: TextButton.styleFrom(
                                                            backgroundColor: widget
                                                                .info.color),
                                                        onPressed: () => Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    MangaReader(
                                                                        info: widget
                                                                            .state
                                                                            .info,
                                                                        index:
                                                                            index))),
                                                        child: MangaChapterList(
                                                            color: widget.info.color,
                                                            hasRead: state.allRead.contains(widget.state.info.scans[index].name),
                                                            scan: widget.state.info.scans[index]));
                                              }));
                                        },
                                      )
                                    : MangaChapterGrid(
                                        controller: scrollController,
                                        manga: widget.state.info,
                                        color: widget.info.color),
                              )),
                          ToggleIcon(
                              opacity: (percent - 0.80) / 0.20,
                              toggle: _toggle),
                          _ListModeIcon((percent - 0.80) / 0.20, () {
                            setState(() {
                              gridMode = !gridMode;
                            });
                          }),
                          ResumeChapterButton(
                            topMargin: headerTopMargin ?? 0,
                            info: widget.state.info,
                          )
                          // 0.75 = 0
                          // 1 = 1
                        ],
                      );
                    });
              }),
        ),
      ),
    ]);
  }

  double iconTopMargin(int index) =>
      lerp(iconStartMarginTop,
          iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize))! +
      headerTopMargin!; //<-- calculate top margin based on header margin, and size of all of icons above (from small to big)

  double iconLeftMargin(int index) => lerp(
      index * (iconsHorizontalSpacing + iconStartSize),
      0)!; //<-- calculate left margin (from big to small)

  void _toggle() {
    _controller.animateTo(_controller.size == 1 ? initialPercentage : 1,
        duration: 500.ms,
        curve: _controller.size == 1 ? Curves.easeOut : Curves.easeIn);
  }

//viewModule
//dashboard
  Widget _ListModeIcon(double opacity, Function changeIcon) {
    return Positioned(
      top: 40 + (1 - opacity) * 10,
      right: 10,
      child: AnimatedOpacity(
        opacity: opacity < 0 ? 0 : opacity,
        duration: 50.ms,
        child: IconButton(
          onPressed: () => changeIcon(),
          icon: Icon(
            gridMode == false ? Icons.view_list : Icons.grid_view,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ToggleIcon extends StatelessWidget {
  const ToggleIcon({Key? key, required this.toggle, required this.opacity})
      : super(key: key);

  final Function toggle;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40 + (1 - opacity) * 10,
      left: 10,
      child: AnimatedOpacity(
        opacity: opacity < 0 ? 0 : opacity,
        duration: 50.ms,
        child: Transform.rotate(
            angle: -math.pi / 2,
            child: IconButton(
              onPressed: () {
                if (opacity > 0.9) toggle();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}

class ResumeChapterButton extends StatelessWidget {
  final double topMargin;
  final CompleteMangaInfo info;

  const ResumeChapterButton(
      {Key? key, required this.topMargin, required this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkCubit, BookmarkState>(
      bloc: BlocProvider.of<BookmarkCubit>(context)..getLastRead(info.name),
      builder: (context, state) {
        return Positioned(
          left: 10,
          right: 10,
          top: topMargin,
          child: Container(
            height: 50,
            child: TextButton(
              onPressed: () {
                if (info.scans.length != 0) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    final index = info.scans.indexWhere(
                        (element) => element.name == state.lastRead);
                    return MangaReader(
                        info: info,
                        index: index < 0 ? info.scans.length - 1 : index);
                  }));
                }
              },
              child: Text(
                state.lastRead == "Chapter 1" ||
                        state.lastRead == "Chapter 0" ||
                        state.lastRead == ""
                    ? 'Read first chapter'
                    : "Resume " + state.lastRead,
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.05),
                splashFactory: NoSplash.splashFactory,
                shape: BeveledRectangleBorder(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MangaChapterGrid extends StatelessWidget {
  final CompleteMangaInfo manga;
  final Color color;
  final ScrollController controller;
  const MangaChapterGrid(
      {Key? key,
      required this.manga,
      required this.color,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: MediaQuery.of(context).size.width,
      child: FractionallySizedBox(
        widthFactor: 0.95,
        child: BlocBuilder<BookmarkCubit, BookmarkState>(
          bloc: BlocProvider.of<BookmarkCubit>(context)..getAllRead(manga.name),
          builder: (context, state) {
            return GridView.count(
              controller: controller,
              crossAxisCount: 3,
              children: [
                for (var i = 0; i < manga.scans.length; i++)
                  _buildCard(context, manga, i, state.allRead)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, CompleteMangaInfo info, int index,
      List<String> allRead) {
    return Container(
        width: 100,
        height: 100,
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: color),
          onPressed: () {
            context
                .read<BookmarkCubit>()
                .setLastRead(info.scans[index].name, info.name);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MangaReader(info: info, index: index)));
          },
          child: Column(
            children: [
              Container(height: 70, child: Placeholder()),
              Expanded(
                  child: TextScroll(
                extractChapterNumber(manga.scans[index].name),
                velocity: Velocity(pixelsPerSecond: Offset(40, 0)),
                numberOfReps: 3,
                style: TextStyle(
                    color: allRead.contains(manga.scans[index].name)
                        ? Colors.grey
                        : Colors.white),
              ))
            ],
          ),
        ));
  }
}

class MangaChapterList extends StatelessWidget {
  final Chapter scan;
  final Color color;
  final bool hasRead;

  const MangaChapterList({Key? key, required this.scan, required this.color, required this.hasRead})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 70,
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              child: Row(children: [
                Container(
                  width: 120,
                  child: Placeholder(),
                  padding: EdgeInsets.only(right: 10),
                ),
                Expanded(
                    child: TextScroll(
                  extractChapterNumber(scan.name),
                  style: TextStyle(color: hasRead ? Colors.grey : Colors.white),
                ))
              ]),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: IconButton(
                onPressed: () => {print('download')},
                icon: Icon(Icons.download, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MangaPageInformation extends StatelessWidget {
  const _MangaPageInformation(
      {required this.data,
      required this.height,
      required this.state,
      required this.opacityMain,
      required this.opacitySec,
      required this.informationTranslation,
      required this.maxWidth,
      required this.maxheight});
  final MangaInfo data;
  final double height;
  final MangaInfoState state;
  final double opacityMain;
  final double opacitySec;
  final double informationTranslation;
  final double maxWidth;
  final double maxheight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 3,
          child: Container(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.network(
                        data.img,
                        headers: {'Referer': 'https://readmanganato.com/'},
                        fit: BoxFit.cover,
                      ).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      width: 500,
                      height: 420,
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.0)),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Transform.translate(
                    offset: Offset(0, -informationTranslation),
                    child: AnimatedOpacity(
                      duration: 10.ms,
                      opacity: opacityMain,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 50),
                          child: Image.network(
                            data.img,
                            headers: {'Referer': 'https://readmanganato.com/'},
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: 100.ms,
                  opacity: 1 - opacityMain,
                  child: Container(
                    color: data.color,
                    width: maxWidth,
                    height: 440,
                  ),
                ),
                AnimatedOpacity(
                  duration: 100.ms,
                  opacity: opacityMain,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon:
                          Icon(Icons.arrow_back_outlined, color: Colors.white)),
                ),
                BlocBuilder<FavoriteCubit, FavoriteState>(
                  bloc: BlocProvider.of<FavoriteCubit>(context)
                    ..getIsFavorite(data),
                  builder: (context, state) {
                    return Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () => context
                              .read<FavoriteCubit>()
                              .switchFavorite(data),
                          icon: Icon(
                            state.isFav == false
                                ? Icons.favorite_border
                                : Icons.favorite,
                            color: state.isFav == false
                                ? Colors.white
                                : Colors.red,
                          )),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Transform.translate(
            offset: Offset(0, -informationTranslation),
            child: AnimatedOpacity(
              duration: 10.ms,
              opacity: opacitySec,
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: TextScroll(
                  data.name + '    ',
                  fadedBorder: true,
                  fadedBorderWidth: 0.1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w500,
                  ),
                  delayBefore: Duration(seconds: 1),
                  velocity: Velocity(pixelsPerSecond: Offset(40, 0)),
                  intervalSpaces: 10,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Transform.translate(
            offset: Offset(0, -informationTranslation),
            child: AnimatedOpacity(
              duration: 10.ms,
              opacity: opacitySec,
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Text(
                  data.author.label + ' · ' + state.info.status,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
