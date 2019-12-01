import 'package:animu/bloc/events/levels_event.dart';
import 'package:animu/bloc/repos/animu_repo.dart';
import 'package:animu/bloc/states/levels_state.dart';
import 'package:animu/models/settings.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class LevelsBloc extends Bloc<LevelsEvent, LevelsState> {
  final AnimuRepository animuRepository;

  LevelsBloc({@required this.animuRepository})
      : assert(animuRepository != null);

  @override
  LevelsState get initialState => LevelsInitial();

  @override
  Stream<LevelsState> mapEventToState(
    LevelsEvent event,
  ) async* {
    yield LevelsLoading();

    if (event is FetchLevels) {
      try {
        final Settings settings = await animuRepository.getSettings();

        if (settings.enableLevels)
          yield LevelsOn();
        else
          yield LevelsOff();
      } catch (e) {
        LevelsError();
      }
    }

    if (event is ToggleLevels) {
      try {
        final Settings settings = await animuRepository.updateSettings(
            key: 'enableLevels', value: event.val);

        if (settings.enableLevels)
          yield LevelsOn();
        else
          yield LevelsOff();
      } catch (e) {
        LevelsError();
      }
    }
  }
}
