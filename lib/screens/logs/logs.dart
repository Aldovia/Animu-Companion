import 'package:animu_common/animu_common.dart';
import 'package:animu/screens/logs/logs_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class Logs extends StatelessWidget {
  final AnimuRepository animuRepository;

  Logs({@required this.animuRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Logs',
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            BlocProvider(
              create: (context) {
                return LogsBloc(animuRepository: animuRepository)
                  ..add(FetchLogs());
              },
              child: LogsList(),
            ),
          ],
        ),
      ),
    );
  }
}
