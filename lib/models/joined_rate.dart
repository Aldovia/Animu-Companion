import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class JoinedRate extends Equatable {
  final List<int> joinedRate;

  const JoinedRate({@required this.joinedRate});

  @override
  List<Object> get props => [joinedRate];

  static JoinedRate fromJson(dynamic json) {
    final joinedRate = json['joined'].cast<int>();
    return JoinedRate(joinedRate: joinedRate);
  }
}
