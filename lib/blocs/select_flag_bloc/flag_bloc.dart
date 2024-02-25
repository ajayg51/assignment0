import 'package:assignment0/blocs/select_flag_bloc/flag_bloc_event.dart';
import 'package:assignment0/blocs/select_flag_bloc/flag_bloc_state.dart';
import 'package:assignment0/controllers/select_flag_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class FlagBloc extends Bloc<FlagEvent, FlagState> {
  FlagBloc() : super(const FlagInitialState()) {
    on<FlagEvent>((event, emit) {
      // GetIt stuff
      final locator = GetIt.instance;
      final controller = locator.get<SelectFlagController>();

      
      if (event is SelectFlagEvent) {
        final flag = controller.flag;
        debugPrint("bloc :: $flag");

        emit(SelectFlagState(flag: flag));
      }
    });
  }
}
