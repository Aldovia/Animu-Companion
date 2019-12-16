import 'package:animu_common/animu_common.dart';
import 'package:animu/screens/levels/level_perks_fab.dart';
import 'package:animu/screens/levels/level_perks_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelPerks extends StatelessWidget {
  final AnimuRepository animuRepository;

  LevelPerks({@required this.animuRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LevelPerksBloc(animuRepository: animuRepository)
          ..add(FetchLevelPerks());
      },
      child: Scaffold(
        body: LevelPerksList(),
        floatingActionButton: LevelPerksFAB(),
      ),
    );
  }
}
