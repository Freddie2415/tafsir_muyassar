import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tafsiri_muyassar/widgets/ayat_arab_text.dart';
import 'package:tafsiri_muyassar/widgets/layout_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tafsiri_muyassar/generated/locale_keys.g.dart';
import 'package:tafsiri_muyassar/widgets/layout_body.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  static route() => CupertinoPageRoute(builder: (context) => AboutScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LayoutAppBar(title: LocaleKeys.about.tr()),
      body: LayoutBody(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                AyatArabText(title: 'التَّفْسِيرُ الْمُيَسَّرُ'),
                SizedBox(height: 15),
                AyatArabText(title: '(بِاللُّغَةِ الْأُوزْبَكِيَّةِ)'),
                SizedBox(height: 20),
                AyatArabText(title: 'إِعْدَادُ نُخْبَةٍ مِنَ الْعُلَمَاءِ'),
                SizedBox(height: 35),
                Text(
                  'ТАФСИРИ МУЯССАР',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text('Қуръоннинг енгил тафсири'),
                SizedBox(height: 35),
                Text(
                  'Саудия Арабистони Исломий ишлар, вақфлар, даъват ва иршод вазирлигига қарашли Қирол Фаҳд номли Қуръони Каримни чоп этиш муассасаси илмий ишлар маркази қошида бир гуруҳ уламолар томонидан тайёрланган Мадинаи Мунаввара шаҳри',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 35),
                Text('Таржимон: Исмоил Яъқуб'),
                SizedBox(height: 20),
                Text('Масъул муҳаррирлар: Неъматуллоҳ Ҳамидов'),
                SizedBox(height: 20),
                Text('(Абдулҳафиз домла)'),
                SizedBox(height: 20),
                Text('Адҳам Абдулмўмин ўғли Олим'),
                SizedBox(height: 50),
                Text(
                  'Истиоза',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                AyatArabText(
                    title: 'أَعُوذُ بِاللهِ مِنَ الشَّيْطَانِ الرَّجِيمِ'),
                SizedBox(height: 15),
                Text(
                    '“Мени Роббимнинг тоатидан ва Унинг китобини тиловат қилишдан тўсадиган, Аллоҳнинг раҳматидан қувилган ҳар бир туғёнкор инсу жиндан ягона Аллоҳнинг ўзидан паноҳ сўрайман”.'),
                SizedBox(height: 15),
                Text(
                    'Аллоҳ Таоло Қуръон ўқимоқчи бўлган ҳар бир кишига шайтони лаиндан паноҳ тилашни буюриб: “Эй мўмин, Қуръон ўқимоқчи бўлганингда Аллоҳнинг раҳматидан қувилган шайтоннинг ёмонлигидан Аллоҳдан паноҳ тила!” – деди (“Наҳл” сураси, 98-оят). Чунки Қуръони Карим одамлар учун ҳидоят, қалб касалликлари учун шифо, шайтон эса барча ёмонлик ва залолатлар сабабчисидир. Шунинг учун Аллоҳ субҳанаҳу ва таоло ҳар бир Қуръон ўқувчи кишини шайтони лаиндан, унинг васвасалари ва малайларидан Ўзидан паноҳ сўрашга буюрди.'),
                SizedBox(height: 15),
                Text(
                    'Уламолар истиозани Қуръони Каримнинг ояти эмаслигига иттифоқ қилганлар, шунинг учун у мусҳафларда ёзилмаган.'),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
