import 'package:assignment0/utils/enums.dart';
import 'package:equatable/equatable.dart';

abstract class FlagEvent extends Equatable {
  const FlagEvent();
}

class SelectFlagEvent extends FlagEvent {
  final Country? flag;

  const SelectFlagEvent({this.flag});

  @override
  List<Object?> get props => [flag];
}
