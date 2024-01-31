import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../component/settings/config.dart';
import '../../../../component/widget/custom_button.dart';
import '../../../../component/widget/custom_datepicker.dart';
import '../../../../component/widget/custom_dropdown.dart';
import '../../../../component/widget/custom_search_box.dart';
import '../../../../component/widget/custom_textbox.dart';
import '../bloc/doctor_leave_bloc.dart';
import '../data/data_doctor_leave.dart';
import '../model/doctor_leave_list.dart';
import '../model/doctor_list_model.dart';

 Widget doctorLeaveEntry() {
  final TextEditingController _fdateController = TextEditingController();
  final TextEditingController _tdateController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  List<DoctorList> dlistCombo = [];
  String? did;
  return Padding(
    padding: const EdgeInsets.only(top: 100),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          width: double.infinity, //< 650 ? size.width : 350,
          decoration: BoxDecoration(
            color: kBgLightColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey, width: 0.1),
          ),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 6, left: 4),
                child: Text(
                  "Leave Info",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: CustomDatePicker(
                          date_controller: _fdateController,
                          label: "From Date",
                          bgColor: Colors.white,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: CustomDatePicker(
                          date_controller: _tdateController,
                          label: "To Date",
                          width: double.infinity,
                          bgColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 8, right: 2),
                child: BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
                  builder: (context, state) {
                    if (state is DoctorSearchSetDoctorListState) {
                      // isSected = state.isSelected;
                      dlistCombo = state.list;
                      did = null;
                    }
                    return CustomDropDown(
                      id: did,
                      list: dlistCombo.map((item) {
                        return DropdownMenuItem<String>(
                          value: item.dOCID, // Convert item.id to String.
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              item.dOCTORNAME!,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onTap: (value) {
                        did = value.toString();
                        //                    did = value.toString();
                        //  onTap(value!);
                      },
                      width: double.infinity,
                      labeltext: "Select Responsible Doctor",
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 1, top: 8),
                child: CustomTextBox(
                  isFilled: true,
                  caption: 'Remarks',
                  controller: _remarksController,
                  onChange: (value) {},
                  width: double.infinity,
                  height: 80,
                  maxLine: 4,
                  maxlength: 150,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 4, right: 4, bottom: 8, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: CustomButton(text: "Submit", onPressed: () {}),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}



Widget searchPanel() {
  final TextEditingController txt = TextEditingController();
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
      builder: (context, state) {
        return CustomSearchBox(
         
          isFilled: true,
          caption: "Search Doctor",
          borderRadious: 8.0,
          width: double.infinity,
          controller: txt,
          onChange: (val) {
            context
                .read<DoctorSearchBloc>()
                .add(DoctorListSearchEvent(txt: txt.text));
            // print(txt.text);
          },
          onTap: () {
            context
                .read<DoctorSearchBloc>()
                .add(DoctorSearchIsSelectedEvent(isSelected: true));
          },
        );
      },
    ),
  );
}


Widget closeButtonPanel() {
  bool isSected = false;
 return BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
    builder: (context, state) {
      if (state is DoctorSearchIsSelectedState) {
        isSected = state.isSelected;
      }
      if (state is DoctorSearchCloseState) {
        isSected = state.isSelected;
      }
      if (state is DoctorSearchSetDoctorListState) {
        isSected = state.isSelected;
      }
      return isSected ? closeButton() : const SizedBox();
    },
  );
}

Widget listGenerator() {
  bool isSected = false;
  return BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
    // buildWhen: (previous, current) =>
    //     previous != current,
    builder: (context, state) {
      //  print('1233333');
      if (state is DoctorSearchIsSelectedState) {
        isSected = state.isSelected;
      }
      if (state is DoctorSearchCloseState) {
        isSected = state.isSelected;
      }
      if (state is DoctorSearchSetDoctorListState) {
        isSected = state.isSelected;
      }

      return isSected ? doctorListGenator() : const SizedBox();
    },
  );
}

Widget doctorSelectionPanel() {
  String docId = '', docName = '';
  return Padding(
    padding: const EdgeInsets.only(top: 45),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(color: kBgLightColor),
          padding: const EdgeInsets.only(left: 8),
          child: const Text(
            "Selected Doctor",
            style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: Colors.blue),
          ),
        ),
        BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
          builder: (context, state) {
            if (state is DoctorListGetDocIdNameState) {
              docId = state.docId;
              docName = state.docName;
            }
            return Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity, // < 650 ? size.width : 350,
              margin: const EdgeInsets.only(top: 0),

              decoration: BoxDecoration(
                color: kBgLightColor,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey, width: 0.1),
              ),
              // alignment: Alignment.topCenter,
              child: docId != ''
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Doctor : ",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, color: Colors.black),
                        ),
                        Text(
                          "$docId, ",
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            docName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    )
                  : const Text(
                      "No Doctor Selected",
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.left,
                    ),
            );
          },
        ),
      ],
    ),
  );
}


