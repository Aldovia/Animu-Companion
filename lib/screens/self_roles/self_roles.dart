import 'package:animu/screens/self_roles/self_roles_list.dart';
import 'package:animu/screens/self_roles/self_roles_list_new.dart';
import 'package:animu/screens/self_roles/self_roles_settings.dart';
import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelfRoles extends StatelessWidget {
  final AnimuRepository animuRepository;

  SelfRoles({@required this.animuRepository});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        color: Colors.white,
        child: Center(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              title: Text(
                'Self Roles',
              ),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.list),
                  ),
                  Tab(
                    icon: Icon(Icons.settings),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                BlocProvider(
                  create: (context) =>
                      SelfRolesListBloc(animuRepository: animuRepository)
                        ..add(FetchSelfRolesList()),
                  child: Scaffold(
                    body: SelfRolesList(),
                    floatingActionButton:
                        BlocBuilder<SelfRolesListBloc, SelfRolesListState>(
                            builder: (context, state) {
                      if (state is SelfRolesListLoaded)
                        return FloatingActionButton(
                          child: Icon(Icons.add),
                          onPressed: () {
                            Scaffold.of(context).showBottomSheet(
                              (context) => SelfRolesNew(),
                            );
                          },
                        );

                      return CircularProgressIndicator();
                    }),
                  ),
                ),
                BlocProvider(
                  create: (context) =>
                      SelfRolesSettingsBloc(animuRepository: animuRepository)
                        ..add(FetchSelfRolesSettings()),
                  child: SelfRolesSettings(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
