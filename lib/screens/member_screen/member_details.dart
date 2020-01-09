import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';

class MemberDetails extends StatelessWidget {
  final Member member;

  MemberDetails({Key key, this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(member.tag),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image(
              image: NetworkImage(member.profileWallpaperURL),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
              ),
              child: Text(
                'Description',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(member.description),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
              ),
              child: Text(
                'Favorite Anime',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(member.favoriteAnime),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
              ),
              child: Text(
                'Badges',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Wrap(
                  children: member.activeBadge != null &&
                          member.activeBadge != ''
                      ? member.badges.map((b) => Chip(label: Text(b))).toList()
                      : [
                          Chip(
                            label: Text('No Badges'),
                          )
                        ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
