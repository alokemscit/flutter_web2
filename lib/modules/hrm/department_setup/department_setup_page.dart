import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';
 

import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_textbox.dart';
import 'package:web_2/component/widget/custom_widget_list.dart';
import 'package:web_2/modules/hrm/department_setup/controller/department_setup_controller.dart';

class DepartmentSetup extends StatelessWidget {
  const DepartmentSetup({super.key});
  void disposeController() {
    try {
      Get.delete<DepartmentSetupController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    DepartmentSetupController econtroller =
        Get.put(DepartmentSetupController());
    econtroller.context = context;
    return Scaffold(
      body: Obx(() {
        print("object 33333333333");
        if (econtroller.isLoading.value) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (econtroller.isError.value) {
          return Text(
            econtroller.errorMessage.value.toString(),
            style: const TextStyle(color: Colors.red),
          );
        }
        return Responsive(
          mobile: _tablet(econtroller),
          tablet: _tablet(econtroller),
          desktop: _desktop(econtroller),
        );
      }),
    );
  }
}

_categoryPart(DepartmentSetupController econtroller) =>
    customFixedHeightContainer("Department Category Master", [
      _categoryEntryPart(econtroller),
      height(),
      _categoryTablePart(econtroller),
    ]);

_departmentPart(DepartmentSetupController econtroller) =>
    customFixedHeightContainer("Department Master", [
      _departmentEntryPart(econtroller),
      height(),
      _departmentTableView(econtroller),
    ]);

_sectionPart(DepartmentSetupController econtroller) =>
    customFixedHeightContainer(
        "Section/Unit Masetr",
        [
          _sectionEntryPart(econtroller),
          height(),
          _sectionTableViewPart(econtroller),
        ],
        400);


_tablet(DepartmentSetupController econtroller) {
  return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(children: [
            _categoryPart(econtroller),
            const SizedBox(
              height: 8,
            ),
            _departmentPart(econtroller),
            const SizedBox(
              height: 8,
            ),
            _sectionPart(econtroller),
          ])));
}

_desktop(DepartmentSetupController econtroller) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: _categoryPart(econtroller),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 5,
                child: _departmentPart(econtroller),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: _sectionPart(econtroller),
              ),
              const Expanded(
                flex: 3,
                child: SizedBox(),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

_categoryEntryPart(DepartmentSetupController econtroller) {
  //print("Called");
   
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: customBoxDecoration,
    child: Row(
      children: [
        Expanded(
          child: CustomTextBox(
              maxlength: 100,
              caption: "Category Name",
              controller: econtroller.txt_category,
              onChange: (value) {}),
        ),
        width(),
        CustomDropDown(
            id: econtroller.cmb_category_statusID.value,
            labeltext: "Status",
            list: econtroller.statusList
                .map((element) => DropdownMenuItem<String>(
                    value: element.id, child: Text(element.name!)))
                .toList(),
            onTap: (v) {
              econtroller.cmb_category_statusID.value = v.toString();
            },
            width: 90),
        width(),
        roundedButton(() async {
         // print("object");
        
           await econtroller.saveUpdateCategory();
        },
            econtroller.editCategoryID.value == ''
                ? Icons.save_as_sharp
                : Icons.edit),
        width(),
        roundedButton(() {
          econtroller.editCategoryID.value = '';
          econtroller.txt_category.text = '';
          econtroller.cmb_category_statusID.value = "1";
        }, Icons.undo_sharp)
      ],
    ),
  );
}

