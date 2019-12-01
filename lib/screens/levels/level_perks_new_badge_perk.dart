import 'package:animu/bloc/blocs/level_perks_bloc.dart';
import 'package:animu/bloc/events/level_perks_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelPerksNewBadgePerk extends StatefulWidget {
  @override
  _LevelPerksNewBadgePerkState createState() => _LevelPerksNewBadgePerkState();
}

class _LevelPerksNewBadgePerkState extends State<LevelPerksNewBadgePerk> {
  final _levelController = TextEditingController();
  final _badgeController = TextEditingController();
  bool _showError = false;

  @override
  Widget build(BuildContext context) {
    _onBtnPress() {
      if (_levelController.text == '' || _badgeController.text == '') {
        setState(() {
          _showError = true;
        });

        return;
      }

      BlocProvider.of<LevelPerksBloc>(context).add(
        CreateLevelPerk(
          level: int.parse(_levelController.text),
          perkName: 'badge',
          perkValue: _badgeController.text,
        ),
      );
      Navigator.pop(context);
      _levelController.clear();
      _badgeController.clear();
      _showError = false;
    }

    return Container(
      height: 350.0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              Text(
                'Create New Perk',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              if (_showError)
                SizedBox(
                  height: 5,
                ),
              if (_showError)
                Text(
                  'Please fill out both fields',
                  style: TextStyle(color: Colors.red, fontSize: 10.0),
                ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 250.0,
                  child: TextField(
                    controller: _badgeController,
                    decoration: InputDecoration(
                      labelText: 'Badge',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 150.0,
                  child: TextField(
                    controller: _levelController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Level',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: _onBtnPress,
                child: Text(
                  'Create Perk',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
