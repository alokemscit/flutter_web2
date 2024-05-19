

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_textbox.dart';
import 'package:web_2/component/widget/custom_widget_list.dart';
import 'package:web_2/modules/hrm/department_setup/model/model_status_master.dart';
import 'package:web_2/modules/hrm/setup_attributes/model/model_hr_common_master.dart';

commonMasterPart(
        bool isLoading,
        String panelCaption,
        RxList<ModelStatusMaster> statusList,
        RxList<ModelCommonMaster> tableList,
        TextEditingController txtController,
        String textLebel,
        RxString statusID,
        RxString editId,
        dynamic Function() save,
        [double panelHeight = 350]) =>
        customFixedHeightContainer(
        panelCaption,
        [
          commonMasterEntryPart(
              statusList, txtController, textLebel, statusID, editId, () {
             save();
          }),
          height(),

          Expanded(
            child: ListView(
              children: [
              commonMasterTableViewPart(isLoading, tableList,txtController, editId,statusID) ,
              ],
            ),
          )

        
        
        
        ],
        panelHeight);








commonMasterEntryPart(
        List<ModelStatusMaster> statusList,
        TextEditingController txtController,
        String textLebel,
        RxString statusID,
        RxString editId,
        Function() save) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: customBoxDecoration,
      child: Row(
        children: [
          Expanded(
            child: CustomTextBox(
                maxlength: 100,
                caption: textLebel,
                controller: txtController, //econtroller.txt_category,
                onChange: (value) {}),
          ),
          width(),
          CustomDropDown(
              id: statusID.value, //econtroller.cmb_category_statusID.value,
              labeltext: "Status",
              list: statusList
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                statusID.value = v.toString();
              },
              width: 90),
          width(),
          roundedButton(() {
            save();
          }, editId.value == '' ? Icons.save_as_sharp : Icons.edit),
          width(),
          roundedButton(() {
            txtController.text = '';
            editId.value = '';
            statusID.value = '1';
            //undo();
          }, Icons.undo_sharp)
        ],
      ),
    );

commonMasterTableViewPart(
  bool isLoading,
  List<ModelCommonMaster> list,
  TextEditingController txt_controller,
  RxString editId,
  RxString statusId,
) =>
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : SingleChildScrollView(
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(5),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(2),
                  },
                  children: [
                    const TableRow(
                      decoration: BoxDecoration(
                        color: kBgDarkColor,
                      ),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Text("Name"),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Text("Status"),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2, vertical: 2),
                            child: Center(child: Text("Action")),
                          ),
                        ),
                      ],
                    ),
                    for (var element in list)
                      TableRow(
                        decoration: BoxDecoration(
                          color: editId.value != element.id
                              ? Colors.white
                              : Colors.amber.withOpacity(0.3),
                        ),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              child: Text(element.name!),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              child: Text(element.status == '1'
                                  ? "Active"
                                  : "Inactive"),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              child: Center(
                                  child: InkWell(
                                onTap: () {
                                  // fun(element);
                                  editId.value = element.id!;
                                  statusId.value = element.status!;
                                  txt_controller.text = element.name!;
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: kWebHeaderColor,
                                  size: 12,
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                  ],
                  border: CustomTableBorder(),
                ),
              ));
