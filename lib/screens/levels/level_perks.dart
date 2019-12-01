import 'package:animu/bloc/blocs/level_perks_bloc.dart';
import 'package:animu/bloc/events/level_perks_event.dart';
import 'package:animu/bloc/repos/animu_repo.dart';
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
      builder: (context) {
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
