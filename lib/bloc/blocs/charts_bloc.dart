import 'package:animu/bloc/events/charts_event.dart';
import 'package:animu/bloc/repos/animu_repo.dart';
import 'package:animu/bloc/states/charts_state.dart';
import 'package:animu/models/time_series_members.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class ChartsBloc extends Bloc<ChartsEvent, ChartsState> {
  final AnimuRepository animuRepository;

  ChartsBloc({@required this.animuRepository})
      : assert(animuRepository != null);

  @override
  ChartsState get initialState => ChartsEmpty();

  @override
  Stream<ChartsState> mapEventToState(ChartsEvent event) async* {
    if (event is FetchCharts) {
      yield ChartsLoading();

      try {
        final List<List<TimeSeriesMembers>> charts =
            await animuRepository.getCharts(
                growthCycle: event.growthCycle, joinedCycle: event.joinedCycle);

        yield ChartsLoaded(growthRate: charts[0], joinedRate: charts[1]);
      } catch (e) {
        yield ChartsError();
      }
    }
  }
}
