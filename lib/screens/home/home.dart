import 'package:animu/bloc/blocs/charts_bloc.dart';
import 'package:animu/bloc/blocs/guild_bloc.dart';
import 'package:animu/bloc/events/charts_event.dart';
import 'package:animu/bloc/events/guild_event.dart';
import 'package:animu/bloc/repos/animu_repo.dart';
import 'package:animu/screens/home/active_now.dart';
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
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: <Widget>[
              // Active Now
              BlocProvider(
                builder: (context) {
                  return GuildBloc(animuRepository: animuRepository)
                    ..add(FetchGuild());
                },
                child: ActiveNow(),
              ),

              // Charts
              BlocProvider(
                builder: (context) {
                  return ChartsBloc(animuRepository: animuRepository)
                    ..add(FetchCharts(growthCycle: 7, joinedCycle: 7));
                },
                child: Container(
                  constraints: BoxConstraints(minWidth: 350, minHeight: 300),
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
