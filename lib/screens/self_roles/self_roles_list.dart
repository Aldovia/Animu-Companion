import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelfRolesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelfRolesListBloc, SelfRolesListState>(
      builder: (context, state) {
        if (state is SelfRolesListLoading)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (state is SelfRolesListLoaded)
          return Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: state.selfRoles.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                (i + 1).toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            title: Text(state.selfRoles[i].role.name),
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          );

        if (state is SelfRolesListError)
          return Center(
            child: Text('An unexpected error occured'),
          );

        return Text('...');
      },
    );
  }
}
