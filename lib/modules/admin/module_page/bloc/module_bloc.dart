import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_api.dart';
import '../../../../model/model_status.dart';





 


abstract class ModuleSearchState {}

class MSearchState extends ModuleSearchState {
   final  String txt;
  MSearchState({required this.txt});
}

class ModuleSearchInitial extends ModuleSearchState {}

abstract class ModuleSearchEvent {}

class MSearchEvent extends ModuleSearchEvent {
 final  String txt;
  MSearchEvent({required this.txt});
}

class ModuleSearchBloc extends Bloc<ModuleSearchEvent, ModuleSearchState> {
  ModuleSearchBloc() : super(ModuleSearchInitial()) {
    on<MSearchEvent>((event, emit) {
      emit(MSearchState(txt: event.txt));
    });
  }
}

abstract class ModuleState {}

class ModuleLodingState extends ModuleState {}

class ModuleLInitState extends ModuleState {}

class ModuleLodedState extends ModuleState {}

class ModuleSavingState extends ModuleState {}

class ModuleSaveSuccessState extends ModuleState {
  final String message;
  ModuleSaveSuccessState({required this.message});
}

class ModuleleSaveErrorState extends ModuleState {
  final String error;
  ModuleleSaveErrorState({required this.error});
}

abstract class ModuleEvent {}

class ModuleSaveEvent extends ModuleEvent {
  final List<String> valueList;
  ModuleSaveEvent({required this.valueList});
}

class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  //final data_api2 repo;
  ModuleBloc() : super(ModuleLInitState()) {
    // on<ModuleSearchEvent>(
    //   (event, emit) {
    //     emit(ModuleSearchState());
    //   },
    // );
    on<ModuleSaveEvent>((event, emit) async {
      data_api2 repo = data_api2();
      var img = event.valueList[2];
      var name = event.valueList[0];
      var desc = event.valueList[1];
      if (img.isEmpty || name.isEmpty || desc.isEmpty) {
        emit(ModuleleSaveErrorState(error: "All entry fields value required!"));
        return;
      }
      emit(ModuleSavingState());
      Future.delayed(const Duration(microseconds: 300));
      try {
        var x = await repo.createLead([
          //@name, @pid int,@img
          {"tag": "2", "name": name, "pid": 0, "img": img, "desc": desc}
        ]);
        List<ModelStatus> lst = x
            .map(
              (e) => ModelStatus.fromJson(e),
            )
            .toList();
        if (lst.isEmpty) {
          emit(ModuleleSaveErrorState(error: "No data Saved"));
        } else {
          var a = lst.first.status.toString();
          var m = lst.first.msg!;
          if (a != "1") {
            emit(ModuleleSaveErrorState(error: m));
          } else {
            emit(ModuleSaveSuccessState(message: m));
          }
        }
        // print(x.toString());
        //a = x.map((e) => ModelMenuList.fromJson(e)).toList();
      } on Exception catch (e) {
        print(e.toString());
      }
    });
  }
}
