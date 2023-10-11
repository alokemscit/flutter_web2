// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/data/apiBloc.dart';
import 'package:web_2/model/app_time.dart';

import 'component/widget/custom_datepicker.dart';
import 'data/data_api.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider(
        create: (context) => data_api(),
        child: MultiBlocProvider(
          //create: (context) => DropdownBloc(),
          providers: [
            BlocProvider<DepartmentBloc>(
              create: (BuildContext context) => DepartmentBloc(
                RepositoryProvider.of<data_api>(context),
              )..add(GetDepartmentList()),
            ),
            BlocProvider<DropdownBloc>(
              create: (BuildContext context) => DropdownBloc(),
            ),
            BlocProvider<DoctorShowBloc>(
              create: (BuildContext context) => DoctorShowBloc(
                RepositoryProvider.of<data_api>(context),
              ),
            ),
          ],

          child: BlocBuilder<DepartmentBloc, DepartmentState>(
            builder: (context, state) {
              if (state is DepartmentLoading) {
                //print('Dep loading......');
                // context.read<DepartmentBloc>().add(GetDepartmentList());
                return _buildLoading();
              } else if (state is DepartmentLoaded) {
                return AppointmentPage(
                  myModel: state.model,
                );
              } else if (state is DepartmentError) {
                return const Text("Data Loading Error!...");
              } else {
                return Container();
              }

              // return SingleChildScrollView(
              //   child: Container(),
              // );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}

// ignore: must_be_immutable
class AppointmentPage extends StatelessWidget {
  final GroupDeptUnitModel myModel;
  String? groupID;
  String? departmentID;
  String? unitID;
  List<DepartmentModel>? myDeptList;
  List<UnitModel>? myUnitList;
  //const AppintmentPage({super.key});

  AppointmentPage({super.key, required this.myModel});
  // ignore: prefer_final_fields, non_constant_identifier_names
  TextEditingController _date_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownBloc, DropDownState>(
      builder: (context, state) {
        if (state is DropDownGroupState) {
          myDeptList = [];
          myUnitList = [];
          departmentID = null;
          unitID = null;
          myDeptList = state.deptList;
          //print('group click');
        }
        if (state is DropDownDepartmentState) {
          myUnitList = [];
          unitID = null;
          // departmentID= state.departmentID;
          myUnitList = state.unitList;

          //  print('dept click');
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                boxShadow: myboxShadow,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropDown(
                    id: groupID,
                    list: myModel.groupList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.id, // Convert item.id to String.
                        child: Text(item.name),
                      );
                    }).toList(),
                    onTap: (value) {
                      groupID = value.toString();

                      context.read<DropdownBloc>().add(setGroupID(
                          groupID: value.toString(),
                          deptList: myModel.deptList));
                    },
                    width: 120,
                    labeltext: "Select Group",
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  CustomDropDown(
                    id: departmentID,
                    list: myDeptList?.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.id, // Convert item.id to String.
                        child: Text(item.name),
                      );
                    }).toList(),
                    onTap: (value) {
                      departmentID = value.toString();
                      print(departmentID);
                      context.read<DropdownBloc>().add(setDepartmentID(
                          departmentID: value.toString(),
                          unitlist: myModel.unitList));
                    },
                    width: 180,
                    labeltext: "Select Department",
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  CustomDropDown(
                    id: unitID,
                    list: myUnitList?.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.id, // Convert item.id to String.
                        child: Text(item.name),
                      );
                    }).toList(),
                    onTap: (value) {
                      unitID = value.toString();
                      print(unitID);
                      context.read<DropdownBloc>().add(refreshEvent());
                    },
                    width: 240,
                    labeltext: "Select Unit",
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  CustomDatePicker(date_controller: _date_controller),

                  const SizedBox(
                    width: 8,
                  ),

                  ShowButton(
                    did: departmentID ?? '',
                    uid: unitID ?? '',
                    date: _date_controller.text ?? '',
                  ),

                  // context.read<DropdownBloc>().onChange(change)
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // DoctorPanel(data),
                    // DoctorPanel(),DoctorPanel(),DoctorPanel(),DoctorPanel(),DoctorPanel(),DoctorPanel(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ShowButton extends StatelessWidget {
  final String? did;
  final String? uid;
  final String? date;
  const ShowButton({
    Key? key,
    required this.did,
    required this.uid,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorShowBloc, DoctorShowState>(
      builder: (context, state) {
        return SizedBox(
          width: 75,
          height: 35,
          child: ElevatedButton(
            onPressed: () {
              //var snackBar = SnackBar(content: Text('Hello, I am here'));
              // Step 3
              ScaffoldMessenger.of(context)
                  .showSnackBar( 
                  SnackBar(
          backgroundColor:Colors.red,
  behavior: SnackBarBehavior.floating,
  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height-100
  ,left: MediaQuery.of(context).size.width*.4,right: MediaQuery.of(context).size.width*.4
  ),
  //padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.3),
  content: const Text("Hello World!"),
)
                  );

              // context
              //     .read<DoctorShowBloc>()
              //     .add(DoctorShowSubmitEvent(date: date, did: did, unit: uid));
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.grey.shade700),
            ),
            child: const Text("Show"),
          ),
        );
      },
    );
  }
}