Widget expandedPanel(){
  bool isChecked1 = false;
    List<DoctorLeaveList> list = [];
    //TextEditingController _txt=TextEditingController();
    return BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
      builder: (context, state) {
        if (state is DoctorListLoadingLeaveDataState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            )),
          );
        }

        if (state is DoctorListLeaviveDoadedState) {
          list = state.lList;
          isChecked1 = state.isChecked;
          // print(list.length);
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomTextBox(caption: "caption", controller: _txt, onChange: (onChange){}),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  value: isChecked1,
                  onChanged: (bool? value) {
                    // onChange(value);
                    isChecked1 = value!;
                    if (value == true) {
                      context.read<DoctorSearchBloc>().add(
                          DoctorSearchCheckAllEvent(
                              isSChecked: true, docID: ''));
                    } else {
                      context.read<DoctorSearchBloc>().add(
                          DoctorSearchCheckAllEvent(
                              isSChecked: false, docID: Data_doctor_leave.docId));
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    "Display the list of all doctors on leave",
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Table(
                    columnWidths: const {
                      0: FixedColumnWidth(80),
                      1: FlexColumnWidth(100),
                      2: FlexColumnWidth(80),
                      3: FlexColumnWidth(80),
                      4: FlexColumnWidth(80),
                      5: FlexColumnWidth(100),
                      6: FlexColumnWidth(40),
                    },
                    children: [
                      TableRow(
                          decoration: BoxDecoration(
                            //   color: Colors.grey,
                            boxShadow: myboxShadow,
                          ),
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Doc ID'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Doctor Name'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('From Date'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('To Date'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Remarks'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Ref Doctor'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Action'),
                            ),
                          ]),
                    ],
                    border: TableBorder.all(
                        width: 0.3,
                        color: const Color.fromARGB(255, 89, 92, 92)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Table(
                    columnWidths: const {
                      0: FixedColumnWidth(80),
                      1: FlexColumnWidth(100),
                      2: FlexColumnWidth(80),
                      3: FlexColumnWidth(80),
                      4: FlexColumnWidth(80),
                      5: FlexColumnWidth(100),
                      6: FlexColumnWidth(40),
                    },
                    children: list.map((e) {
                      return TableRow(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.dOCID!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.dOCTORNAME!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.lEAVESDATE!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.lEAVEEDATE!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.lEAVECAUSE!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text(e.rEFDNAME == null ? '' : e.rEFDNAME!),
                            ),
                             TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
                              child: InkWell(
                                onTap: (){},
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.delete,size: 24,color: kGrayColor,),
                                ),
                              ),
                            ),
                          ]);
                    }).toList(),
                    border: TableBorder.all(
                        width: 0.3,
                        color: const Color.fromARGB(255, 89, 92, 92)),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
}


