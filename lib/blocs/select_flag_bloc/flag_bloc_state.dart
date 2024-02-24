import 'package:assignment0/utils/enums.dart';
import 'package:equatable/equatable.dart';

abstract class FlagState extends Equatable {
  const FlagState();
}

class FlagInitialState extends FlagState {
  const FlagInitialState();

  @override
  List<Object> get props => [];
}

class SelectFlagState extends FlagState {
  final Country flag;

  const SelectFlagState({required this.flag});

  @override
  List<Object> get props => [flag];
}
