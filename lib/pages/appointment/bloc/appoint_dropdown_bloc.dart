import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/apiBloc.dart';

abstract class DropDownEvent extends Equatable {}

// ignore: camel_case_types
class refreshEvent extends DropDownEvent {
  @override
  List<Object?> get props => [];
}

// ignore: camel_case_types
class setGroupID extends DropDownEvent {
  final String groupID;
  final List<DepartmentModel> deptList;
  setGroupID({required this.groupID, required this.deptList});
  @override
  List<Object?> get props => [];
}

// ignore: camel_case_types
class setDepartmentID extends DropDownEvent {
  final String departmentID;
  final String? groupID;
  final List<UnitModel> unitlist;
  setDepartmentID(
      {required this.departmentID,
      required this.groupID,
      required this.unitlist});
  @override
  List<Object?> get props => [];
}

// ignore: camel_case_types
class setUnitIDEvent extends DropDownEvent {
  final String unitID;
  setUnitIDEvent({required this.unitID});
  @override
  List<Object?> get props => [unitID];
}

abstract class DropDownState extends Equatable {}

class DropdownInit extends DropDownState {
  //final String groupID;

  //DropdownInit({required this.groupID});
  @override
  List<Object?> get props => [];
}

class DropDownGroupState extends DropDownState {
  final String? groupID;
  final List<DepartmentModel>? deptList;
  DropDownGroupState({required this.groupID, required this.deptList});
  @override
  List<Object?> get props => [];
}

class DropDownDepartmentState extends DropDownState {
  final String? departmentID;

  final List<UnitModel>? unitList;
  DropDownDepartmentState({required this.departmentID, required this.unitList});
  @override
  List<Object?> get props => [];
}

// ignore: camel_case_types
class setUnitIDState extends DropDownState {
  final String unitID;
  setUnitIDState({required this.unitID});
  @override
  List<Object?> get props => [unitID];
}

class DropdownBloc extends Bloc<DropDownEvent, DropDownState> {
  DropdownBloc() : super(DropdownInit()) {
    on<setGroupID>((event, emit) async {
      emit(DropdownInit());
      List<DepartmentModel> dptList =
           (event.deptList.where((o) => o.gid == event.groupID).toList());
      // print( dptList.length);
      emit(DropDownGroupState(
        groupID: event.groupID,
        deptList: dptList,
      ));
    });
    on<setDepartmentID>((event, emit) async {
//print('object');
      emit(DropdownInit());
      List<UnitModel> unitlists =  event.unitlist
          .where((o) => o.did == event.departmentID && o.gid == event.groupID)
          .toList();
      //print(unitlists.toString());
      await Future.delayed(const Duration(milliseconds: 500));
      emit(DropDownDepartmentState(
          departmentID: event.departmentID, unitList: unitlists));
//emit(DropdownInit());
    });

    on<refreshEvent>((event, emit) {
      emit(DropdownInit());
    });

    on<setUnitIDEvent>((event, emit) {
      emit(setUnitIDState(unitID: event.unitID));
    });
  }
}