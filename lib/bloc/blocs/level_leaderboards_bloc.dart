import 'package:animu/bloc/events/level_leaderboards_event.dart';
import 'package:animu/bloc/repos/animu_repo.dart';
import 'package:animu/bloc/states/level_leaderboards_state.dart';
import 'package:animu/models/level_leaderboards_user.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class LevelLeaderboardsBloc
    extends Bloc<LevelLeaderboardsEvent, LevelLeaderboardsState> {
  final AnimuRepository animuRepository;

  LevelLeaderboardsBloc({@required this.animuRepository})
      : assert(animuRepository != null);

  @override
  LevelLeaderboardsState get initialState => LevelLeaderboardsEmpty();

  @override
  Stream<LevelLeaderboardsState> mapEventToState(
    LevelLeaderboardsEvent event,
  ) async* {
    if (event is FetchLevelLeaderboards) {
      yield LevelLeaderboardsLoading();

      try {
        final List<LevelLeaderboardsUser> leaderboardsUser =
            await animuRepository.getLevelsLeaderboard();
        yield LevelLeaderboardsLoaded(levelLeaderboardsUsers: leaderboardsUser);
      } catch (e) {
        LevelLeaderboardsError();
      }
    }
  }
}
