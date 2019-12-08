import 'package:animu/bloc/events/logs_event.dart';
import 'package:animu/bloc/repos/animu_repo.dart';
import 'package:animu/bloc/states/logs_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:animu/models/log.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  final AnimuRepository animuRepository;

  LogsBloc({@required this.animuRepository}) : assert(animuRepository != null);

  @override
  Stream<LogsState> transformEvents(
    Stream<LogsEvent> events,
    Stream<LogsState> Function(LogsEvent event) next,
  ) {
    return super.transformEvents(
      (events as Observable<LogsEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  LogsState get initialState => LogsUninitialized();

  @override
  Stream<LogsState> mapEventToState(LogsEvent event) async* {
    final currentState = state;
    if (event is FetchLogs && !_hasReachedMax(currentState)) {
      try {
        if (currentState is LogsUninitialized) {
          final List<Log> logs =
              await animuRepository.getLogs(limit: 20, offset: 0);

          yield LogsLoaded(logs: logs, hasReachedMax: false);

          return;
        }

        if (currentState is LogsLoaded) {
          final List<Log> logs = await animuRepository.getLogs(
              limit: 20, offset: currentState.logs.length);

          yield logs.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : LogsLoaded(
                  logs: currentState.logs + logs, hasReachedMax: false);
        }
      } catch (e) {
        print('Logs Error $e');
        yield LogsError();
      }
    }
  }
}

bool _hasReachedMax(LogsState state) =>
    state is LogsLoaded && state.hasReachedMax;
