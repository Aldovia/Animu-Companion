import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeMessagePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 8.0,
            ),
            child: Text(
              'Preview',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: BlocBuilder<WelcomeMessageSettingsBloc,
                  WelcomeMessageSettingsState>(
                builder: (context, state) {
                  if (state is WelcomeMessageSettingsLoading)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  if (state is WelcomeMessageSettingsLoaded)
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${state.guild.owner.username}, Welcome to ${state.guild.name}',
                          style: Theme.of(context).textTheme.title,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(state.settings.welcomeMessage ?? ''),
                        SizedBox(
                          height: 20.0,
                        ),
                        ClipRRect(
                          borderRadius: new BorderRadius.circular(8.0),
                          child: Image(
                            image: NetworkImage(state
                                    .settings.welcomeImageURL ??
                                'https://via.placeholder.com/1920x1080?text=No%20image%20added%20yet'),
                          ),
                        ),
                      ],
                    );

                  if (state is WelcomeMessageSettingsError)
                    return Center(
                      child: Text('An unexpected error occured'),
                    );

                  return Text('...');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
