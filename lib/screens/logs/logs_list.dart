import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

class LogsList extends StatefulWidget {
  @override
  _LogsListState createState() => _LogsListState();
}

class _LogsListState extends State<LogsList> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  LogsBloc _logsBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _logsBloc = BlocProvider.of<LogsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogsBloc, LogsState>(
      builder: (context, state) {
        print(state);
        if (state is LogsUninitialized)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (state is LogsLoaded) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.hasReachedMax
                  ? state.logs.length
                  : state.logs.length + 1,
              itemBuilder: (BuildContext context, int i) {
                return i >= state.logs.length
                    ? BottomLoader()
                    : Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(state.logs[i].imageUrl),
                            child: Align(
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.message,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                radius: 8,
                              ),
                              alignment: Alignment.bottomRight,
                            ),
                          ),
                          title: Text(
                            state.logs[i].log.length > 50
                                ? '${state.logs[i].log.substring(0, 50)}...'
                                : state.logs[i].log,
                          ),
                          subtitle: Text(
                              '${state.logs[i].user} • ${timeago.format(state.logs[i].time)}'),
                        ),
                      );
              },
              controller: _scrollController,
            ),
          );
        }

        if (state is LogsError)
          return Text(
            'An unexpected error occurred',
            style: TextStyle(color: Colors.grey),
          );

        return Text('...');
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _logsBloc.add(FetchLogs());
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
