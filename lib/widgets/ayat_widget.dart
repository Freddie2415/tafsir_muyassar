import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tafsiri_muyassar/bloc/surahs/surahs_bloc.dart';
import 'package:tafsiri_muyassar/generated/locale_keys.g.dart';
import 'package:tafsiri_muyassar/widgets/ayat_arab_text.dart';
import 'package:tafsiri_muyassar/widgets/ayat_default_text.dart';
import 'package:easy_localization/easy_localization.dart';

class AyatWidget extends StatelessWidget {
  final String arabText;
  final int number;
  final String text;
  final int surahId;
  final bool favorite;
  final VoidCallback onFavorite;

  const AyatWidget({
    Key? key,
    required this.arabText,
    required this.number,
    required this.text,
    required this.surahId,
    required this.favorite,
    required this.onFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async {
                final SurahsBloc surahsBloc = BlocProvider.of(context);
                final surah = surahsBloc.state.surahs
                    .firstWhere((element) => element.id == surahId);

                await Share.share(
                    '${surah.getTitle(context.locale)}, ${LocaleKeys.oyat.tr()} $number\n\n $arabText \n\n $text \n\n via Tafsiri Muyassar');
              },
              icon: const Icon(Icons.share),
            ),
            IconButton(
              onPressed: onFavorite,
              color: favorite ? Colors.purple : null,
              icon: const Icon(Icons.bookmark),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: AyatArabText(title: arabText),
        ),
        const SizedBox(height: 10),
        AyatDefaultText(title: text),
      ],
    );
  }
}
