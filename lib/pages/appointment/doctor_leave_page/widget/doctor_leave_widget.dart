import 'package:flutter/material.dart';
import 'package:web_2/model/main_app_menu.dart';

import '../../../../component/settings/config.dart';
import '../../../../component/widget/custom_button.dart';
import '../../../../component/widget/custom_datepicker.dart';
import '../../../../component/widget/custom_dropdown.dart';
import '../../../../component/widget/custom_search_box.dart';
import '../../../../component/widget/custom_textbox.dart';

import '../bloc/doctor_leave_bloc.dart';
import '../model/doctor_leave_list.dart';
import '../model/doctor_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget expandedDetailsPart(Size size,List<DoctorLeaveList> lst1 ,
    bool isChecked, DoctorSearchState state, Function(bool? isCheck) onChange) {
    
  if (state is DoctorListLoadingState) {
    return const Expanded(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

 

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            checkColor: Colors.white,
            value: isChecked,
            onChanged: (bool? value) {
              onChange(value);
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



      SizedBox(
        width: size.width<650?600:size.width-600 ,
        height: size.width<650? size.height*.4: size.height-100,
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: size.width<1360?1200:size.width-600,
             // height: 1000,
              child: Column(
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
                      width: 0.3, color: const Color.fromARGB(255, 89, 92, 92)),
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
                  children: lst1.map((e) {
                    return  TableRow(
                      decoration: BoxDecoration(
                        border:Border.all(color: Colors.black) 
                      ),
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
                            child: Text(e.rEFDNAME==null?'':e.rEFDNAME!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:CustomButton(onPressed: () {
                              
                            }, text: 'Edit',),
                          ),
                      ]
                    );
                  }).toList(),
                  border: TableBorder.all(
                      width: 0.3, color: const Color.fromARGB(255, 89, 92, 92)),
                ),
               ),
                  
                ],
              ),
            ),
          ),
        ),
      )

    
    
       ],
  );
}

Widget doctorListGenator(
    Size size,
    String? did,
    String? docId,
    String? docName,
    List<DoctorList> dList,
    List<DoctorList> dlistMain,
    List<DoctorList> dlistCombo,
    Function(String? docID, String? dName, String? unitName) onTap) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, top: 36),
    child: Stack(
      children: [
        Container(
          width: size.width < 650 ? size.width * 0.96 : 337,
          height: 310,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 0.5)),
          child: ListView.builder(
            itemCount: dList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // //did = null;
                  onTap(dList[index].dOCID, dList[index].dOCTORNAME,
                      dList[index].uNIT);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
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
                            width: 2,
                          ),
                          ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxWidth: 190, minWidth: 190),
                              child: Text(
                                dList[index].dOCTORNAME!,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              )),
                        ],
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                      ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Text(
                            dList[index].uNIT!,
                            style: const TextStyle(fontSize: 12),
                          ))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
    // ignore: dead_code
  );
}

Widget doctorSelectedPart(Size size, String? docId, String docName) {
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
        Container(
          padding: const EdgeInsets.all(8),
          width: size.width < 650 ? size.width : 350,
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
                      "ID: ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(docId!),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      "NAME: ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 220, maxHeight: 15),
                        child: Text(
                          docName,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 42, 77)),
                        )),
                  ],
                )
              : const Text(
                  "No Doctor Selected",
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.left,
                ),
        ),
      ],
    ),
  );
}

Widget leaveInfoEntry(
    Size size,
    TextEditingController fdateController,
    TextEditingController tdateController,
    TextEditingController remarksController,
    List<DoctorList> dlistCombo,
    String? did,
    Function(String val) onTap) {
  return Padding(
    padding: const EdgeInsets.only(top: 100),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          width: size.width < 650 ? size.width : 350,
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
                    CustomDatePicker(
                      date_controller: fdateController,
                      label: "From Date",
                      bgColor: Colors.white,
                      width: size.width < 650 ? size.width * 0.45 : 150,
                    ),
                    CustomDatePicker(
                      date_controller: tdateController,
                      label: "To Date",
                      width: size.width < 650 ? size.width * 0.45 : 150,
                      bgColor: Colors.white,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 8),
                child: CustomDropDown(
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
                    //did = value.toString();
//                    did = value.toString();
                    onTap(value!);
                  },
                  width: size.width < 650 ? size.width * 0.96 : 334,
                  labeltext: "Select Responsible Doctor",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 1, right: 1, top: 8),
                child: CustomTextBox(
                  isFilled: true,
                  caption: 'Remarks',
                  controller: remarksController,
                  onChange: (value) {},
                  width: size.width < 650 ? size.width : 336,
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

Widget searchBoxDoctor(
    Size size,
    TextEditingController searchController,
    // ignore: use_function_type_syntax_for_parameters
    onChange(),
    Function() onTap) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: CustomSearchBox(
      borderBolor: Colors.black,
      isFilled: true,
      caption: "Search Doctor",
      borderRadious: 8.0,
      width: size.width < 650 ? size.width : 340,
      controller: searchController,
      onChange: (val) {
        onChange();
      },
      onTap: () {
        onTap();
      },
    ),
  );
}

Widget closeButton(BuildContext context) {
  return Positioned(
      top: 14,
      right: 4,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: () {
            context
                .read<DoctorSearchBloc>()
                .add(DoctorSearchIsSelectedEvent(isSelected: false));
          },
          child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.black),
              child: const Icon(
                Icons.close,
                size: 18,
                color: Colors.white,
              )),
        ),
      ));
}

Widget disableCover(Size size) {
  return Padding(
    padding: const EdgeInsets.only(top: 100),
    child: Container(
      width: size.width < 650 ? size.width : 350,
      color: Colors.white.withOpacity(0.75),
      height: 260,
    ),
  );
}
