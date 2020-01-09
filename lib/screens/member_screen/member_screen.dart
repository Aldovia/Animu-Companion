import 'package:animu/screens/member_screen/member_screen_info.dart';
import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberScreen extends StatefulWidget {
  final AnimuRepository animuRepository;
  final Member member;

  MemberScreen({this.animuRepository, this.member});
  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  @override
  Widget build(BuildContext context) {
    Member _member = widget.member;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: BlocProvider<MemberBloc>(
        create: (context) => MemberBloc(animuRepository: widget.animuRepository)
          ..add(FetchMember(memberID: _member.id)),
        child: BlocBuilder<MemberBloc, MemberState>(
          builder: (context, state) {
            if (state is MemberLoaded) _member = state.member;
            return MemberScreenInfo(
              member: _member,
            );
          },
        ),
      ),
    );
  }
}
