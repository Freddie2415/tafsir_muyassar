import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tafsiri_muyassar/bloc/favorites/favorites_cubit.dart';
import 'package:tafsiri_muyassar/bloc/juzs/juzs_bloc.dart';
import 'package:tafsiri_muyassar/bloc/last_read/last_read_cubit.dart';
import 'package:tafsiri_muyassar/bloc/surahs/surahs_bloc.dart';
import 'package:tafsiri_muyassar/models/ayat.dart';
import 'package:tafsiri_muyassar/models/juz.dart';
import 'package:tafsiri_muyassar/widgets/ayat_widget.dart';
import 'package:tafsiri_muyassar/widgets/change_chapter_widget.dart';
import 'package:tafsiri_muyassar/widgets/layout_app_bar.dart';
import 'package:tafsiri_muyassar/widgets/settings_widget.dart';
import 'package:tafsiri_muyassar/widgets/show_translation_button.dart';
import 'package:easy_localization/easy_localization.dart';

import '../models/chapter.dart';
import '../widgets/slider_router.dart';

class ReaderScreen extends StatefulWidget {
  final Chapter chapter;
  final Ayat? ayat;

  const ReaderScreen({
    Key? key,
    required this.chapter,
    this.ayat,
  }) : super(key: key);

  static route({required Chapter chapter, Ayat? ayat}) {
    return CupertinoPageRoute(
      builder: (context) => ReaderScreen(
        chapter: chapter,
        ayat: ayat,
      ),
    );
  }

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  int currentIndex = 0;
  bool showSlider = false;

  @override
  void initState() {
    itemPositionsListener.itemPositions.addListener(_positionListener);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _jumpToLastRead(ayat: widget.ayat));

    super.initState();
  }

  void _positionListener() {
    if (mounted) {
      int? index;
      try {
        index = itemPositionsListener.itemPositions.value.first.index;

        if (index != currentIndex) {
          setState(() {
            currentIndex = index!;
            final Ayat? currentAyat = widget.chapter.ayats?[currentIndex];
            if (currentAyat != null) {
              BlocProvider.of<LastReadCubit>(context)
                  .setLastRead(widget.chapter, currentAyat);
            }
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void _jumpToLastRead({Ayat? ayat}) {
    ayat ??= widget.chapter.lastReadAyat;

    if (mounted) {
      if (ayat != null) {
        print("LAST READ: ${ayat.id}");
        final index = widget.chapter.ayatList.indexWhere((element) {
          return element.id == ayat!.id;
        });
        if (index > 0 && itemScrollController.isAttached) {
          itemScrollController.jumpTo(index: index);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final JuzsBloc juzsBloc = BlocProvider.of(context);
    final SurahsBloc surahsBloc = BlocProvider.of(context);

    return Scaffold(
      appBar: LayoutAppBar(title: widget.chapter.getTitle(context.locale), actions: [
        const ShowTranslationButton(),
        IconButton(
          color: showSlider
              ? Theme.of(context).primaryColor
              : Theme.of(context).appBarTheme.iconTheme?.color,
          onPressed: () {
            setState(() => showSlider = !showSlider);
          },
          icon: const Icon(Icons.format_line_spacing_rounded),
        ),
        IconButton(
          onPressed: () => showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              context: context,
              builder: (BuildContext context) {
                return const SizedBox(
                  height: 220,
                  child: SettingsWidget(),
                );
              }),
          icon: const Icon(Icons.settings),
        ),
      ]),
      body: Stack(
        children: [
          ScrollablePositionedList.separated(
            separatorBuilder: (context, index) {
              return const Divider(
                height: 50,
              );
            },
            itemCount: widget.chapter.ayatList.length,
            itemBuilder: (context, index) {
              final ayat = widget.chapter.ayatList[index];
              final ayatWidget = AyatWidget(
                number: ayat.number,
                arabText: ayat.arabText,
                text: ayat.getText(context.locale),
                surahId: ayat.surahId,
                favorite: ayat.favorite,
                onFavorite: () {
                  BlocProvider.of<FavoritesCubit>(context).favorite(ayat);
                  setState(() {});
                },
              );

              final chapters = widget.chapter is Juz
                  ? juzsBloc.state.juzs
                  : surahsBloc.state.surahs;
              final chapterIdx = chapters.indexOf(widget.chapter);

              Chapter? prevChapter;
              Chapter? nextChapter;
              if (chapters.isNotEmpty) {
                prevChapter = chapters.first != widget.chapter
                    ? chapters[chapterIdx - 1]
                    : null;

                nextChapter = chapters.last != widget.chapter
                    ? chapters[chapterIdx + 1]
                    : null;
              }

              if (index == 0) {
                return Column(
                  children: [
                    if (prevChapter != null)
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            SlideRouter(
                              page: ReaderScreen(
                                chapter: prevChapter!,
                                ayat: prevChapter.ayatList.last,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 25,
                          ),
                          child: ChangeChapterWidget(
                            title: prevChapter.getTitle(context.locale ),
                            arabTitle: prevChapter.arabTitle,
                            prev: true,
                          ),
                        ),
                      ),
                    ayatWidget,
                  ],
                );
              }

              if (index == widget.chapter.ayatList.length - 1) {
                return Column(
                  children: [
                    ayatWidget,
                    if (nextChapter != null)
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            SlideRouter(
                              page: ReaderScreen(
                                chapter: nextChapter!,
                                ayat: nextChapter.ayatList.first,
                              ),
                              slideDirection: SlideDirection.bottom,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 25,
                          ),
                          child: ChangeChapterWidget(
                            title: nextChapter.getTitle(context.locale),
                            arabTitle: nextChapter.arabTitle,
                            prev: false,
                          ),
                        ),
                      ),
                  ],
                );
              }

              return ayatWidget;
            },
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          if (showSlider)
            Align(
              alignment: Alignment.centerRight,
              child: Opacity(
                opacity: 0.9,
                child: Container(
                  width: 40,
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: [
                      Text("${widget.chapter.ayatList[currentIndex].number}"),
                      Expanded(
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Slider(
                            value: currentIndex.toDouble(),
                            max: widget.chapter.ayatList.length.toDouble() - 1,
                            onChanged: (value) {
                              if (value.toInt() != currentIndex) {
                                itemScrollController.jumpTo(
                                    index: value.toInt());
                                setState(() {
                                  currentIndex = value.toInt();
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
