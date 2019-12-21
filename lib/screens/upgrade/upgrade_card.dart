import 'package:animu/shared/constants.dart';
import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class UpgradeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuildBloc, GuildState>(
      builder: (context, state) {
        if (state is GuildLoading)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (state is GuildError)
          return Center(child: Text('An unexpected error occured'));

        if (state is GuildLoaded)
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: state.guild.tier == 'pro'
                                ? 200.0
                                : state.guild.tier != 'free' ? 50.0 : 15.0,
                            child: state.guild.tier == 'pro'
                                ? Icon(
                                    FontAwesomeIcons.crown,
                                    color: Colors.lime,
                                    size: 70.0,
                                  )
                                : state.guild.tier == 'plus'
                                    ? Icon(
                                        FontAwesomeIcons.ribbon,
                                        color: Colors.lime,
                                        size: 40.0,
                                      )
                                    : state.guild.tier == 'lite'
                                        ? Icon(
                                            FontAwesomeIcons.play,
                                            color: Colors.lime,
                                            size: 40.0,
                                          )
                                        : SizedBox(
                                            height: 0.0,
                                          ),
                          ),
                          if (state.guild.tier != 'free')
                            SizedBox(
                              height: 10.0,
                            ),
                          Text(
                            toBeginningOfSentenceCase(state.guild.tier),
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 30.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'You are using Animu ${toBeginningOfSentenceCase(state.guild.tier)}',
                            style: TextStyle(color: Colors.grey[600]),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.guild.tier != 'pro' &&
                    state.guild.tier != 'plus' &&
                    state.guild.tier != 'lite')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Lite',
                        style: Constants().headingStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.music_note,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.yellow,
                            ),
                            title: Text('Music'),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.show_chart,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.yellow,
                            ),
                            title: Text('Levelling System'),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.games,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.yellow,
                            ),
                            title: Text('Multiplayer Games'),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.yellow,
                            ),
                            title: Text('Image Manipulation Commands'),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.yellow,
                            ),
                            title: Text('Avatar Manipulation Commands'),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.yellow,
                            ),
                            title: Text('Search Commands'),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.book,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.yellow,
                            ),
                            title: Text('Read Manga'),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.tv,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.yellow,
                            ),
                            title: Text('Anime Episode Links'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GradientButton(
                        increaseWidthBy: 50.0,
                        callback: () async {
                          const url = 'https://www.patreon.com/Aldovia';
                          if (await canLaunch(url))
                            await launch(url);
                          else
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "There seems to be a problem openning the link, please open it manually: https://patreon.com/Aldovia"),
                              backgroundColor: Colors.red,
                            ));
                        },
                        child: Text('Upgrade to Lite'),
                      )
                    ],
                  ),
                if (state.guild.tier != 'pro' && state.guild.tier != 'plus')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Plus',
                        style: Constants().headingStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.red,
                            ),
                            title: Text('Everything from Animu Lite'),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.music_note,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.red,
                            ),
                            title: Text('192 Kbps music'),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.verified_user,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.red,
                            ),
                            title: Text('Verified Member Perks'),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                FontAwesomeIcons.pencilRuler,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.red,
                            ),
                            title: Text('Pixiv Command'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GradientButton(
                        increaseWidthBy: 50.0,
                        gradient: Gradients.blush,
                        callback: () async {
                          const url = 'https://www.patreon.com/Aldovia';
                          if (await canLaunch(url))
                            await launch(url);
                          else
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "There seems to be a problem openning the link, please open it manually: https://patreon.com/Aldovia"),
                              backgroundColor: Colors.red,
                            ));
                        },
                        child: Text('Upgrade to Plus'),
                      )
                    ],
                  ),
                if (state.guild.tier != 'pro')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Pro',
                        style: Constants().headingStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text('Coming Soon'),
                      ),
                    ],
                  ),
              ],
            ),
          );

        return Text('...');
      },
    );
  }
}
