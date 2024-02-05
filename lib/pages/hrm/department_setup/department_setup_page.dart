import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/functions.dart';
import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_textbox.dart';
import 'package:web_2/pages/hrm/department_setup/controller/department_setup_controller.dart';

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
    return Scaffold(
      body: Obx(() {
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
    _customContainer(econtroller, "Department Category Master", [
      _categoryEntryPart(econtroller),
      _height(),
      _categoryTablePart(econtroller),
    ]);

_departmentPart(DepartmentSetupController econtroller) =>
    _customContainer(econtroller, "Department Master", [
      _departmentEntryPart(econtroller),
      _height(),
      _departmentTableView(econtroller),
    ]);

_sectionPart(DepartmentSetupController econtroller) => _customContainer(
    econtroller,
    "Section/Unit Masetr",
    [
      _sectionEntryPart(econtroller),
      _height(),
      _sectionTableViewPart(econtroller),
    ],
    400);

_customContainer(DepartmentSetupController econtroller, String headerName,
        List<Widget> children, [double height = 350]) =>
    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCaptionForContainer(headerName),
          Container(
              decoration: customBoxDecoration.copyWith(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                color: kWebBackgroundDeepColor,
              ),
              height: height,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: children,
                  )))
        ]);

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

_categoryEntryPart(DepartmentSetupController econtroller) => Container(
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
          const SizedBox(
            width: 8,
          ),
          _roundedButton(() {
            // print("object");
          }, Icons.save_as_sharp),
          const SizedBox(
            width: 8,
          ),
          _roundedButton(() {
            econtroller.txt_category.text = '';
          }, Icons.undo_sharp)
        ],
      ),
    );

_categoryTablePart(DepartmentSetupController econtroller) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        child: Container(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: customBoxDecoration.copyWith(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          element.name!,
                          style: customTextStyle.copyWith(
                              fontSize: 13, fontWeight: FontWeight.w100),
                        ),
                        Row(
                          children: [
                            Text(element.status == "1" ? "Active" : "Inactive",
                                style: customTextStyle.copyWith(
                                    fontSize: 13, fontWeight: FontWeight.w100)),
                            const SizedBox(
                              width: 12,
                            ),
                            _roundedButton(() {}, Icons.edit, 8)
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
    );

_height() => const SizedBox(
      height: 8,
    );

// ignore: non_constant_identifier_names
_roundedButton(void Function() Function, IconData icon,
    [double iconSize = 18]) {
  bool b = true;
  return InkWell(
    onTap: () {
      if (b) {
        b = false;
        Function();
        Future.delayed(const Duration(seconds: 2), () {
          b = true;
        });
      }
    },
    child: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: kWebBackgroundDeepColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 1,
            ),
          ]),
      child: Icon(
        icon,
        size: iconSize,
        color: kWebHeaderColor,
      ),
    ),
  );
}

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
          const SizedBox(
            width: 8,
          ),
          _roundedButton(() {
            // print("object");
          }, Icons.save_as_sharp),
          const SizedBox(
            width: 8,
          ),
          _roundedButton(() {
            econtroller.txt_department.text = '';
            econtroller.cmb_catID.value = '';
          }, Icons.undo_sharp)
        ],
      ),
    );

_departmentTableView(DepartmentSetupController econtroller) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: SingleChildScrollView(
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(130),
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
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text("Category"),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text("Department Name"),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text("Status"),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: Center(child: Text("Action")),
                ),
              ),
            ],
          ),
          // Your existing TableRow code
          // ...
          // Now, wrap the entire TableRow with Flexible to make it flexible
          for (var element in econtroller.department_list)
            TableRow(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              children: [
                TableCell(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(element.catname!),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(element.name!),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(element.status == '1' ? "Active" : "Inactive"),
                  ),
                ),
                const TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    child: Center(
                        child: Icon(
                      Icons.edit,
                      size: 12,
                    )),
                  ),
                ),
              ],
            ),
        ],
        border: CustomTableBorder(),
      ),
    ));

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
                      },
                      width: 100))),
              const SizedBox(
                width: 8,
              ),
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
                    controller: TextEditingController(),
                    onChange: (value) {}),
              ),
              const SizedBox(
                width: 8,
              ),
              _roundedButton(() {
                // print("object");
              }, Icons.save_as_sharp),
              const SizedBox(
                width: 8,
              ),
              _roundedButton(() {
                // print("object");
              }, Icons.undo_sharp)
            ],
          ),
        ],
      ),
    );

_sectionTableViewPart(DepartmentSetupController econtroller) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Table(
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
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text("Category"),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text("Department Name"),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text("Section/Unit Name"),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text("Status"),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: Center(child: Text("Action")),
                ),
              ),
            ],
          ),
          for (var element in econtroller.section_list)
            TableRow(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              children: [
                TableCell(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(element.catname!),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(element.depName!),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(element.name!),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(element.status == '1' ? "Active" : "Inactive"),
                  ),
                ),
                const TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    child: Center(
                        child: Icon(
                      Icons.edit,
                      size: 12,
                    )),
                  ),
                ),
              ],
            ),
        ],
        border: CustomTableBorder(),
      ),
    );
