import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class LevelPerksNewRolePerk extends StatefulWidget {
  @override
  _LevelPerksNewRolePerkState createState() => _LevelPerksNewRolePerkState();
}

class _LevelPerksNewRolePerkState extends State<LevelPerksNewRolePerk> {
  final _levelController = TextEditingController();
  bool _showError = false;
  Role _role;

  @override
  Widget build(BuildContext context) {
    _onBtnPress() {
      if (_levelController.text == '' || _role == null) {
        setState(() {
          _showError = true;
        });

        return;
      }

      BlocProvider.of<LevelPerksBloc>(context).add(
        CreateLevelPerk(
            level: int.parse(_levelController.text),
            perkName: 'badge',
            perkValue: _role.name),
      );
      Navigator.pop(context);
      _levelController.clear();
      _role = null;
      _showError = false;
    }

    return BlocBuilder<LevelPerksBloc, LevelPerksState>(
      builder: (context, state) {
        if (state is LevelPerksLoaded)
          return Container(
            height: 300.0,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
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
                      style: Theme.of(context).textTheme.title,
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
                        width: 150.0,
                        child: ChipsInput(
                          decoration: InputDecoration(
                            labelText: 'Role',
                          ),
                          maxChips: 1,
                          initialValue: _role ?? [],
                          findSuggestions: (String query) {
                            if (query.length != 0) {
                              var lowercaseQuery = query.toLowerCase();
                              return state.roles.where((role) {
                                return role.name
                                        .toLowerCase()
                                        .contains(query.toLowerCase()) ||
                                    role.id.contains(query);
                              }).toList(growable: false)
                                ..sort((a, b) => a.name
                                    .toLowerCase()
                                    .indexOf(lowercaseQuery)
                                    .compareTo(b.name
                                        .toLowerCase()
                                        .indexOf(lowercaseQuery)));
                            } else {
                              return const <Role>[];
                            }
                          },
                          onChanged: (data) {
                            _role = data[0];
                          },
                          chipBuilder: (context, state, role) {
                            return InputChip(
                              key: ObjectKey(role.id),
                              label: Text(role.name),
                              onDeleted: () => state.deleteChip(role),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            );
                          },
                          suggestionBuilder: (context, state, role) {
                            return ListTile(
                              key: ObjectKey(role.id),
                              title: Text(role.name),
                              onTap: () => state.selectSuggestion(role),
                            );
                          },
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

        return Text('...');
      },
    );
  }
}
