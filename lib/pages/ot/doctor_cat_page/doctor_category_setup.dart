import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_search_box.dart';
import 'package:web_2/data/data_api.dart';

import 'package:web_2/pages/ot/doctor_cat_page/model/module_for_set_doctor_type.dart';

import '../../../component/settings/config.dart';
import 'share/ot_share_data.dart';

class DoctorCategorySetup extends StatelessWidget {
  const DoctorCategorySetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? cid = null;
    List<_ModuleDocCategory> list;
    return BlocProvider(
      create: (context) => _otDocCatBloc(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecorationTopRounded,
                  // label: "All Doctors List",
                  // labelToChildDistance: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSearchBox(
                          caption: "Search Doctor",
                          controller: TextEditingController(),
                          isFilled: true,
                          width: double.infinity,
                          maxlength: 50,
                          height: 32,
                          onChange: (v) {},
                        ),

                        const SizedBox(height: 4),
                        // Text("data"),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ListView(
                              shrinkWrap: true,
                              children: const [
                                // Your widgets here
                                _DoctorLoad(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                //color: Colors.amber,
                width: 32,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.keyboard_double_arrow_right_sharp),
                    SizedBox(
                      height: 4,
                    ),
                    Icon(Icons.keyboard_double_arrow_left_sharp),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecorationTopRounded,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<_otDocCatBloc, _otDocCatState>(
                      builder: (context, state) {
                        if (state is _otDocCatLodingState) {}
                        if (state is _otDocCatLoadedState) {
                          list = state.list;
                          print(list.length);
                        }
                        return Column(
                          children: [
                            CustomDropDown(
                              id: cid,
                              list: roles
                                  .map((e) => DropdownMenuItem<String>(
                                      value: e.toString(),
                                      child: Text(e.toString())))
                                  .toList(),
                              onTap: (a) {
                                cid = a;
                                context.read<_otDocCatBloc>().add(
                                    _otDocCatSetEvent(
                                        id: fixedMasterKey(a.toString())));
                                // print(fixedMasterKey(a.toString()));
                              },
                              width: double.infinity,
                              labeltext: "Select Category Type",
                            ),
                            Table(columnWidths: const {
                              0: FixedColumnWidth(80),
                              1: FlexColumnWidth(110),
                              // 2: FlexColumnWidth(100),
                              2: FlexColumnWidth(18),
                            }, children: [
                              TableRow(
                                  decoration: BoxDecoration(
                                      color: kBgLightColor,
                                      //   color: Colors.grey,
                                      boxShadow: myboxShadow,
                                      border: Border.all(color: Colors.grey)),
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Code'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Doctor's Name"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(""),
                                    ),
                                  ]),
                            ]),
                          ],
                        );
                      },
                    ),
                  ),
                  //label: "All Doctors List",
                  //labelToChildDistance: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

abstract class _otDocCatState {}

class _otDocCatInitState extends _otDocCatState {}

class _otDocCatErrorState extends _otDocCatState {
  final String msg;

  _otDocCatErrorState({required this.msg});
}

class _otDocCatLodingState extends _otDocCatState {}

class _otDocCatLoadedState extends _otDocCatState {
  final List<_ModuleDocCategory> list;
  _otDocCatLoadedState({required this.list});
}

abstract class _otDocCatEvent {}

class _otDocCatSetEvent extends _otDocCatEvent {
  final String id;
  _otDocCatSetEvent({required this.id});
}

class _otDocCatBloc extends Bloc<_otDocCatEvent, _otDocCatState> {
  _otDocCatBloc() : super(_otDocCatInitState()) {
    on<_otDocCatSetEvent>((event, emit) async {
      emit(_otDocCatLodingState());
      data_api apiRepository = data_api();
      try {
        final mList = await apiRepository.createLead([
          {'tag': '65', "Pcontrol": "DisplayCattype", "Pwhere": event.id}
        ]);
        List<_ModuleDocCategory> lists =
            mList.map((e) => _ModuleDocCategory.fromJson(e)).toList();
        emit(_otDocCatLoadedState(list: lists));
      } on Error catch (e) {
        emit(_otDocCatErrorState(msg: e.toString()));
      }
      //emit(_otDocCatLoadedState(list: []));
    });
  }
}

