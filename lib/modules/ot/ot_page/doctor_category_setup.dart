// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_search_box.dart';
import 'package:web_2/component/widget/custom_snakbar.dart';
import 'package:web_2/data/data_api.dart';

import 'package:web_2/modules/ot/ot_page/model/model_for_set_doctor_type.dart';

import '../../../component/settings/config.dart';
import 'share/ot_share_data.dart';

class DoctorCategorySetup extends StatelessWidget {
  const DoctorCategorySetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    TextEditingController _txtSearch = TextEditingController();
    List<String> lid = [];
    String? cid;
    List<_ModuleDocCategory>? list = [];
    List<_ModuleDocCategory> list_main = [];
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      //Size size = Size( constraints.maxWidth,constraints.maxHeight);
      return Scaffold(
        body: BlocProvider(
          create: (context) => _otDocCatBloc(),
          child: Padding(
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
                          BlocBuilder<_otDocCatBloc, _otDocCatState>(
                            builder: (context, state) {
                              return CustomSearchBox(
                                caption: "Search Doctor",
                                controller: _txtSearch,
                                isFilled: true,
                                width: double.infinity,
                                maxlength: 50,
                                height: 32,
                                onChange: (v) {
                                  context.read<_otDocCatBloc>().add(
                                      _otDocCatSearchEvent(
                                          txt: _txtSearch.text));
                                },
                              );
                            },
                          ),

                          const SizedBox(height: 4),
                          // Text("data"),
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
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
                SizedBox(
                  //color: Colors.amber,
                  width: 32,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            if (cid == null) {
                              CustomSnackbar(
                                  context: context,
                                  message: "Select Doctor Category!",
                                  type: MsgType.warning);

                              return;
                            }
                            if (lid.isEmpty) {
                              CustomSnackbar(
                                  context: context,
                                  message:
                                      "No Doctor Select to Assign in Category!",
                                  type: MsgType.warning);
                              return;
                            }
                          },
                          child: const Icon(
                              Icons.keyboard_double_arrow_right_sharp)),

                      // Icon(Icons.keyboard_double_arrow_left_sharp),
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
                          if (state is _otDocCatLodingState) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          if (state is _otDocCatLoadedState) {
                            list = state.list;

                            // print(list.length);
                          }
                          if (state is _otDocCatCheckBoxState) {
                            lid = state.ilist;
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
                              Flexible(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Table(
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
                                            //border: Border.all(color: Colors.grey)
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
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(""),
                                            ),
                                          ],
                                        ),
                                        ...list!
                                            .map((e) => TableRow(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color:
                                                                Colors.grey)),
                                                    children: [
                                                      TableCell(
                                                        verticalAlignment:
                                                            TableCellVerticalAlignment
                                                                .middle,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          child: Text(
                                                              e.dOCTORSCODE!),
                                                        ),
                                                      ),
                                                      TableCell(
                                                          verticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8),
                                                            child: Text(
                                                                e.eMPNAME!),
                                                          )),
                                                       TableCell(
                                                          verticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          child: Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        4),
                                                            child: InkWell(
                                                              onTap: (){

                                                              },
                                                              child: const Icon(
                                                                Icons.delete,
                                                                color: kGrayColor,
                                                                size: 24,
                                                              ),
                                                            ),
                                                          )),
                                                    ]))
                                            .toList(),
                                      ],
                                      border: TableBorder.all(
                                          width: 0.3,
                                          color: const Color.fromARGB(
                                              255, 89, 92, 92)),
                                    ),
                                  ],
                                ),
                              ),
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
    });
  }
}

abstract class _otDocCatState {}

class _otDocCatInitState extends _otDocCatState {}

class _otDocCatCheckBoxState extends _otDocCatState {
  final List<String> ilist;

  _otDocCatCheckBoxState({required this.ilist});
}

class _otDocCatSearchState extends _otDocCatState {
  final String txt;
  _otDocCatSearchState({required this.txt});
}

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

class _otDocCatCheckBoxEvent extends _otDocCatEvent {
  final List<String> ilist;

  _otDocCatCheckBoxEvent({required this.ilist});
}

class _otDocCatSetEvent extends _otDocCatEvent {
  final String id;
  _otDocCatSetEvent({required this.id});
}

class _otDocCatSearchEvent extends _otDocCatEvent {
  final String txt;
  _otDocCatSearchEvent({required this.txt});
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
    on<_otDocCatCheckBoxEvent>((event, emit) {
      emit(_otDocCatCheckBoxState(ilist: event.ilist));
    });
    on<_otDocCatSearchEvent>((event, emit) {
      emit(_otDocCatSearchState(txt: event.txt));
    });
  }
}

