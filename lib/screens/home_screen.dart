import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsiri_muyassar/generated/locale_keys.g.dart';

import '../bloc/last_read/last_read_cubit.dart';
import '../widgets/favorite_list.dart';
import '../widgets/juzs_list.dart';
import '../widgets/last_read_widget.dart';
import '../widgets/layout_drawer.dart';
import '../widgets/surahs_list.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  static route() => CupertinoPageRoute(builder: (context) => HomeScreen());

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: LayoutDrawer(),
        body: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: false,
                title: const Text('Tafsir Muyassar'),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, SearchScreen.route());
                    },
                    icon: const Icon(Icons.search),
                  )
                ],
              ),
              BlocBuilder<LastReadCubit, LastReadState>(
                builder: (context, state) {
                  if (state is LastReadSaved) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 25),
                        child: LastReadWidget(),
                      ),
                    );
                  }

                  return SliverPersistentHeader(
                    pinned: false,
                    floating: false,
                    delegate: _SliverAppBarDelegate(
                      minHeight: 0,
                      maxHeight: 0,
                      child: const SizedBox(),
                    ),
                  );
                },
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 60,
                  maxHeight: 60,
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: TabBar(
                      indicatorColor: const Color(0XFF672CBC),
                      labelColor: Theme.of(context).textTheme.bodyText1?.color,
                      indicatorWeight: 3,
                      labelPadding: const EdgeInsets.symmetric(vertical: 15),
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                      unselectedLabelColor: const Color(
                        0XFF8789A3,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                      tabs: [
                        Text(LocaleKeys.surahs.tr()),
                        Text(LocaleKeys.juzlar.tr()),
                        Text(LocaleKeys.hatchuplar.tr()),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SurahsList(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: JuzsList(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: FavoritesList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
