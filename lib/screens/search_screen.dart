import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsiri_muyassar/bloc/search/search_cubit.dart';
import 'package:tafsiri_muyassar/generated/locale_keys.g.dart';
import 'package:tafsiri_muyassar/models/ayat.dart';
import 'package:tafsiri_muyassar/screens/reader_screen.dart';
import 'package:tafsiri_muyassar/services/debounce.dart';

import '../widgets/search_item_result.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static route() =>
      CupertinoPageRoute(builder: (context) => const SearchScreen());

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  final Debounce debounce = Debounce(milliseconds: 300);
  String query = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        BlocProvider.of<SearchCubit>(context).search("", context.locale));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 25,
        title: CupertinoSearchTextField(
          placeholder: LocaleKeys.search.tr(),
          onChanged: (String value) {
            debounce.run(() {
              BlocProvider.of<SearchCubit>(context)
                  .search(value, context.locale);
              setState(() {
                query = value;
              });
            });
          },
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<SearchCubit, List<Ayat>>(
          builder: (context, state) {
            return ListView.separated(
              itemCount: state.length,
              separatorBuilder: (context, index) => const Divider(
                height: 10,
              ),
              itemBuilder: (context, index) {
                final Ayat ayat = state[index];

                return SearchItemResult(
                  title:
                      "${ayat.chapter?.getTitle(context.locale)}, ${ayat.number}-${LocaleKeys.oyat.tr()}",
                  content: ayat.getText(context.locale),
                  query: query,
                  onSurahTap:
                      ayat.surah != null && ayat.surah!.ayatList.isNotEmpty
                          ? () {
                              ayat.chapter = ayat.surah;
                              Navigator.push(
                                context,
                                ReaderScreen.route(
                                  chapter: ayat.surah!,
                                  ayat: ayat,
                                ),
                              );
                            }
                          : null,
                  onJuzTap: ayat.juz != null && ayat.juz!.ayatList.isNotEmpty
                      ? () {
                          ayat.chapter = ayat.juz;
                          Navigator.push(
                            context,
                            ReaderScreen.route(
                              chapter: ayat.juz!,
                              ayat: ayat,
                            ),
                          );
                        }
                      : null,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
