import 'package:animu/bloc/events/level_perks_event.dart';
import 'package:animu/bloc/repos/animu_repo.dart';
import 'package:animu/bloc/states/level_perks_state.dart';
import 'package:animu/models/level_perk.dart';
import 'package:animu/models/role.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class LevelPerksBloc extends Bloc<LevelPerksEvent, LevelPerksState> {
  final AnimuRepository animuRepository;

  LevelPerksBloc({@required this.animuRepository})
      : assert(animuRepository != null);

  @override
  LevelPerksState get initialState => LevelPerksEmpty();

  @override
  Stream<LevelPerksState> mapEventToState(
    LevelPerksEvent event,
  ) async* {
    if (event is FetchLevelPerks) {
      yield LevelPerksLoading();

      try {
        final List<dynamic> data = await animuRepository.getLevelPerks();

        final List<LevelPerk> levelPerks = data[0];
        final List<Role> roles = data[1];
        yield LevelPerksLoaded(levelPerks: levelPerks, roles: roles);
      } catch (e) {
        LevelPerksError();
      }
    }

    if (event is CreateLevelPerk) {
      try {
        final List<dynamic> data = await animuRepository.createLevelPerk(
            level: event.level,
            perkName: event.perkName,
            perkValue: event.perkValue);

        final List<LevelPerk> levelPerks = data[0];
        final List<Role> roles = data[1];
        yield LevelPerksLoaded(levelPerks: levelPerks, roles: roles);
      } catch (e) {
        LevelPerksError();
      }
    }
  }
}
