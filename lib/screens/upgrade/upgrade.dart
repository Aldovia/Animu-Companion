import 'package:animu/screens/upgrade/upgrade_card.dart';
import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Upgrade extends StatelessWidget {
  final AnimuRepository animuRepository;
  Upgrade({@required this.animuRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upgrade',
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: BlocProvider(
          create: (context) =>
              GuildBloc(animuRepository: animuRepository)..add(FetchGuild()),
          child: UpgradeCard(),
        ),
      ),
    );
  }
}
