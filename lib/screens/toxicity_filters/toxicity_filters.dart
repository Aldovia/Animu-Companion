import 'package:animu/screens/toxicity_filters/toxicity_filters_settings.dart';
import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToxicityFilters extends StatelessWidget {
  final AnimuRepository animuRepository;

  ToxicityFilters({@required this.animuRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Toxicty Filters',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: BlocProvider(
            create: (context) =>
                ToxicityFiltersSettingsBloc(animuRepository: animuRepository)
                  ..add(FetchToxicityFiltersSettings()),
            child: ToxicityFiltersSettings(),
          ),
        ),
      ),
    );
  }
}