abstract class DoctorShowEvent extends Equatable {}

class DoctorShowSubmitEvent extends DoctorShowEvent {
  final String date;
  final String did;
  final String unit;

  DoctorShowSubmitEvent(
      {required this.date, required this.did, required this.unit});
  @override
  List<Object?> get props => [];
}

abstract class DoctorShowState extends Equatable {}

class DoctorShowLoding extends DoctorShowState {
  @override
  List<Object?> get props => [];
}

class DoctorShowLoded extends DoctorShowState {
  final List<AppTime>? list;

  DoctorShowLoded(this.list);
  @override
  List<Object?> get props => [list];
}

class NetError extends Error {}

class DoctorShowError extends DoctorShowState {
  final String? error;

  DoctorShowError(this.error);

  @override
  List<Object?> get props => [error];
}

class DoctorShowBloc extends Bloc<DoctorShowEvent, DoctorShowState> {
  final data_api apiRepository;
  DoctorShowBloc(this.apiRepository) : super(DoctorShowLoding()) {
    on<DoctorShowSubmitEvent>((event, emit) async {
      //emit(DoctorShowLoding());
      try {
        final mList = await apiRepository.createLead([
          {
            'tag': '60',
            'p_dept_id': event.did,
            'p_unit_id': event.unit,
            'p_sysdate_date': event.date,
            'p_entry_by': '1000'
          }
        ]);

        Set<AppTime> mlist = mList.map((item) {
          return AppTime(
            id: item['DPT_GRP_ID'].toString(),
            name: item['DEPT_GRP_NAME'],
            designation: '',
            stime: '',
            status: '',
            image: '',
            comments: '',
            sl: 0,
          );
        }).toSet();

        emit(DoctorShowLoded(mlist.toList()));

        // emit(DoctorShowLoded(mlist.toList()));
      } on NetError {
        emit(DoctorShowError('Network face error'));
      }
    });
  }
}

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
  final List<UnitModel> unitlist;
  setDepartmentID({required this.departmentID, required this.unitlist});
  @override
  List<Object?> get props => [];
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

class DropdownBloc extends Bloc<DropDownEvent, DropDownState> {
  DropdownBloc() : super(DropdownInit()) {
    on<setGroupID>((event, emit) async {
      emit(DropdownInit());
      List<DepartmentModel> dptList =
          await (event.deptList.where((o) => o.gid == event.groupID).toList());
      // print( dptList.length);
      emit(DropDownGroupState(
        groupID: event.groupID,
        deptList: dptList,
      ));
    });
    on<setDepartmentID>((event, emit) async {
//print('object');
      emit(DropdownInit());
      List<UnitModel> unitlists = await event.unitlist
          .where((o) => o.did == event.departmentID)
          .toList();
//print(unitlists.length);
      await Future.delayed(const Duration(milliseconds: 500));
      emit(DropDownDepartmentState(
          departmentID: event.departmentID, unitList: unitlists));
//emit(DropdownInit());
    });

    on<refreshEvent>((event, emit) {
      emit(DropdownInit());
    });
  }
}


// List<DepartmentModel> getDp(List<DepartmentModel> list,String gid) {
//   return  (list..where((o) => o.gid == gid).toList());
// }