// import 'package:flutter/material.dart';
// import 'package:web_2/pages/appointment/doctor_leave_page/doctor_leave.dart';

// import '../../../../component/settings/config.dart';
// import '../../../../component/widget/custom_button.dart';
// import '../../../../component/widget/custom_datepicker.dart';
// import '../../../../component/widget/custom_dropdown.dart';
// import '../../../../component/widget/custom_search_box.dart';
// import '../../../../component/widget/custom_textbox.dart';

// import '../bloc/doctor_leave_bloc.dart';
// import '../model/doctor_leave_list.dart';
// import '../model/doctor_list_model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// Widget expandedDetailsPart(Size size, List<DoctorLeaveList> lst1,
//     bool isChecked, Function(bool? isCheck) onChange) {
//   // if (state is DoctorListLoadingState) {
//   //   return const Expanded(
//   //     child: Center(
//   //       child: Padding(
//   //         padding: EdgeInsets.all(8.0),
//   //         child: CircularProgressIndicator(),
//   //       ),
//   //     ),
//   //   );
//   // }

//   return Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Checkbox(
//             checkColor: Colors.white,
//             value: isChecked,
//             onChanged: (bool? value) {
//               onChange(value);
//             },
//           ),
//           const Padding(
//             padding: EdgeInsets.only(top: 6),
//             child: Text(
//               "Display the list of all doctors on leave",
//               style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
//             ),
//           ),
//         ],
//       ),
//       SizedBox(
//         width: double.infinity, //size.width < 650 ? 600 : size.width - 600,
//         // height: size.width < 650 ? size.height * .4 : size.height - 100,
//         child: SingleChildScrollView(
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: SizedBox(
//               width: size.width < 1360 ? 1200 : size.width - 600,
//               // height: 1000,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 6),
//                     child: Table(
//                       columnWidths: const {
//                         0: FixedColumnWidth(80),
//                         1: FlexColumnWidth(100),
//                         2: FlexColumnWidth(80),
//                         3: FlexColumnWidth(80),
//                         4: FlexColumnWidth(80),
//                         5: FlexColumnWidth(100),
//                         6: FlexColumnWidth(40),
//                       },
//                       children: [
//                         TableRow(
//                             decoration: BoxDecoration(
//                               //   color: Colors.grey,
//                               boxShadow: myboxShadow,
//                             ),
//                             children: const [
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('Doc ID'),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('Doctor Name'),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('From Date'),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('To Date'),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('Remarks'),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('Ref Doctor'),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('Action'),
//                               ),
//                             ]),
//                       ],
//                       border: TableBorder.all(
//                           width: 0.3,
//                           color: const Color.fromARGB(255, 89, 92, 92)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 6),
//                     child: Table(
//                       columnWidths: const {
//                         0: FixedColumnWidth(80),
//                         1: FlexColumnWidth(100),
//                         2: FlexColumnWidth(80),
//                         3: FlexColumnWidth(80),
//                         4: FlexColumnWidth(80),
//                         5: FlexColumnWidth(100),
//                         6: FlexColumnWidth(40),
//                       },
//                       children: lst1.map((e) {
//                         return TableRow(
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.black)),
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(e.dOCID!),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(e.dOCTORNAME!),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(e.lEAVESDATE!),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(e.lEAVEEDATE!),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(e.lEAVECAUSE!),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child:
//                                     Text(e.rEFDNAME == null ? '' : e.rEFDNAME!),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: CustomButton(
//                                   onPressed: () {},
//                                   text: 'Edit',
//                                 ),
//                               ),
//                             ]);
//                       }).toList(),
//                       border: TableBorder.all(
//                           width: 0.3,
//                           color: const Color.fromARGB(255, 89, 92, 92)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       )
//     ],
//   );
// }


