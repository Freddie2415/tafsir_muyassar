import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tafsiri_muyassar/application.dart';
import 'package:tafsiri_muyassar/bloc/feedback/feedback_cubit.dart';
import 'package:tafsiri_muyassar/bloc/font/font_bloc.dart';
import 'package:tafsiri_muyassar/bloc/juzs/juzs_bloc.dart';
import 'package:tafsiri_muyassar/bloc/search/search_cubit.dart';
import 'package:tafsiri_muyassar/bloc/show_translation_cubit.dart';
import 'package:tafsiri_muyassar/bloc/surahs/surahs_bloc.dart';
import 'package:tafsiri_muyassar/bloc/sync_book/sync_book_cubit.dart';
import 'package:tafsiri_muyassar/bloc/theme/theme_bloc.dart';
import 'package:tafsiri_muyassar/generated/codegen_loader.g.dart';
import 'package:tafsiri_muyassar/models/ayat.dart';
import 'package:tafsiri_muyassar/repositories/local/box_repository.dart';

import 'bloc/favorites/favorites_cubit.dart';
import 'bloc/last_read/last_read_cubit.dart';
import 'models/juz.dart';
import 'models/surah.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  // init hive db
  await Hive.initFlutter();

  // await Hive.deleteBoxFromDisk('ayatBox');
  // await Hive.deleteBoxFromDisk('surahsBox');
  // await Hive.deleteBoxFromDisk('juzsBox');
  // await Hive.deleteBoxFromDisk('bookVersion');

  Hive.registerAdapter<Ayat>(AyatAdapter());
  Hive.registerAdapter<Surah>(SurahAdapter());
  Hive.registerAdapter<Juz>(JuzAdapter());

  await Hive.openBox<String>('bookVersion');
  await Hive.openBox<Ayat>('ayatBox');
  await Hive.openBox<Surah>('surahsBox');
  await Hive.openBox<Juz>('juzsBox');

  await EasyLocalization.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  final bookVersinoRepo = BoxRepository<String>('bookVersion');
  final ayatBoxRepo = BoxRepository<Ayat>('ayatBox');
  final surahBoxRepo = BoxRepository<Surah>('surahsBox');
  final juzsBoxRepo = BoxRepository<Juz>('juzsBox');

  var repositoryProviders = [
    RepositoryProvider(create: (context) => bookVersinoRepo),
    RepositoryProvider(create: (context) => ayatBoxRepo),
    RepositoryProvider(create: (context) => surahBoxRepo),
    RepositoryProvider(create: (context) => juzsBoxRepo),
  ];

  var blocProviders = [
    BlocProvider(create: (context) => FeedbackCubit()),
    BlocProvider(
      create: (context) => SyncBookCubit(
        surahBox: surahBoxRepo,
        ayatBox: ayatBoxRepo,
        juzsBox: juzsBoxRepo,
      )..sync(),
    ),
    BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(preferences)
        ..add(
          SetDefaultThemeEvent(),
        ),
    ),
    BlocProvider<FontBloc>(
      create: (context) => FontBloc(preferences)
        ..add(
          SetDefaultFontSizeEvent(),
        ),
    ),
    BlocProvider<JuzsBloc>(create: (context) => JuzsBloc(juzsBoxRepo)),
    BlocProvider<SurahsBloc>(create: (context) => SurahsBloc(surahBoxRepo)),
    BlocProvider<LastReadCubit>(
      create: (context) => LastReadCubit(
        ayatBox: ayatBoxRepo,
        surahBox: surahBoxRepo,
        juzBox: juzsBoxRepo,
      ),
    ),
    BlocProvider<FavoritesCubit>(
      create: (context) => FavoritesCubit(
        ayatBox: ayatBoxRepo,
        surahBox: surahBoxRepo,
      ),
    ),
    BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(
        ayatBox: ayatBoxRepo,
        surahBox: surahBoxRepo,
        juzBox: juzsBoxRepo,
      ),
    ),
    BlocProvider<ShowTranslationCubit>(
      create: (context) =>
          ShowTranslationCubit(preferences)..setDefaultTranslationState(),
    ),
  ];

  runApp(
    MultiBlocProvider(
      providers: blocProviders,
      child: EasyLocalization(
        supportedLocales: const [
          Locale('uz', 'CYRL'),
          Locale('uz'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('uz', 'CYRL'),
        assetLoader: const CodegenLoader(),
        child: MultiRepositoryProvider(
          providers: repositoryProviders,
          child: const Application(),
        ),
      ),
    ),
  );
}