// ignore: unused_element
class _ModuleDocCategory {
  String? iDMASTER;
  String? dOCTORSCODE;
  String? eMPNAME;
  int? aSSIGNMENTTYPE;

  _ModuleDocCategory(
      {this.iDMASTER, this.dOCTORSCODE, this.eMPNAME, this.aSSIGNMENTTYPE});
  _ModuleDocCategory.fromJson(Map<String, dynamic> json) {
    iDMASTER = json['ID_MASTER'];
    dOCTORSCODE = json['DOCTORS_CODE'];
    eMPNAME = json['EMPNAME'];
    aSSIGNMENTTYPE = json['ASSIGNMENT_TYPE'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID_MASTER'] = iDMASTER;
    data['DOCTORS_CODE'] = dOCTORSCODE;
    data['EMPNAME'] = eMPNAME;
    data['ASSIGNMENT_TYPE'] = aSSIGNMENTTYPE;
    return data;
  }
}

String fixedMasterKey(String strCatName) {
  String strCateValue = "";
  switch (strCatName) {
    case "Surgeon":
      strCateValue = "Surgeon" "0000001";
      break;
    case "RMO":
      strCateValue = "RMO" "0000001";
      break;
    case "OT Nurse":
      strCateValue = "OTNurse" "0000001";
      break;
    case "OT Technician":
      strCateValue = "OTTechnician" "0000001";
      break;
    case "General Nurse":
      strCateValue = "GeneralNurse" "0000001";
      break;
    case "Anesthesiologist":
      strCateValue = "Anesthesiologist" "0000001";
      break;
    case "OT Helper":
      strCateValue = "OTHelper" "0000001";
      break;
    case "Others":
      strCateValue = "Others" "0000001";
      break;
    case "OT Incharge":
      strCateValue = "OT Incharge" "0000001";
      break;
    case "Assistant Surgeon":
      strCateValue = "Assistant Surgeon" "0000001";
      break;
    case "Cathlab":
      strCateValue = "Cathlab" "0000001";
      break;
    case "COT":
      strCateValue = "COT" "0000001";
      break;
  }
  return strCateValue;
}

final List<String> roles = [
  'Assistant Surgeon',
  'RMO',
  'OT Nurse',
  'OT Technician',
  'General Nurse',
  'Anesthesiologist',
  'OT Helper',
  'OT Incharge',
  'Others',
  'Cathlab',
  'COT',
];

class _DoctorLoad extends StatelessWidget {
  const _DoctorLoad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: get_doctor(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ModelForSetDoctorType>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //             // While the Future is still running, you can return a loading indicator or placeholder
          return const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ));
        } else if (snapshot.hasError) {
          // If there's an error, handle it accordingly
          return Text('Error: ${snapshot.error}');
        }

        return Table(
          columnWidths: const {
            0: FixedColumnWidth(80),
            1: FlexColumnWidth(110),
            // 2: FlexColumnWidth(100),
            2: FlexColumnWidth(18),
          },
          children: [
            TableRow(
                decoration: BoxDecoration(
                  color: kBgLightColor,
                  //   color: Colors.grey,
                  boxShadow: myboxShadow,
                ),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Code'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Doctor's Name"),
                  ),
                  //  Padding(
                  //    padding: EdgeInsets.all(8.0),
                  //    child: Text('Unit'),
                  //  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(""),
                  ),
                ]),
            ...snapshot.data!.map((e) {
              return TableRow(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                children: [
                  TableCell(child: Text(e.eMPID!)),
                  Text(e.eMPNAME!),
                  const TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Icon(Icons.edit_attributes)),
                ],
              );
            }).toList(),
          ],
          border: TableBorder.all(
              width: 0.3, color: const Color.fromARGB(255, 89, 92, 92)),
        );
      },
    );
  }
}
