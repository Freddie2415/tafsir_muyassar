import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsiri_muyassar/bloc/juzs/juzs_bloc.dart';
import 'package:tafsiri_muyassar/screens/reader_screen.dart';
import 'package:tafsiri_muyassar/widgets/list_item_arabic_title.dart';
import 'package:tafsiri_muyassar/widgets/list_item_number.dart';
import 'package:tafsiri_muyassar/widgets/list_item_title.dart';
import 'package:easy_localization/easy_localization.dart';

class JuzsList extends StatefulWidget {
  const JuzsList({Key? key}) : super(key: key);

  @override
  State<JuzsList> createState() => _JuzsListState();
}

class _JuzsListState extends State<JuzsList> {
  @override
  void initState() {
    final JuzsBloc juzsBloc = BlocProvider.of(context);
    juzsBloc.add(GetJuzsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JuzsBloc, JuzsState>(builder: (context, state) {
      return ListView.separated(
          padding: const EdgeInsets.all(0),
          itemCount: state.juzs.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final juz = state.juzs[index];

            return ListTile(
              title: ListItemTitle(
                title: juz.getTitle(context.locale),
              ),
              // subtitle: Text(juzList[index].subtitle),
              leading: ListItemNumber(number: index + 1),
              trailing: ListItemArabicTitle(
                title: juz.arabTitle,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              onTap: () {
                Navigator.push(context, ReaderScreen.route(chapter: juz));
              },
            );
          });
    });
  }
}
