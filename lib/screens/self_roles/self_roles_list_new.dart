import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class SelfRolesNew extends StatefulWidget {
  @override
  _SelfRolesNewState createState() => _SelfRolesNewState();
}

class _SelfRolesNewState extends State<SelfRolesNew> {
  final _emojiController = TextEditingController();
  bool _showError = false;
  Role _role;

  @override
  Widget build(BuildContext context) {
    _onBtnPress() {
      if (_emojiController.text == '' || _role == null) {
        setState(() {
          _showError = true;
        });

        return;
      }

      BlocProvider.of<SelfRolesListBloc>(context).add(
        CreateSelfRole(
          emoji: _emojiController.text,
          role: _role.name,
        ),
      );
      Navigator.pop(context);
      _emojiController.clear();
      _role = null;
      _showError = false;
    }

    return BlocBuilder<SelfRolesListBloc, SelfRolesListState>(
      builder: (context, state) {
        if (state is SelfRolesListLoaded)
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
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey[200]
                        : Colors.grey[800],
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    Text(
                      'Create New Self Role',
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
                        child: TextFormField(
                          validator: (String val) {
                            if (val.isEmpty) return "Emoji can't be empty";

                            RegExp emojiRegex =
                                RegExp('/<?(a:)?(\w{2,32}):(\d{17,19})>?/');

                            if (val.length > 1 && emojiRegex.hasMatch(val))
                              return null;
                            else
                              return 'Invalid emoji String';
                          },
                          controller: _emojiController,
                          decoration: InputDecoration(
                            labelText: 'Emoji',
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
                        'Create Self Role',
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
