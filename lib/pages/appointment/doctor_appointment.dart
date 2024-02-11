import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/data/apiBloc.dart';
import 'package:web_2/model/app_time.dart';
import 'bloc/appoint_dropdown_bloc.dart';
import 'bloc/doctor_list_bloc.dart';
import '../../component/widget/custom_datepicker.dart';
import '../../component/widget/doctor_panel.dart';
import '../../data/data_api.dart';
import 'widget/show_button.dart';

class DoctorAppointment extends StatelessWidget {
  const DoctorAppointment({
    super.key,
  });

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
           
          ],

          child: BlocBuilder<DepartmentBloc, DepartmentState>(
            builder: (context, state) {
              if (state is DepartmentLoading) {
                return _buildLoading();
              } else if (state is DepartmentLoaded) {
                print('loaded');
                return AppointmentPage(
                  myModel: state.model,
                );
              } else if (state is DepartmentError) {
                return const Text("Data Loading Error!...");
              } else {
                return Container();
              }
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
  List<AppTime>? list = [];
  List<DistinctDoctor>? dlist = [];
  //const AppintmentPage({super.key});

  AppointmentPage({super.key, required this.myModel});
  // ignore: prefer_final_fields, non_constant_identifier_names
  TextEditingController _date_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double wide = MediaQuery.of(context).size.width;
    //print(_wide);

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

          // print(state.unitList.toString());
        }
        if (state is setUnitIDState) {
          unitID = state.unitID;
        }

        var customdropdownGroup = CustomDropDown(
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
                groupID: value.toString(), deptList: myModel.deptList));
          },
          width: 140,
          labeltext: "Select Group",
        );

        var customdropdownDepartment = CustomDropDown(
          id: departmentID,
          list: myDeptList?.map((item) {
            return DropdownMenuItem<String>(
              value: item.id, // Convert item.id to String.
              child: Text(item.name),
            );
          }).toList(),
          onTap: (value) {
            departmentID = value.toString();
            // print(departmentID);
            context.read<DropdownBloc>().add(setDepartmentID(
                departmentID: value.toString(),
                groupID: groupID,
                unitlist: myModel.unitList));
          },
          width: 180,
          labeltext: "Select Department",
        );
        var customdropdownUnit = CustomDropDown(
          id: unitID,
          list: myUnitList?.map((item) {
            return DropdownMenuItem<String>(
              value: item.id, // Convert item.id to String.
              child: Text(item.name),
            );
          }).toList(),
          onTap: (value) {
            unitID = value.toString();
            //  print(unitID);
            context.read<DropdownBloc>().add(setUnitIDEvent(unitID: unitID!));
          },
          width: 240,
          labeltext: "Select Unit",
        );
        const sizedBox = SizedBox(
          width: 8,
        );
        var showButton = ShowButton(
          onTab: () {
            //  print('object');

            // ignore: unnecessary_null_comparison
            bool b = _date_controller.text == null
                ? true
                : departmentID == null
                    ? true
                    : unitID == null
                        ? true
                        : false;

            if (b) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height - 100,
                      left: MediaQuery.of(context).size.width * .4,
                      right: MediaQuery.of(context).size.width * .4),
//   //padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.3),
                  content:
                      const Text("Please selct the required dropdown field"),
                ),
              );
              return;
            }

            context.read<DoctorShowBloc>().add(DoctorShowSubmitEvent(
                date: _date_controller.text.toString(),
                did: departmentID!.toString(),
                unit: unitID!.toString()));
          },

          // did: departmentID ?? '',
          // uid: unitID ?? '',
          // date: _date_controller.text.toString(),
        );
        var displayContainer = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: BlocBuilder<DoctorShowBloc, DoctorShowState>(
            builder: (context, state) {
              // List<AppTime>? list = [];
              if (state is DoctorShowLoding) {
                list = [];
                dlist = [];
                // print('Loading');
                return SizedBox(
                    height: MediaQuery.of(context).size.width > 835
                        ? MediaQuery.of(context).size.height - 130
                        : MediaQuery.of(context).size.height - 135,
                    child: const Center(child: CircularProgressIndicator()));
              } else if (state is DoctorShowLoded) {
                //  debugPrint('Loaded');
                list = state.list;
                dlist = state.dList;
                //  print(list.toString());
                // print(list!.length);
              } else if (StepState is DoctorShowError) {
                //  print('Error');
                return const Expanded(
                    child: Center(child: Text('Data Loading Eroor!')));
              } else {
                return const SizedBox();
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  runSpacing: 12,
                  spacing: 12,
                  children: List.generate(
                    dlist!.length,
                    (index) => DoctorPanel(
                        data: list!
                            .toList()
                            .where((e) => e.id == dlist![index].id)
                            .toList()),
                  ),
                ),
              );
            },
          ),
        );
        var desktop = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration:
                  const BoxDecoration(color: kSecondaryColor, boxShadow: [
                BoxShadow(
                    //   color: Colors.white,
                    blurRadius: 0.1,
                    spreadRadius: 0.01)
              ]),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customdropdownGroup,
                  sizedBox,
                  customdropdownDepartment,
                  sizedBox,
                  customdropdownUnit,
                  sizedBox,
                  CustomDatePicker(
                    date_controller: _date_controller,
                    bgColor: Colors.white,
                  ),
                  sizedBox,
                  showButton,
                  // context.read<DropdownBloc>().onChange(change)
                ],
              ),
            ),
            displayContainer,
          ],
        );

        var tablet = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration:
                  const BoxDecoration(color: kSecondaryColor, boxShadow: [
                BoxShadow(
                    //   color: Colors.white,
                    blurRadius: 0.1,
                    spreadRadius: 0.1)
              ]),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: wide > 812
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customdropdownGroup,
                        sizedBox,
                        customdropdownDepartment,
                        sizedBox,
                        customdropdownUnit,
                        sizedBox,
                        CustomDatePicker(
                          date_controller: _date_controller,
                          bgColor: Colors.grey.shade200,
                        ),
                        sizedBox,
                        showButton,
                        // context.read<DropdownBloc>().onChange(change)
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customdropdownGroup,
                            sizedBox,
                            customdropdownDepartment,
                            sizedBox,
                            customdropdownUnit,
                            // sizedBox ,
                            // CustomDatePicker(date_controller: _date_controller),
                            // sizedBox,
                            // showButton,
                            // context.read<DropdownBloc>().onChange(change)
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // customDropDown_group,
                            // sizedBox,
                            // customDropDown_department,
                            // sizedBox,
                            // customDropDown_unit,
                            //sizedBox,
                            CustomDatePicker(date_controller: _date_controller),
                            sizedBox,
                            showButton,
                            // context.read<DropdownBloc>().onChange(change)
                          ],
                        )
                      ],
                    ),
            ),
            displayContainer,
          ],
        );

        return Responsive(
            mobile: Container(), tablet: tablet, desktop: desktop);
      },
    );
  }
}
