import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/custom_accordian/accordian_header.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
 
import 'package:web_2/component/widget/custom_search_box.dart';
import 'package:web_2/component/widget/custom_textbox.dart';
import 'package:web_2/component/widget/custom_widget_list.dart';
import 'package:web_2/modules/Inventory/pages/warehouse_setup/controller/warehouse_setup_controller.dart';

class WareHouseSetup extends StatelessWidget {
  const WareHouseSetup({super.key});
  void disposeController() {
    try {
      Get.delete<WareHouseSetupController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    WareHouseSetupController controller =
        Get.put(WareHouseSetupController(context: context));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => CustomCommonBody(
          controller.isLoading.value,
          controller.isError.value,
          controller.errorMessage.value,
          _mobile(controller),
          _desktop(controller),
          _desktop(controller))),
    );
  }
}

_mobile(WareHouseSetupController controller) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: CustomAccordionContainer(
          isExpansion: false,
          height: 0,
          headerName: 'Warehouse Master',
          children: [
            _warehouseEnryPart(controller),
            _warehouseTablePart(controller),
          ]),
    );

_desktop(WareHouseSetupController controller) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: CustomAccordionContainer(
          isExpansion: false,
          height: 0,
          headerName: 'Warehouse Master',
          children: [
            _warehouseEnryPart(controller),
            height(12),
            _warehouseTablePart(controller),
          ]),
    );

_warehouseEnryPart(WareHouseSetupController controller) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: customBoxDecoration,
      child: Row(
        children: [
          Row(
            children: [
              Checkbox(
                  value: controller.isCentralStore.value,
                  onChanged: (v) {
                    controller.isCentralStore.value = v!;
                  }),
              width(2),
              Text(
                "Is Central\nSetore",
                style: customTextStyle.copyWith(fontSize: 11.5, height: 1),
              ),
            ],
          ),
          width(),
          !controller.isCentralStore.value
              ? const SizedBox()
              : Expanded(
                  flex: 3,
                  child: CustomDropDown(
                      id: controller.cmb_StoteTypeID.value,
                      labeltext: "Store Type",
                      list: controller.storeTypeList
                          .map((element) => DropdownMenuItem<String>(
                              value: element.id, child: Text(element.name!)))
                          .toList(),
                      onTap: (v) {
                        controller.cmb_StoteTypeID.value = v.toString();
                      },
                      width: 90),
                ),
          width(),
          Expanded(
            flex: 6,
            child: CustomTextBox(
                maxlength: 100,
                caption: "Warehouse Name",
                controller: controller.txt_warehouse_name,
                onChange: (value) {}),
          ),
          width(),
          CustomDropDown(
              id: controller.cmb_SatusID.value,
              labeltext: "Status",
              list: controller.statusList
                  .map((element) => DropdownMenuItem<String>(
                      value: element.id, child: Text(element.name!)))
                  .toList(),
              onTap: (v) {
                controller.cmb_SatusID.value = v.toString();
              },
              width: 90),
          width(),
          roundedButton(() async {
            controller.saveWarehouse();
            //await controller.saveUpdateCategory();
          },
              controller.editWarehouseID.value == ''
                  ? Icons.save_as_sharp
                  : Icons.edit),
          width(),
          roundedButton(() {
            controller.cmb_StoteTypeID.value = '';
            controller.editWarehouseID.value = '';
            controller.isCentralStore.value = false;
            controller.cmb_SatusID.value = "1";
          }, Icons.undo_sharp)
        ],
      ),
    );

_warehouseTablePart(WareHouseSetupController controller) => Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 5,
                  child: CustomSearchBox(
                      //height: 27,
                      borderRadious: 4,
                      caption: "Warehouse search",
                      controller: TextEditingController(),
                      onChange: (v) {})),
              const Expanded(flex: 5, child: SizedBox())
            ],
          ),
          height(4),
          Expanded(
            child: SingleChildScrollView(
                child: Table(
              border: CustomTableBorder(),
              columnWidths: const {
                0: FlexColumnWidth(150),
                1: FlexColumnWidth(60),
                2: FlexColumnWidth(80),
                3: FlexColumnWidth(80),
                4: FlexColumnWidth(40),
              },
              children: [
                // for (var i = 0; i < 100;i++)
                TableRow(
                    decoration: CustomTableHeaderRowDecoration(),
                    children: [
                      CustomTableCell("Warehouse Name"),
                      CustomTableCell("Is Central"),
                      CustomTableCell("Store Type"),
                      CustomTableCell("Status"),
                      Center(
                        child: CustomTableCell("Edit"),
                      )
                    ]),
                for (var i = 0; i < controller.warehouseList_temp.length; i++)
                  TableRow(
                      decoration:  BoxDecoration(color:
                      controller.editWarehouseID.value==controller.warehouseList_temp[i].id?Colors.amber.withOpacity(0.2): Colors.white),
                      children: [
                        CustomTableCell(controller.warehouseList_temp[i].name!),
                        CustomTableCell(
                            controller.warehouseList_temp[i].isCentral == "0"
                                ? "No"
                                : "Yes"),
                        CustomTableCell(
                            controller.warehouseList_temp[i].storeTypeName!),
                        CustomTableCell(
                            controller.warehouseList_temp[i].status == "1"
                                ? "Active"
                                : "Inactive"),
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: InkWell(
                              onTap: () {
                                controller.editWarehouseID.value =
                                    controller.warehouseList_temp[i].id!;
                                controller.isCentralStore.value = controller
                                            .warehouseList_temp[i].isCentral ==
                                        "1"
                                    ? true
                                    : false;
                                controller.cmb_StoteTypeID.value = controller
                                            .warehouseList_temp[i].isCentral ==
                                        "1"
                                    ? controller
                                        .warehouseList_temp[i].storeTypeId!
                                    : '';
                                controller.txt_warehouse_name.text =
                                    controller.warehouseList_temp[i].name!;
                                controller.cmb_SatusID.value =
                                    controller.warehouseList_temp[i].status!;
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.edit,
                                  color: kWebHeaderColor,
                                  size: 12,
                                ),
                              ),
                            ))
                      ])
              ],
            )),
          ),
        ],
      ),
    );
