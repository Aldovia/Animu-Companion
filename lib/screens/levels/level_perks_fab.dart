import 'package:animu_common/animu_common.dart';
import 'package:animu/screens/levels/level_perks_new_badge_perk.dart';
import 'package:animu/screens/levels/level_perks_new_rep_perk.dart';
import 'package:animu/screens/levels/level_perks_new_role_perk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class LevelPerksFAB extends StatefulWidget {
  @override
  _LevelPerksFABState createState() => _LevelPerksFABState();
}

class _LevelPerksFABState extends State<LevelPerksFAB> {
  bool _fabVisibility = true;

  _showFab(val) {
    setState(() {
      _fabVisibility = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelPerksBloc, LevelPerksState>(
      builder: (context, state) {
        if (state is LevelPerksLoaded)
          return SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(size: 22.0),
            curve: Curves.bounceIn,
            visible: _fabVisibility,
            children: [
              SpeedDialChild(
                  child: Icon(Icons.bookmark),
                  backgroundColor: Colors.red,
                  label: 'Rep',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () {
                    PersistentBottomSheetController bottomSheetController =
                        Scaffold.of(context).showBottomSheet(
                      (context) => LevelPerksNewRepPerk(),
                    );
                    _showFab(false);

                    bottomSheetController.closed.then((val) => _showFab(true));
                  }),
              SpeedDialChild(
                child: Icon(Icons.card_membership),
                backgroundColor: Colors.blue,
                label: 'Badge',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  PersistentBottomSheetController bottomSheetController =
                      Scaffold.of(context).showBottomSheet(
                    (context) => LevelPerksNewBadgePerk(),
                  );

                  _showFab(false);

                  bottomSheetController.closed.then((val) => _showFab(true));
                },
              ),
              SpeedDialChild(
                child: Icon(Icons.perm_identity),
                backgroundColor: Colors.green,
                label: 'Role',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  PersistentBottomSheetController bottomSheetController =
                      Scaffold.of(context).showBottomSheet(
                    (context) => LevelPerksNewRolePerk(),
                  );

                  _showFab(false);

                  bottomSheetController.closed.then((val) => _showFab(true));
                },
              ),
            ],
          );

        return Text('');
      },
    );
  }
}