Widget doctorListGenator(
  
   ) {
  List<DoctorList> dList=Data_doctor_leave.dList;
  //List<DoctorList> dlistMain,
  List<DoctorList> dlistCombo=[];

  return Padding(
    padding: const EdgeInsets.only(left: 8, top: 36, right: 6),
    child: Stack(
      children: [
        Container(
          width: double.infinity, //< 650 ? size.width * 0.96 : 337,
          height: 310,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 0.5)),
              child: BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
              builder: (context, state) {
             // print(state.toString());
              if (state is DoctorListSearchState) {
               // String s = state.txt;
               // print(state.txt);
                dList = Data_doctor_leave.dList
                    .where((element) =>
                        element.dOCTORNAME!
                            .toLowerCase()
                            .contains(state.txt.toString().toLowerCase()) ||
                        element.uNIT!
                            .toLowerCase()
                            .contains(state.txt.toString().toLowerCase()) ||
                        element.dOCID!
                            .toLowerCase()
                            .contains(state.txt.toString().toLowerCase()))
                    .toList();
                //  dList = state.dList;
              }
              return ListView.builder(
                itemCount: dList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {

                             Data_doctor_leave.docId = dList[index].dOCID!;
                         dlistCombo =Data_doctor_leave.dList
                                          .where((element) =>
                                              element.uNIT == dList[index].uNIT &&
                                              element.dOCTORNAME != dList[index].dOCTORNAME)
                                          .toList();

                                      context.read<DoctorSearchBloc>().add(
                                          DoctorSearchCheckAllEvent(
                                              isSChecked: false,
                                              docID: Data_doctor_leave.docId));


                                      context.read<DoctorSearchBloc>().add(
                                          DoctorSearchSetDoctorListEvent(
                                              isSelected: false,
                                              list: dlistCombo,
                                              docId: dList[index].dOCID!,
                                              docName: dList[index].dOCTORNAME!));


                      // //did = null;
                      // onTap(dList[index].dOCID, dList[index].dOCTORNAME,
                      //     dList[index].uNIT);
                    },
                    child: Container(
                      width: 550,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxWidth: 30, minWidth: 30),
                                  child: Text(
                                    dList[index].dOCID!,
                                    style: const TextStyle(fontSize: 12),
                                  )),
                              const SizedBox(
                                width: 8,
                              ),
                              ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxWidth: 190, minWidth: 190),
                                  child: Text(
                                    dList[index].dOCTORNAME!,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              dList[index].uNIT!,
                              style: const TextStyle(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
    // ignore: dead_code
  );
}



// Widget doctorSelectedPart() {
//   String docId = '', docName = '';
//   return Padding(
//     padding: const EdgeInsets.only(top: 45),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           decoration: const BoxDecoration(color: kBgLightColor),
//           padding: const EdgeInsets.only(left: 8),
//           child: const Text(
//             "Selected Doctor",
//             style: TextStyle(
//                 fontSize: 12,
//                 fontStyle: FontStyle.italic,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.blue),
//           ),
//         ),
//         BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
//           builder: (context, state) {
//             if (state is DoctorListGetDocIdNameState) {
//               docId = state.docId;
//               docName = state.docName;
//             }
//             return Container(
//               padding: const EdgeInsets.all(8),
//               width: double.infinity, // < 650 ? size.width : 350,
//               margin: const EdgeInsets.only(top: 0),

//               decoration: BoxDecoration(
//                 color: kBgLightColor,
//                 borderRadius: BorderRadius.circular(4),
//                 border: Border.all(color: Colors.grey, width: 0.1),
//               ),
//               // alignment: Alignment.topCenter,
//               child: docId != ''
//                   ? Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "ID: ",
//                           style: TextStyle(fontWeight: FontWeight.w600),
//                         ),
//                         Text(docId!),
//                         const SizedBox(
//                           width: 6,
//                         ),
//                         const Text(
//                           "NAME: ",
//                           style: TextStyle(fontWeight: FontWeight.w600),
//                         ),
//                         ConstrainedBox(
//                             constraints: const BoxConstraints(
//                                 maxWidth: 220, maxHeight: 15),
//                             child: Text(
//                               docName,
//                               style: const TextStyle(
//                                   color: Color.fromARGB(255, 0, 42, 77)),
//                             )),
//                       ],
//                     )
//                   : const Text(
//                       "No Doctor Selected",
//                       style: TextStyle(color: Colors.red),
//                       textAlign: TextAlign.left,
//                     ),
//             );
//           },
//         ),
//       ],
//     ),
//   );
// }

// Widget leaveInfoEntry(
//     Size size,
//     TextEditingController fdateController,
//     TextEditingController tdateController,
//     TextEditingController remarksController,
//     List<DoctorList> dlistCombo,
//     String? did,
//     Function(String val) onTap) {
//   return Padding(
//     padding: const EdgeInsets.only(top: 100),
//     child: Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(4),
//           width: size.width, //< 650 ? size.width : 350,
//           decoration: BoxDecoration(
//             color: kBgLightColor,
//             borderRadius: BorderRadius.circular(4),
//             border: Border.all(color: Colors.grey, width: 0.1),
//           ),
//           alignment: Alignment.topCenter,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(bottom: 6, left: 4),
//                 child: Text(
//                   "Leave Info",
//                   style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                       fontStyle: FontStyle.italic,
//                       color: Colors.blue),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(right: 4),
//                         child: CustomDatePicker(
//                           date_controller: fdateController,
//                           label: "From Date",
//                           bgColor: Colors.white,
//                           width: double.infinity,
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 4),
//                         child: CustomDatePicker(
//                           date_controller: tdateController,
//                           label: "To Date",
//                           width: double.infinity,
//                           bgColor: Colors.white,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 4, top: 8, right: 2),
//                 child: CustomDropDown(
//                   id: did,
//                   list: dlistCombo.map((item) {
//                     return DropdownMenuItem<String>(
//                       value: item.dOCID, // Convert item.id to String.
//                       child: Padding(
//                         padding: const EdgeInsets.all(0),
//                         child: Text(
//                           item.dOCTORNAME!,
//                           style: const TextStyle(
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                   onTap: (value) {
//                     //did = value.toString();
// //                    did = value.toString();
//                     onTap(value!);
//                   },
//                   width: double.infinity,
//                   labeltext: "Select Responsible Doctor",
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 1, top: 8),
//                 child: CustomTextBox(
//                   isFilled: true,
//                   caption: 'Remarks',
//                   controller: remarksController,
//                   onChange: (value) {},
//                   width: double.infinity,
//                   height: 80,
//                   maxLine: 4,
//                   maxlength: 150,
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.only(left: 4, right: 4, bottom: 8, top: 4),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 4),
//                       child: CustomButton(text: "Submit", onPressed: () {}),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget searchBoxDoctor(
//     Size size,
//     TextEditingController searchController,
//     // ignore: use_function_type_syntax_for_parameters
//     onChange(),
//     Function() onTap) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 4),
//     child: CustomSearchBox(
//       borderBolor: Colors.black,
//       isFilled: true,
//       caption: "Search Doctor",
//       borderRadious: 8.0,
//       width: size.width, //< 650 ? size.width : 340,
//       controller: searchController,
//       onChange: (val) {
//         onChange();
//       },
//       onTap: () {
//         onTap();
//       },
//     ),
//   );
// }

Widget closeButton() {
  return BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
    builder: (context, state) {
      return Positioned(
          top: 14,
          right: 4,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                context
                    .read<DoctorSearchBloc>()
                    .add(DoctorSearchCloseEvent(isSelected: false));
              },
              child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black),
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.white,
                  )),
            ),
          ));
    },
  );
}

// Widget disableCover() {
//   return Padding(
//     padding: const EdgeInsets.only(top: 100),
//     child: Container(
//       width: double.infinity,
//       color: Colors.white.withOpacity(0.75),
//       height: 260,
//     ),
//   );
// }
