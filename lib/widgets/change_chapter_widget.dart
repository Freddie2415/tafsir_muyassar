import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:tafsiri_muyassar/widgets/ayat_default_text.dart';

class ChangeChapterWidget extends StatelessWidget {
  final String title;
  final String arabTitle;
  final bool prev;

  const ChangeChapterWidget({
    Key? key,
    required this.title,
    required this.arabTitle,
    required this.prev,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(right: 70),
      constraints: const BoxConstraints(
        minHeight: 60,
      ),
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
        leading: Icon(
          prev ? Icons.arrow_upward : Icons.arrow_downward,
          color: Colors.white,
        ),
        subtitle: AyatDefaultText(
          title: title,
          textStyle: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.left,
        ),
        title: Text(
          arabTitle,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
