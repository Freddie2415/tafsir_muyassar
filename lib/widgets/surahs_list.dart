import 'package:flutter/material.dart';
import 'package:tafsiri_muyassar/bloc/surahs/surahs_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsiri_muyassar/screens/reader_screen.dart';
import 'package:tafsiri_muyassar/widgets/list_item_arabic_title.dart';
import 'package:tafsiri_muyassar/widgets/list_item_number.dart';
import 'package:tafsiri_muyassar/widgets/list_item_title.dart';
import 'package:easy_localization/easy_localization.dart';

class SurahsList extends StatefulWidget {
  const SurahsList({Key? key}) : super(key: key);

  @override
  State<SurahsList> createState() => _SurahsListState();
}

class _SurahsListState extends State<SurahsList> {
  @override
  void initState() {
    final SurahsBloc surahsBloc = BlocProvider.of(context);
    surahsBloc.add(GetSurahsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahsBloc, SurahsState>(
      builder: (context, state) {
        return ListView.separated(
            padding: const EdgeInsets.all(0),
            itemCount: state.surahs.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final surah = state.surahs[index];
              return ListTile(
                title: ListItemTitle(
                  title: surah.getTitle(context.locale),
                ),
                leading: ListItemNumber(number: index + 1),
                trailing: ListItemArabicTitle(
                  title: surah.arabTitle,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                onTap: () {
                  Navigator.push(context, ReaderScreen.route(chapter: surah));
                },
              );
            });
      },
    );
  }
}
