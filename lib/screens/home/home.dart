import 'package:animu_common/animu_common.dart';
import 'package:animu/screens/home/guild_info.dart';
import 'package:animu/screens/home/charts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AnimuRepository animuRepository;

  Home({@required this.animuRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              // Guild Info
              BlocProvider(
                create: (context) {
                  return GuildBloc(animuRepository: animuRepository)
                    ..add(FetchGuild());
                },
                child: GuildInfo(),
              ),

              // Charts
              BlocProvider(
                create: (context) {
                  return ChartsBloc(animuRepository: animuRepository)
                    ..add(FetchCharts(growthCycle: 7, joinedCycle: 7));
                },
                child: Container(
                  constraints: BoxConstraints(minWidth: 350, minHeight: 350),
                  child: Charts(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
