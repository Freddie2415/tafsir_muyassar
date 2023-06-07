import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tafsiri_muyassar/generated/locale_keys.g.dart';
import 'package:tafsiri_muyassar/screens/about_screen.dart';
import 'package:tafsiri_muyassar/screens/feedback_screen.dart';
import 'package:tafsiri_muyassar/screens/settings_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LayoutDrawer extends StatelessWidget {
  const LayoutDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0XFFDB95FA),
                    Color(0XFF965AFF),
                  ],
                ),
              ),
              child: Text(
                'Tafsir Muyassar',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            title: Text(LocaleKeys.about.tr()),
            leading: const Icon(Icons.book),
            onTap: () {
              Navigator.push(context, AboutScreen.route());
            },
          ),
          const Divider(height: 0, indent: 20, endIndent: 20),
          ListTile(
            title: Text(LocaleKeys.settings.tr()),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.push(context, SettingsScreen.route());
            },
          ),
          const Divider(height: 0, indent: 20, endIndent: 20),
          ListTile(
            leading: const Icon(Icons.share),
            title: Text(LocaleKeys.shareApp.tr()),
            onTap: () {
              Share.share(
                  '${LocaleKeys.downloadApp.tr()} \n https://tafsiri-muyassar.vercel.app/');
            },
          ),
          const Divider(height: 0, indent: 20, endIndent: 20),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: Text(LocaleKeys.feedback.tr()),
            onTap: () {
              Navigator.push(context, FeedbackScreen.route());
            },
          ),
          const Divider(height: 0, indent: 20, endIndent: 20),
          ListTile(
            title: Text(LocaleKeys.agreementPolicy.tr()),
            leading: const Icon(Icons.privacy_tip_outlined),
            onTap: () async {
              final Uri privacyPolicyUrl = Uri.parse(
                "https://api.tafsiri-muyassar.uz/privacy-policy",
              );
              if (!await launchUrl(privacyPolicyUrl)) {
                throw Exception('Could not launch $privacyPolicyUrl');
              }
            },
          ),
          const Divider(height: 0, indent: 20, endIndent: 20),
          const Spacer(),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.error != null) {
                return Text(snapshot.error.toString());
              }
              return Text(
                "v ${snapshot.data?.version ?? ""}+${snapshot.data?.buildNumber}",
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
