import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GrowthRate extends Equatable {
  final List<int> growthRate;

  const GrowthRate({@required this.growthRate});

  @override
  List<Object> get props => [growthRate];

  static GrowthRate fromJson(dynamic json) {
    final growthRate = json['growth'].cast<int>();
    return GrowthRate(growthRate: growthRate);
  }
}
