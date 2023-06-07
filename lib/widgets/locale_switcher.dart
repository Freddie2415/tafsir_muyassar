import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocaleSwitcher extends StatefulWidget {
  const LocaleSwitcher({Key? key}) : super(key: key);

  @override
  State<LocaleSwitcher> createState() => _LocaleSwitcherState();
}

class _LocaleSwitcherState extends State<LocaleSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<Locale>(
        underline: const SizedBox(),
        value: context.locale,
        items: const [
          DropdownMenuItem(
            value: Locale('uz', 'CYRL'),
            child: Text('Ўзбекча'),
          ),
          DropdownMenuItem(
            value: Locale('uz'),
            child: Text('O\'zbekcha'),
          )
        ],
        onChanged: (Locale? value) async {
          if (value != null) {
            await context.setLocale(value);
          }
        },
      ),
    );
  }
}
