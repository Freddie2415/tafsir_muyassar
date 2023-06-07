import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tafsiri_muyassar/bloc/feedback/feedback_cubit.dart';
import 'package:tafsiri_muyassar/generated/locale_keys.g.dart';
import 'package:tafsiri_muyassar/widgets/layout_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tafsiri_muyassar/widgets/layout_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController comment = TextEditingController();

  FeedbackScreen({Key? key}) : super(key: key);

  static route() => CupertinoPageRoute(builder: (context) => FeedbackScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LayoutAppBar(
        title: LocaleKeys.feedback.tr(),
      ),
      body: LayoutBody(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.requiredField.tr();
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: LocaleKeys.name.tr(),
                  ),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.requiredField.tr();
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                        .hasMatch(value)) {
                      return LocaleKeys.invalidEmail.tr();
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: comment,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.requiredField.tr();
                    }
                    return null;
                  },
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  maxLines: 6,
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocConsumer<FeedbackCubit, FeedbackState>(
                      listener: _feedbackListener,
                      builder: (context, state) {
                        return FloatingActionButton(
                          backgroundColor: Colors.deepPurple,
                          onPressed: state is FeedbackSending
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<FeedbackCubit>(context)
                                        .send(
                                      name.text,
                                      email.text,
                                      comment.text,
                                    );
                                  }
                                },
                          child: state is FeedbackSending
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                )
                              : const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _feedbackListener(context, state) {
    if (state is FeedbackFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.message,
            maxLines: 3,
          ),
          backgroundColor: Colors.deepPurple,
        ),
      );
    }

    if (state is FeedbackSent) {
      name.clear();
      email.clear();
      comment.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Rahmat, xabaringiz yuborildi',
            maxLines: 3,
          ),
          backgroundColor: Colors.deepPurple,
        ),
      );
    }
  }
}
