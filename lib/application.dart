import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsiri_muyassar/bloc/sync_book/sync_book_cubit.dart';
import 'package:tafsiri_muyassar/bloc/theme/theme_bloc.dart';
import 'package:tafsiri_muyassar/screens/error_screen.dart';
import 'package:tafsiri_muyassar/screens/home_screen.dart';
import 'package:tafsiri_muyassar/theme.dart';
import 'package:easy_localization/easy_localization.dart';

import 'screens/sync_book_screen.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeBloc theme = BlocProvider.of<ThemeBloc>(context, listen: true);

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode: theme.state.isDark ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: BlocConsumer<SyncBookCubit, SyncBookState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SyncBookSuccess) {
            return HomeScreen();
          }

          if (state is SyncBookFailure) {
            return ErrorScreen(
              message: state.message,
              onRetry: () {
                BlocProvider.of<SyncBookCubit>(context).sync();
              },
            );
          }

          return SyncBookScreen(
            message: state is SyncBookLoading ? state.message : 'Loading...',
          );
        },
      ),
    );
  }
}
