import 'package:animu/bloc/blocs/login_bloc.dart';
import 'package:animu/bloc/events/login_event.dart';
import 'package:animu/bloc/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _tokenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(token: _tokenController.text),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => Container(
          width: 300.0,
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 30.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Animu Token',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[400],
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Material(
                      elevation: 10.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 40.0,
                          right: 20.0,
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        child: TextFormField(
                          controller: _tokenController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "XXXXXXXXXXXXXXXX",
                            hintStyle: TextStyle(
                              color: Color(0xFFE1E1E1),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 125.0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 35, 15, 0),
                                child: Text(
                                  'Enter your Animu Token',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.0,
                                  ),
                                ),
                              ),
                            ),
                            CircularGradientButton(
                              child: state is LoginLoading
                                  ? CircularProgressIndicator()
                                  : Icon(Icons.arrow_forward),
                              callback: state is! LoginLoading
                                  ? _onLoginButtonPressed
                                  : null,
                              gradient: Gradients.cosmicFusion,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
