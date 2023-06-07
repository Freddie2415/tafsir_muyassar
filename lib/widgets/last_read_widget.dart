import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsiri_muyassar/bloc/last_read/last_read_cubit.dart';
import 'package:tafsiri_muyassar/generated/locale_keys.g.dart';
import 'package:tafsiri_muyassar/screens/reader_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class LastReadWidget extends StatelessWidget {
  const LastReadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastReadCubit, LastReadState>(
      builder: (context, state) {
        if (state is LastReadSaved) {
          return GestureDetector(
            onTap: () => Navigator.push(
                context, ReaderScreen.route(chapter: state.chapter)),
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 165,
                minWidth: double.infinity,
              ),
              padding: const EdgeInsets.only(
                  left: 10, top: 20, bottom: 20, right: 150),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: Svg('assets/images/quran.svg'),
                  alignment: FractionalOffset.bottomRight,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0XFFDB95FA),
                    Color(0XFF965AFF),
                  ],
                ),
              ),
              child: ListTile(
                title: Row(children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.menu_book_outlined,
                                  color: Colors.white),
                              const SizedBox(width: 10),
                              Text(
                                LocaleKeys.lastRead.tr(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            state.chapter.getTitle(context.locale),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${LocaleKeys.oyat.tr()} №: ${state.ayat.number}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          )
                        ]),
                  ),
                ]),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
