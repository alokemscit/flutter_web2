import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_2/data/apiBloc.dart';

import 'data/data_api.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider(
        create: (context) => data_api(),
        child: BlocProvider(
          create: (context) => DepartmentBloc(
            RepositoryProvider.of<data_api>(context),
          )..add(GetDepartmentList()),
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

  //const AppintmentPage({super.key});

  const AppointmentPage({super.key, required this.myModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DropdownBloc(),
      child: BlocBuilder<DropdownBloc, DropDownState>(
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.amber,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  // margin: const EdgeInsets.only(left: 12,top: 12),
                  width: 120,
                  height: 35,
                  child: DropdownButtonFormField(
                    // value: '03',
                    items: myModel.groupList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.id.toString(),
                        child: Text(item.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      //print(value.toString());
                      context.read<DropdownBloc>().add(setGroupID(
                          groupID: value.toString(),
                          deptList: myModel.deptList));
                      // setState(() {
                      //   selectedItemId = value;
                      // });
                    },

                    decoration: const InputDecoration(
                      labelText: 'Select Group',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 4),

                      // Remove vertical padding
                    ),
                    isDense: true,
                    isExpanded: true,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  // margin: const EdgeInsets.only(left: 12,top: 12),
                  width: 350,
                  height: 35,
                  child: BlocBuilder<DropdownBloc, DropDownState>(
                    builder: (context, state) {
                      if (state is DropDownGroupState) {
                       // print(state.deptList.map((e) => e.name).toList());
                      }
                      return DropdownButtonFormField(
                        // value: '',
                        items: state is DropDownGroupState
                            ? state.deptList?.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item.id, // Convert item.id to String.
                                  child: Text(item.name),
                                );
                              }).toList()
                            : [],
                        onChanged: (value) {
                          // Handle the selected value here.
                        },

                        decoration: const InputDecoration(
                          labelText: 'Select Departmrnt',
                          labelStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 4),

                          // Remove vertical padding
                        ),
                        isDense: true,
                        isExpanded: true,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    //var x = getItems();
    // return ListView.builder(
    //     itemCount: myModel.deptList.length,
    //     scrollDirection: Axis.vertical,
    //     itemBuilder: (context, index) {
    //       return Text(myModel.deptList[index].id + myModel.deptList[index].name);
    //     });
  }
}

abstract class DropDownEvent extends Equatable {}

// ignore: camel_case_types
class setGroupID extends DropDownEvent {
  final String groupID;
  final List<DepartmentModel> deptList;
  setGroupID({required this.groupID, required this.deptList});
  @override
  List<Object?> get props => [];
}

abstract class DropDownState extends Equatable {}

class DropdownInit extends DropDownState {
  final String groupID;

  DropdownInit({required this.groupID});
  @override
  List<Object?> get props => [];
}

class DropDownGroupState extends DropDownState {
  final String? groupID;
  final List<DepartmentModel>? deptList;
  DropDownGroupState({required this.groupID, required this.deptList});
  @override
  List<Object?> get props => [deptList, groupID];
}

class DropdownBloc extends Bloc<DropDownEvent, DropDownState> {
  DropdownBloc() : super(DropdownInit(groupID: '')) {
    on<setGroupID>((event, emit) {
      List<DepartmentModel> dptList =
          event.deptList.where((o) => o.gid == event.groupID).toList();
      // print( dptList.length);
      emit(DropDownGroupState(
        groupID: event.groupID,
        deptList: dptList,
      ));
    });
  }
}
