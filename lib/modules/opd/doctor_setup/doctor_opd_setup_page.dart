import 'package:accordion/accordion.dart';
import 'package:accordion/accordion_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/functions.dart';
import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/component/widget/custom_accordian/accordian_header.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_elevated_button.dart';
import 'package:web_2/component/widget/custom_icon_button.dart';
import 'package:web_2/component/widget/custom_search_box.dart';
import 'package:web_2/component/widget/custom_textbox.dart';
import 'package:web_2/component/widget/custom_widget_list.dart';
import 'package:web_2/modules/opd/doctor_setup/controller/doctor_opd_setup_controller.dart';

class DoctorOPDSetuo extends StatelessWidget {
  const DoctorOPDSetuo({super.key});
  void disposeController() {
    try {
      Get.delete<DoctorOPDsetupController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    DoctorOPDsetupController dcontroller = Get.put(DoctorOPDsetupController());
    return Scaffold(
      body: Obx(
        () {
          if (dcontroller.isLoading.value) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (dcontroller.isError.value) {
            return Text(
              dcontroller.errorMessage.value.toString(),
              style: const TextStyle(color: Colors.red),
            );
          }
          return Responsive(
            mobile: _tablet(dcontroller),
            tablet: _tablet(dcontroller),
            desktop: _desktop(dcontroller),
          );
        },
      ),
    );
  }
}

_leftPart(DoctorOPDsetupController econtroller) {
  return CustomAccordionContainer( 
    height: 200,
    headerName: "Doctor Information", children:[

    Row(
      children: [
        Expanded(
            child: CustomSearchBox(
                borderRadious: 2,
                enabledBorderColor: Colors.grey,
                focusedBorderColor: Colors.black,
                enabledBorderwidth: 0.4,
                focusedBorderWidth: 0.3,
                caption: "Search Doctor",
                maxlength: 100,
                controller: TextEditingController(),
                onChange: (onChange) {
                  if (onChange.isNotEmpty) {
                    econtroller.isSearch.value = true;
                  } else {
                    econtroller.isSearch.value = false;
                  }
                })),
      ],
    ),
    Stack(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Obx(() => CustomDropDown(
                              labeltext: "Department Category",
                              labelTextColor: Colors.black54,
                              id: econtroller.cmb_job_catID.value,
                              height: 28,
                              borderRadious: 2,
                              enabledBorderColor: Colors.grey,
                              focusedBorderColor: Colors.black,
                              enabledBorderwidth: 0.4,
                              focusedBorderWidth: 0.3,
                              list:
                                  _getDropdownItem(econtroller, "departmentcategory"),
                              onTap: (value) {
                                econtroller.cmb_job_catID.value =
                                    value.toString();
                              },
                              width: 150,
                            )),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Obx(
                          () => CustomDropDown(
                            labeltext: "Department",
                            labelTextColor: Colors.black54,
                            id: econtroller.cmb_deptID.value,
                            height: 28,
                            borderRadious: 2,
                            enabledBorderColor: Colors.grey,
                            focusedBorderColor: Colors.black,
                            enabledBorderwidth: 0.4,
                            focusedBorderWidth: 0.3,
                            list: _getDropdownItem(econtroller, "department"),
                            onTap: (value) {
                              econtroller.cmb_deptID.value = value.toString();
                            },
                            width: 150,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Obx(() => CustomDropDown(
                              labeltext: "Section",
                              labelTextColor: Colors.black54,
                              id: econtroller.cmb_section_ID.value,
                              height: 28,
                              borderRadious: 2,
                              enabledBorderColor: Colors.grey,
                              focusedBorderColor: Colors.black,
                              enabledBorderwidth: 0.4,
                              focusedBorderWidth: 0.3,
                              list: _getDropdownItem(econtroller, "section"),
                              onTap: (value) {
                                econtroller.cmb_section_ID.value =
                                    value.toString();
                              },
                              width: 150,
                            )),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Obx(
                        () => CustomDropDown(
                          labeltext: "Doctor Name",
                          labelTextColor: Colors.black54,
                          id: econtroller.cmb_doc_ID.value,
                          height: 28,
                          borderRadious: 2,
                          enabledBorderColor: Colors.grey,
                          focusedBorderColor: Colors.black,
                          enabledBorderwidth: 0.4,
                          focusedBorderWidth: 0.3,
                          list: econtroller.dList
                              .map((element) => DropdownMenuItem<String>(
                                  value: element.uid,
                                  child: Text(
                                      '${element.eno!} ${element.dname!}')))
                              .toList(),
                          //_getDropdownItemPat(econtroller, "patienttype"),
                          onTap: (value) {
                            econtroller.cmb_doc_ID.value = value.toString();
                          },
                          width: 150,
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: CustomTextBox(
                        caption: "Degree",
                        controller: TextEditingController(),
                        onChange: (onChange) {}))
              ],
            ),

             
          ],
        ),
        Obx(
          () => econtroller.isSearch.value
              ? Container(
                  width: double.infinity,
                  color: Colors.amber,
                  height: 150,
                )
              : const SizedBox(),
        ),
      ],
    ),
  ]);
}