_categoryTablePart(DepartmentSetupController econtroller) => Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: econtroller.isCategoryLoading.value
              ? const Center(child: CupertinoActivityIndicator())
              : Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: customBoxDecoration.copyWith(
                            borderRadius: BorderRadius.circular(0),
                            color: kBgDarkColor.withOpacity(0.5)),
                        child: Row(
                          children: [
                            Text(
                              "Category Name",
                              style: customTextStyle,
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: econtroller.category_list.map((element) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: customBoxDecoration.copyWith(
                                borderRadius: BorderRadius.circular(0),
                                color: econtroller.editCategoryID.value ==
                                        element.id
                                    ? Colors.amber.withOpacity(0.3)
                                    : Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  element.name!,
                                  style: customTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w100),
                                ),
                                Row(
                                  children: [
                                    Text(
                                        element.status == "1"
                                            ? "Active"
                                            : "Inactive",
                                        style: customTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w100)),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    //_roundedButton(() {}, Icons.edit, 8)
                                    InkWell(
                                      onTap: () {
                                        econtroller.txt_category.text =
                                            element.name!;
                                        econtroller.editCategoryID.value =
                                            element.id.toString();
                                        econtroller.cmb_category_statusID
                                            .value = element.status.toString();
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: kWebHeaderColor,
                                        size: 12,
                                      ),
                                    ),
                                    width(12)
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );

_departmentEntryPart(DepartmentSetupController econtroller) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: customBoxDecoration,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Obx(() => CustomDropDown(
                  labeltext: "Category",
                  id: econtroller.cmb_catID.value,
                  list: econtroller.category_list
                      .map((element) => DropdownMenuItem<String>(
                          value: element.id.toString(),
                          child: Text(element.name!)))
                      .toList(),
                  onTap: (v) {
                    econtroller.cmb_catID.value = v.toString();
                  },
                  width: 100))),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 3,
            child: CustomTextBox(
                maxlength: 100,
                caption: "Department Name",
                controller: econtroller.txt_department,
                onChange: (value) {}),
          ),
          width(),
          CustomDropDown(
              id: econtroller.cmb_department_statusID.value,
              labeltext: "Status",
              list: econtroller.statusList
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                econtroller.cmb_department_statusID.value = v.toString();
              },
              width: 90),
          width(),
          roundedButton(() {
            econtroller.saveUpdateDeprtment();
          },
              econtroller.editDepartmentID.value == ''
                  ? Icons.save_as_sharp
                  : Icons.edit),
          const SizedBox(
            width: 8,
          ),
          roundedButton(() {
            econtroller.txt_department.text = '';
            econtroller.editDepartmentID.value = '';
            econtroller.cmb_catID.value = '';
            econtroller.cmb_department_statusID.value = '1';
          }, Icons.undo_sharp)
        ],
      ),
    );

_departmentTableView(DepartmentSetupController econtroller) => Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            children: [
              econtroller.isDepartmentLoading.value
                  ? const Center(child: CupertinoActivityIndicator())
                  : Table(
                      columnWidths: const {
                        0: FlexColumnWidth(130),
                        1: FlexColumnWidth(100),
                        2: FlexColumnWidth(80),
                        3: FlexColumnWidth(30),
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
                                child: Text("Category",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: Text("Department",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: Text("Status",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 2),
                                child: Center(child: Text("Action",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),)),
                              ),
                            ),
                          ],
                        ),
                        // Your existing TableRow code
                        // ...
                        // Now, wrap the entire TableRow with Flexible to make it flexible
                        for (var element in econtroller.department_list_all)
                          TableRow(
                            decoration: BoxDecoration(
                              color: econtroller.editDepartmentID.value !=
                                      element.id
                                  ? Colors.white
                                  : Colors.amber.withOpacity(0.3),
                            ),
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  child: Text(element.catname!,style: const TextStyle(fontSize: 12),),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  child: Text(element.name!,style: const TextStyle(fontSize: 12),),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  child: Text(element.status == '1'
                                      ? "Active"
                                      : "Inactive",style: const TextStyle(fontSize: 12),),
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
                                      econtroller.editDepartmentID.value =
                                          element.id!;
                                      econtroller.txt_department.text =
                                          element.name!;
                                      econtroller.cmb_catID.value =
                                          element.catId!;
                                      econtroller.cmb_department_statusID
                                          .value = element.status!;
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
                    )
            ],
          )),
    );

