import 'package:animu/bloc/blocs/auth_bloc.dart';
import 'package:animu/bloc/events/auth_event.dart';
import 'package:animu/bloc/repos/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:animu/bloc/events/login_event.dart';
import 'package:animu/bloc/states/login_state.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.authRepository, @required this.authenticationBloc})
      : assert(authRepository != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final bool isTokenValid =
            await authRepository.authenticate(token: event.token);

        if (isTokenValid)
          authenticationBloc.add(LoggedIn(token: event.token));
        else
          yield LoginFailure(error: 'Invalid Token');
      } catch (e) {
        print(e);
        yield LoginFailure(error: e.toString());
      }
    }
  }
}
