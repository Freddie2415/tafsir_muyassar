import 'package:flutter/material.dart';
import 'package:tafsiri_muyassar/generated/locale_keys.g.dart';
import 'package:tafsiri_muyassar/widgets/font_size_changer.dart';
import 'package:tafsiri_muyassar/widgets/locale_switcher.dart';
import 'package:tafsiri_muyassar/widgets/theme_switcher.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.dark_mode_outlined),
          title: Text(LocaleKeys.nightMode.tr()),
          trailing: const ThemeSwitcher(),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.font_download_outlined),
          title: Text(LocaleKeys.fontSize.tr()),
          trailing: const FontSizeChanger(),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.language_outlined),
          title: Text(LocaleKeys.chooseLanguage.tr()),
          trailing: const LocaleSwitcher(),
        )
      ],
    );
  }
}