// ignore: unused_element
class _ModuleDocCategory {
  String? iDMASTER;
  String? dOCTORSCODE;
  String? eMPNAME;
  int? aSSIGNMENTTYPE;

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

// // ignore: non_constant_identifier_names
// _DoctorLoad(List<String> lid) {
//   return FutureBuilder(
//     future: get_doctor(),
//     builder: (BuildContext context,
//         AsyncSnapshot<List<ModelForSetDoctorType>> snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         //             // While the Future is still running, you can return a loading indicator or placeholder
//         return const Center(
//             child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: CircularProgressIndicator(),
//         ));
//       } else if (snapshot.hasError) {
//         // If there's an error, handle it accordingly
//         return Text('Error: ${snapshot.error}');
//       }

//       return BlocBuilder<_otDocCatBloc, _otDocCatState>(
//         builder: (context, state) {
//           return Table(
//             columnWidths: const {
//               0: FixedColumnWidth(80),
//               1: FlexColumnWidth(110),
//               // 2: FlexColumnWidth(100),
//               2: FlexColumnWidth(18),
//             },
//             children: [
//               TableRow(
//                   decoration: BoxDecoration(
//                     color: kBgLightColor,
//                     //   color: Colors.grey,
//                     boxShadow: myboxShadow,
//                   ),
//                   children: const [
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text('Code'),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text("Doctor's Name"),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(""),
//                     ),
//                   ]),
//               ...snapshot.data!.map((e) {
//                 return TableRow(
//                   decoration: BoxDecoration(
//                     color: lid.contains(e.eMPID) ? kMarkupColor : Colors.white,
//                   ),
//                   children: [
//                     TableCell(
//                       verticalAlignment: TableCellVerticalAlignment.middle,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         child: Text(e.eMPID!),
//                       ),
//                     ),
//                     TableCell(
//                       verticalAlignment: TableCellVerticalAlignment.middle,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         child: Text(e.eMPNAME!),
//                       ),
//                     ),
//                     TableCell(
//                         verticalAlignment: TableCellVerticalAlignment.middle,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8),
//                           child: Checkbox(
//                             value: lid.contains(e.eMPID),
//                             onChanged: (va) {
//                               if (lid.contains(e.eMPID)) {
//                                 lid.removeAt(lid.indexOf(e.eMPID!));
//                               } else {
//                                 lid.add(e.eMPID!);
//                               }

//                               context
//                                   .read<_otDocCatBloc>()
//                                   .add(_otDocCatCheckBoxEvent());
//                             },
//                             activeColor:
//                                 kBgDarkColor, // Change fill color when checkbox is checked
//                             checkColor: Colors.black,
//                             shape: RoundedRectangleBorder(
//                               side: BorderSide.none,
//                               borderRadius: BorderRadius.circular(
//                                   2.0), // Set the border radius
//                             ),
//                             materialTapTargetSize:
//                                 MaterialTapTargetSize.shrinkWrap,
//                           ),
//                         )),
//                   ],
//                 );
//               }).toList(),
//             ],
//             border: TableBorder.all(
//                 width: 0.3, color: const Color.fromARGB(255, 89, 92, 92)),
//           );
//         },
//       );
//     },
//   );
// }

class _DoctorLoad extends StatelessWidget {
  const _DoctorLoad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> lid = [];

    List<ModelForSetDoctorType> slist = [];
    List<ModelForSetDoctorType> list_main = [];
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
        slist = snapshot.data!;
        list_main = snapshot.data!;
        return BlocBuilder<_otDocCatBloc, _otDocCatState>(
          builder: (context, state) {
            if (state is _otDocCatSearchState) {
            //  print(state);
              slist = list_main
                  .where((element) => element.eMPNAME!
                      .toUpperCase()
                      .contains(state.txt.toUpperCase()))
                  .toList();
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
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(""),
                      ),
                    ]),
                ...slist.map((e) {
                  return TableRow(
                    decoration: BoxDecoration(
                      color:
                          lid.contains(e.eMPID) ? kMarkupColor : Colors.white,
                    ),
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(e.eMPID!),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(e.eMPNAME!),
                        ),
                      ),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Checkbox(
                              value: lid.contains(e.eMPID),
                              onChanged: (va) {
                                if (lid.contains(e.eMPID)) {
                                  lid.removeAt(lid.indexOf(e.eMPID!));
                                } else {
                                  lid.add(e.eMPID!);
                                }

                                context
                                    .read<_otDocCatBloc>()
                                    .add(_otDocCatCheckBoxEvent(ilist: lid));
                              },
                              activeColor:
                                  kBgDarkColor, // Change fill color when checkbox is checked
                              checkColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                                borderRadius: BorderRadius.circular(
                                    2.0), // Set the border radius
                              ),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          )),
                    ],
                  );
                }).toList(),
              ],
              border: TableBorder.all(
                  width: 0.3, color: const Color.fromARGB(255, 89, 92, 92)),
            );
          },
        );
      },
    );
  }
}
