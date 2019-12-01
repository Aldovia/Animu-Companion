import 'package:animu/bloc/events/auth_event.dart';
import 'package:animu/bloc/repos/auth_repo.dart';
import 'package:animu/bloc/states/auth_state.dart';
import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;

  AuthenticationBloc({@required this.authRepository})
      : assert(authRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await authRepository.hasToken();

      if (hasToken) {
        final String token = await authRepository.getToken();

        final dynamic isValidToken =
            await authRepository.authenticate(token: token);

        if (isValidToken != false)
          yield AuthenticationAuthenticated(token: token);
        else {
          await authRepository.deleteToken();
          yield AuthenticationUnauthenticated();
        }
      } else
        yield AuthenticationUnauthenticated();
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await authRepository.persistToken(event.token);
      yield AuthenticationAuthenticated(token: event.token);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await authRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