_rightPart(DoctorOPDsetupController econtroller) {
  return  CustomAccordionContainer(
   
    headerName: "Fees Information",
   children: [
      CustomCaptionForContainer("Visiting setup details",
          kWebBackgroundDeepColor, Colors.grey.shade400),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextBox(
                      labelTextColor: Colors.black54,
                      height: 28,
                      borderRadious: 2,
                      enabledBorderColor: Colors.grey,
                      focusedBorderColor: Colors.black,
                      enabledBorderwidth: 0.4,
                      focusedBorderWidth: 0.3,
                      caption: 'Cycle',
                      controller: TextEditingController(),
                      onChange: (String value) {},
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomTextBox(
                      labelTextColor: Colors.black54,
                      caption: 'Avg Time/Patient',
                      controller: TextEditingController(),
                      onChange: (String value) {},
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomTextBox(
                      labelTextColor: Colors.black54,
                      height: 28,
                      borderRadious: 2,
                      enabledBorderColor: Colors.grey,
                      focusedBorderColor: Colors.black,
                      enabledBorderwidth: 0.4,
                      focusedBorderWidth: 0.3,
                      caption: 'Max visit/day',
                      controller: TextEditingController(),
                      onChange: (String value) {},
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
       CustomCaptionForContainer("Visiting setup details",
                        kWebBackgroundDeepColor, Colors.grey.shade400),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomTextBox(
                                    labelTextColor: Colors.black54,
                                    height: 28,
                                    borderRadious: 2,
                                    enabledBorderColor: Colors.grey,
                                    focusedBorderColor: Colors.black,
                                    enabledBorderwidth: 0.4,
                                    focusedBorderWidth: 0.3,
                                    caption: 'Cycle',
                                    controller: TextEditingController(),
                                    onChange: (String value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomTextBox(
                                    labelTextColor: Colors.black54,
                                    caption: 'Avg Time/Patient',
                                    controller: TextEditingController(),
                                    onChange: (String value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomTextBox(
                                    labelTextColor: Colors.black54,
                                    height: 28,
                                    borderRadious: 2,
                                    enabledBorderColor: Colors.grey,
                                    focusedBorderColor: Colors.black,
                                    enabledBorderwidth: 0.4,
                                    focusedBorderWidth: 0.3,
                                    caption: 'Max visit/day',
                                    controller: TextEditingController(),
                                    onChange: (String value) {},
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                   CustomCaptionForContainer("Doctor Accounting (FFS)",
                        kWebBackgroundDeepColor, Colors.grey.shade400),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomTextBox(
                                    labelTextColor: Colors.black54,
                                    height: 28,
                                    borderRadious: 2,
                                    enabledBorderColor: Colors.grey,
                                    focusedBorderColor: Colors.black,
                                    enabledBorderwidth: 0.4,
                                    focusedBorderWidth: 0.3,
                                    caption: 'First Visit Fees',
                                    controller: TextEditingController(),
                                    onChange: (String value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomTextBox(
                                    labelTextColor: Colors.black54,
                                    height: 28,
                                    borderRadious: 2,
                                    enabledBorderColor: Colors.grey,
                                    focusedBorderColor: Colors.black,
                                    enabledBorderwidth: 0.4,
                                    focusedBorderWidth: 0.3,
                                    caption: 'Second Visit Fees',
                                    controller: TextEditingController(),
                                    onChange: (String value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomTextBox(
                                    labelTextColor: Colors.black54,
                                    height: 28,
                                    borderRadious: 2,
                                    enabledBorderColor: Colors.grey,
                                    focusedBorderColor: Colors.black,
                                    enabledBorderwidth: 0.4,
                                    focusedBorderWidth: 0.3,
                                    caption: 'Report Visit Fees',
                                    controller: TextEditingController(),
                                    onChange: (String value) {},
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    height(8),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        roundedButton(() { }, Icons.save), width(12),    roundedButton(() { }, Icons.undo),width(4),
                      ],
                    ),
                    height(8),


                  
                
  
    ], 
  );




             






}

_tablet(DoctorOPDsetupController econtroller) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: LayoutBuilder(builder: (context, constraints) {
        // print('TAB'+constraints.maxWidth.toString());
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            constraints.maxWidth > 900
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _leftPart(econtroller),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: _rightPart(econtroller),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _leftPart(econtroller),
                      const SizedBox(
                        height: 8,
                      ),
                      _rightPart(econtroller),
                    ],
                  )
          ],
        );
      }),
    ),
  );
}

_desktop(DoctorOPDsetupController econtroller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _leftPart(econtroller),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: _rightPart(econtroller),
            ),
          ],
        ),
        height(),


        Expanded(
          child: CustomAccordionContainer(
            height: 0,
             headerName: "Doctor List",
            children:  [
                Row(
                  children: [
                    Expanded(
                        child: CustomSearchBox(
                            caption: "Search Doctor",
                            controller: TextEditingController(),
                            onChange: (v) {})),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                height(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Table(
                      // columnWidths: const {
                      //       0: FlexColumnWidth(130),
                      //       1: FlexColumnWidth(100),
                      //       2: FlexColumnWidth(80),
                      //       3: FlexColumnWidth(30),
                      //     },
                      children: [
                        for (var i = 0; i < 50; i++)
                          TableRow(
                              decoration: const BoxDecoration(
                                color: kBgDarkColor,
                              ),
                              children: [
                                TableCell(
                                    child: CustomTableCell("Doctor Name")),
                                TableCell(child: CustomTableCell("Department")),
                                TableCell(
                                    child: CustomTableCell("Section/Unit")),
                                TableCell(
                                    child: CustomTableCell("Total 1st Visit")),
                                TableCell(
                                    child: CustomTableCell("Dr. 1st Visit")),
                                TableCell(
                                    child: CustomTableCell("Total 2nd Visit")),
                                TableCell(
                                    child: CustomTableCell("Dr. 2nd Visit")),
                                TableCell(
                                    child: CustomTableCell("Total Rpt Visit")),
                                TableCell(
                                    child: CustomTableCell("Dr. Rpt Visit")),
                                TableCell(
                                    child: CustomTableCell("Interval Time")),
                                TableCell(child: CustomTableCell("Degree")),
                              ])
                      ],
                      border: CustomTableBorder(),
                    ),
                  ),
                )
               ],
              ),
        )
     
     
     
     ],
    ),
  );
}

_getDropdownItem(DoctorOPDsetupController econtroller, String tag) =>
    econtroller.elist.where((p0) => p0.tp == tag && p0.status == '1').map((e) {
      return DropdownMenuItem<String>(
        value: e.id,
        child: Text(e.name!),
      );
    }).toList();