_sectionEntryPart(DepartmentSetupController econtroller) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: customBoxDecoration,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Obx(() => CustomDropDown(
                      labeltext: "Category",
                      id: econtroller.cmb_catID2.value,
                      list: econtroller.category_list
                          .map((element) => DropdownMenuItem<String>(
                              value: element.id.toString(),
                              child: Text(element.name!)))
                          .toList(),
                      onTap: (v) {
                        econtroller.cmb_catID2.value = v.toString();
                        econtroller.cmb_DeptID.value = '';
                        econtroller.department_list.clear();
                        econtroller.setDepartmet(v.toString());
                      },
                      width: 100))),
              width(),
              Expanded(
                flex: 3,
                child: Obx(() => CustomDropDown(
                    labeltext: "Department",
                    id: econtroller.cmb_DeptID.value,
                    list: econtroller.department_list
                        .map((element) => DropdownMenuItem<String>(
                            value: element.id.toString(),
                            child: Text(element.name!)))
                        .toList(),
                    onTap: (v) {
                      econtroller.cmb_DeptID.value = v.toString();
                    },
                    width: 100)),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomTextBox(
                    maxlength: 100,
                    caption: "Section/Unit Name",
                    controller: econtroller.txt_section,
                    onChange: (value) {}),
              ),
              width(),
              CustomDropDown(
                  id: econtroller.cmb_section_statusID.value,
                  labeltext: "Status",
                  list: econtroller.statusList
                      .map((element) => DropdownMenuItem<String>(
                          value: element.id, child: Text(element.name!)))
                      .toList(),
                  onTap: (v) {
                    econtroller.cmb_section_statusID.value = v.toString();
                  },
                  width: 90),
              width(),
              roundedButton(() {
                econtroller.saveUpdateSection();
              },
                  econtroller.editSectionID.value == ''
                      ? Icons.save_as_sharp
                      : Icons.edit),
              width(),
              roundedButton(() {
                econtroller.editSectionID.value = '';
                econtroller.txt_section.text = '';
                econtroller.cmb_catID2.value = '';
                econtroller.cmb_DeptID.value = '';
                econtroller.department_list.clear();
                econtroller.cmb_section_statusID.value = '1';
              }, Icons.undo_sharp)
            ],
          ),
        ],
      ),
    );

_sectionTableViewPart(DepartmentSetupController econtroller) => Expanded(
  child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: 
        
        
        SingleChildScrollView(
          child: econtroller.isSectionLoading.value
              ? const Center(child: CupertinoActivityIndicator())
              : Table(
                columnWidths: const {
                  0: FixedColumnWidth(110),
                  1: FlexColumnWidth(110),
                  2: FlexColumnWidth(130),
                  3: FlexColumnWidth(80),
                  4: FlexColumnWidth(30),
                },
                children: [
                  const TableRow(
                    decoration: BoxDecoration(
                      color: kBgDarkColor,
                    ),
                    children: [
                      TableCell(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: Text("Category",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: Text("Department",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: Text("Section/Unit",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: Text("Status",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          child: Center(child: Text("Action",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),)),
                        ),
                      ),
                    ],
                  ),
                  for (var element in econtroller.section_list)
                    TableRow(
                      decoration: BoxDecoration(
                        color: econtroller.editSectionID.value == element.id
                            ? Colors.amber.withOpacity(0.3)
                            : Colors.white,
                      ),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Text(element.catname!,style: const TextStyle(fontSize: 12),),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Text(element.depName!,style: const TextStyle(fontSize: 12),),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Text(element.name!,style: const TextStyle(fontSize: 12),),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Text(
                                element.status == '1' ? "Active" : "Inactive",style: const TextStyle(fontSize: 12),),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 2),
                            child: Center(
                                child: InkWell(
                              onTap: () {
                                econtroller.txt_section.text = element.name!;
                                econtroller.cmb_catID2.value = element.catId!;
                                econtroller.cmb_section_statusID.value =
                                    element.status!;
                                econtroller.editSectionID.value = element.id!;
                                econtroller.department_list.clear();
                                econtroller.setDepartmet(element.catId!);
                                econtroller.cmb_DeptID.value = element.depId!;
                                //econtroller.cmb_DeptID.value = element.depId!;
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
        ),
      ),
);
