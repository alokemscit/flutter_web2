// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: file_names
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_2/data/data_api.dart';

class GroupModel {
  final String id;
  final String name;
  GroupModel({required this.id, required this.name});

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;
}

class DepartmentModel {
  final String gid;
  final String id;
  final String name;
  DepartmentModel({
    required this.gid,
    required this.id,
    required this.name,
  });

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ gid.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepartmentModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          gid == other.gid;
}

class UnitModel {
  final String gid;
  final String did;
  final String id;
  final String name;
  UnitModel({
    required this.did,
    required this.gid,
    required this.id,
    required this.name,
  });

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ gid.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnitModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          gid == other.gid &&
          did == other.did;
}

class GroupDeptUnitModel {
  List<GroupModel> groupList;
  List<DepartmentModel> deptList;
  List<UnitModel> unitList;
  GroupDeptUnitModel({
    required this.groupList,
    required this.deptList,
    required this.unitList,
  });
}

abstract class DepartmentEvent extends Equatable {
  // const DepartmentEvent();
  @override
  List<Object> get props => [];
}

class GetDepartmentList extends DepartmentEvent {}

class NetworkError extends Error {}

abstract class DepartmentState extends Equatable {
  // const DepartmentState();

  @override
  List<Object?> get props => [];
}

class DepartmentLoading extends DepartmentState {
  @override
  List<Object?> get props => [];
}

class DepartmentLoaded extends DepartmentState {
  // ignore: non_constant_identifier_names
  final GroupDeptUnitModel model;

  DepartmentLoaded(this.model);

  @override
  List<Object?> get props => [DepartmentModel];
}

class DepartmentError extends DepartmentState {
  final String? message;
  DepartmentError(this.message);
}

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  final data_api apiRepository;
  DepartmentBloc(this.apiRepository) : super(DepartmentLoading()) {
    on<GetDepartmentList>((event, emit) async {
      try {

        print('dept list');
        // emit(DepartmentLoading());
        final mList = await apiRepository.createLead([
          {'tag': '59'},
        ]);

        Set<GroupModel> grouplist = mList.map((item) {
          return GroupModel(
            id: item['DPT_GRP_ID'].toString(),
            name: item['DEPT_GRP_NAME'],
          );
        }).toSet();

        Set<DepartmentModel> deptlist = mList.map((item) {
          return DepartmentModel(
            gid: item['DPT_GRP_ID'].toString(),
            name: item['DEPARTMENT'],
            id: item['DEPT_ID'],
          );
        }).toSet();

        Set<UnitModel> unitlist = mList.map((item) {
          return UnitModel(
            gid: item['DPT_GRP_ID'].toString(),
            name: item['UNIT'],
            did: item['DEPT_ID'],
            id: item['UNIT_ID'],
          );
        }).toSet();

        GroupDeptUnitModel mg= GroupDeptUnitModel(deptList: deptlist.toList(), groupList: grouplist.toList(), unitList: unitlist.toList(),);
        
        // print(mList.toString());
        emit(DepartmentLoaded(mg));
        //  print(mList.toString());

        // if (mList.error != null) {
        //   emit(DepartmentError(mList.error));
        // }
        // ignore: nullable_type_in_catch_clause
      } on NetworkError {
        emit(DepartmentError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
