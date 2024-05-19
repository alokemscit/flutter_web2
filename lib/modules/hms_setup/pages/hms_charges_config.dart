 
import 'package:flutter/material.dart';
 
import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/custom_accordian/accordian_header.dart';
import 'package:web_2/component/widget/custom_search_box.dart';
import 'package:web_2/component/widget/custom_widget_list.dart';

import 'package:web_2/modules/hms_setup/controller/hms_charges_congig_controller.dart';

class HmsChargesConfig extends StatelessWidget {
  const HmsChargesConfig({super.key});
  void disposeController() {
    try {
      Get.delete<HmsChargesConfigController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    HmsChargesConfigController controller =
        Get.put(HmsChargesConfigController());
    controller.context = context;
    return Scaffold(
        body: Obx(
      () => CustomCommonBody(
          controller.isLoading.value,
          controller.isError.value,
          controller.errorMessage.value,
          _mobile(controller),
          _desktop(controller),
          _desktop(controller)),
    ));
  }
}

_tablet(HmsChargesConfigController controller) =>
    const Padding(padding: EdgeInsets.all(8));
_desktop(HmsChargesConfigController controller) => Obx(() => Padding(
      padding: const EdgeInsets.all(8),
      child: CustomAccordionContainer(
        height: 0,
        headerName: "Charges Config",
        children: [
          height(),
          Row(
            children: [
              Expanded(
                  child: CustomSearchBox(
                      caption: "Search....",
                      controller: controller.text_search,
                      onChange: (v) {
                        controller.search();
                      })),
            ],
          ),
          height(),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Table(
                          children: [
                            TableRow(
                              children: [
                              Center(
                                child: Text(
                                  "HR Department",
                                  style: customTextStyle,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "HMS Department",
                                  style: customTextStyle,
                                ),
                              ),
                              Center(
                                  child: Text(
                                "Section",
                                style: customTextStyle,
                              ))
                            ]),
                            // Generate TableRow widgets using map method
                            ...controller.section_list_temp
                                .asMap()
                                .entries
                                .map((entry) {
                              //int i = entry.key;
                              var section = entry.value;
                              return TableRow(
                                  decoration: BoxDecoration(
                                    color: controller.selectedSectionID.value ==
                                            section.id
                                        ? Colors.lightGreen.withOpacity(0.02)
                                        : kBgColorG,
                                  ),
                                  children: [


TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: GestureDetector(
                                            onTap: () {
                                              controller.selectedSectionID
                                                  .value = section.id!;
                                            },
                                            child: SizedBox(
                                                height: 25,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  child: Text(
                                                    section.hrDeptName!
                                                        .toString(),
                                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                )))),


                                    TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: GestureDetector(
                                            onTap: () {
                                              controller.selectedSectionID
                                                  .value = section.id!;
                                            },
                                            child: SizedBox(
                                                height: 25,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  child: Text(
                                                    section.hmsDeptName!
                                                        .toString(),
                                                  ),
                                                )))),
                                    TableCell(
                                        child: GestureDetector(
                                            onTap: () {
                                              controller.selectedSectionID
                                                  .value = section.id!;
                                            },
                                            child: SizedBox(
                                                height: 25,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  child: Text(
                                                    section.name!.toString(),
                                                  ),
                                                ))))
                                  ]);
                            }).toList()
                          ],
                          border: CustomTableBorder(),
                        ),
                      ),
                      Expanded(
                          flex: 7,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  Wrap(
                                    children: controller.service_head_List
                                        .map((element) {
                                      return SizedBox(
                                          width: 150,
                                          child: Table(
                                            children: [
                                              TableRow(children: [
                                                TableCell(
                                                    child: Center(
                                                        child: Text(
                                                  element.name!,
                                                  style: customTextStyle,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )))
                                              ]),
                                              // Generate TableRow widgets using map method
                                              ...controller.section_list_temp
                                                  .asMap()
                                                  .entries
                                                  .map((entry) {
                                                // int i = entry.key;
                                                var section = entry.value;
                                                return TableRow(
                                                    decoration: BoxDecoration(
                                                      color: controller
                                                                  .selectedSectionID
                                                                  .value ==
                                                              section.id
                                                          ? Colors.lightGreen
                                                              .withOpacity(0.02)
                                                          : Colors.white,
                                                    ),
                                                    children: [
                                                      TableCell(
                                                          child: SizedBox(
                                                              height: 25,
                                                              child:
                                                                  CustomCheckbox(
                                                                    text: element.name!,
                                                                onChanged:
                                                                    (value) {
                                                                  controller.updateCheckBox(
                                                                      section
                                                                          .id!,
                                                                      element
                                                                          .id!);
                                                                },
                                                                value: controller
                                                                        .config_list_all
                                                                        .where((p0) =>
                                                                            p0.secId == section.id &&
                                                                            p0.chargeId ==
                                                                                element.id)
                                                                        .isEmpty
                                                                    ? false
                                                                    : controller.config_list_all.where((p0) => p0.secId == section.id && p0.chargeId == element.id).first.issec == "0"
                                                                        ? false
                                                                        : true,
                                                                activeColor:
                                                                    kWebHeaderColor
                                                                        .withOpacity(
                                                                            0.3),
                                                                borderColor: Colors
                                                                    .transparent,
                                                              )))
                                                    ]);
                                              }).toList()
                                            ],
                                            border: CustomTableBorder(),
                                          ));
                                    }).toList(),
                                  )
                                ],
                              )))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));

_mobile(HmsChargesConfigController) => Padding(padding: EdgeInsets.all(8));

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final Function(bool?) onChanged;
  final Color activeColor;
  final Color borderColor;
  final double borderWidth;
  final String text;

  const CustomCheckbox({
    required this.value,
    required this.onChanged,
    required this.activeColor,
    required this.borderColor,
    this.borderWidth = 1.0,  this.text='',
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
          widget.onChanged(_isChecked);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border:
              Border.all(color: widget.borderColor, width: widget.borderWidth),
          color: _isChecked ? widget.activeColor : Colors.transparent,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                _isChecked
                    ? Icons.check
                    : Icons.check_box_outline_blank_outlined,
                size: 16.0,
                color: _isChecked ? Colors.black87 : Colors.grey,
              ),
            ),
            Expanded(child: Text(widget.text,style: customTextStyle.copyWith(fontSize: 8.5,fontWeight: FontWeight.w400,color: _isChecked?Colors.indigo:Colors.black),)),
          ],
        ),
      ),
    );
  }
}
