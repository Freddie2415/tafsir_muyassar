import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tafsiri_muyassar/generated/locale_keys.g.dart';
import 'package:tafsiri_muyassar/widgets/layout_app_bar.dart';
import 'package:tafsiri_muyassar/widgets/layout_body.dart';
import 'package:tafsiri_muyassar/widgets/settings_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static route() =>
      CupertinoPageRoute(builder: (context) => SettingsScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LayoutAppBar(title: LocaleKeys.settings.tr()),
      body: LayoutBody(
          child: SettingsWidget()),
    );
  }
}
