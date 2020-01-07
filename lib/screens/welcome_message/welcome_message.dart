import 'package:animu/screens/welcome_message/welcome_message_preview.dart';
import 'package:animu/screens/welcome_message/welcome_message_settings.dart';
import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeMessage extends StatelessWidget {
  final AnimuRepository animuRepository;

  WelcomeMessage({@required this.animuRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Message'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: BlocProvider(
            create: (context) =>
                WelcomeMessageSettingsBloc(animuRepository: animuRepository)
                  ..add(
                    FetchWelcomeMessageSettings(),
                  ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                WelcomeMessageSettings(),
                WelcomeMessagePreview(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
