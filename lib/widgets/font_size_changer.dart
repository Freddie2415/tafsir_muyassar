import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsiri_muyassar/bloc/font/font_bloc.dart';

class FontSizeChanger extends StatelessWidget {
  const FontSizeChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FontBloc fontBloc = BlocProvider.of<FontBloc>(context);

    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Theme.of(context).dividerColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 13,
            icon: const Icon(Icons.remove),
            onPressed: () => fontBloc.add(ChangeFontSizeEvent(decrease: true)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: BlocBuilder<FontBloc, FontState>(
              builder: (context, state) {
                return Text(state.fontScaling.toStringAsFixed(1));
              },
            ),
          ),
          IconButton(
            iconSize: 13,
            icon: const Icon(Icons.add),
            onPressed: () => fontBloc.add(ChangeFontSizeEvent(decrease: false)),
          ),
        ],
      ),
    );
  }
}
