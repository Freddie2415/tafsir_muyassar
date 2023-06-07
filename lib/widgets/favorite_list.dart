import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../bloc/favorites/favorites_cubit.dart';
import '../models/ayat.dart';
import '../screens/reader_screen.dart';
import 'list_item_number.dart';
import 'list_item_title.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, List<Ayat>>(
      builder: (context, favorites) {
        return ListView.separated(
          padding: const EdgeInsets.all(0),
          itemCount: favorites.length,
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (context, index) {
            final Ayat ayat = favorites[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  ReaderScreen.route(
                    chapter: ayat.chapter!,
                    ayat: ayat,
                  ),
                );
              },
              title: ListItemTitle(
                title: '${ayat.chapter?.getTitle(context.locale)}',
              ),
              leading: ListItemNumber(number: ayat.number),
              trailing: GestureDetector(
                onTap: () {
                  BlocProvider.of<FavoritesCubit>(context).favorite(ayat);
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.deepPurpleAccent,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            );
          },
        );
      },
    );
  }
}
