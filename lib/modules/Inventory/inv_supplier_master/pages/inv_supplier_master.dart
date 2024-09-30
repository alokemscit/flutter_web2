import '../../../../core/config/const.dart';
import '../controller/inv_supplier_controller.dart';

class SupplierMaster extends StatelessWidget {
  const SupplierMaster({super.key});
  void disposeController() {
    try {
      Get.delete<SupplierMasterController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final SupplierMasterController controller =
        Get.put(SupplierMasterController());
    controller.context = context;
    return Obx(() =>
        CommonBody3(controller, [_tablePartr(controller)], 'Supplier Master'));
  }
}

Widget _tablePartr(SupplierMasterController controller) => Expanded(
      child: CustomGroupBox(
          padingvertical: 0,
          groupHeaderText: '',
          child: Column(
            children: [
              _addNewSupplier(controller),
              12.heightBox,
              _supplierEntryPanel(controller),
              _supplierList(controller),
            ],
          )),
    );

_supplierList(SupplierMasterController controller) => Expanded(
      child: CustomGroupBox(
          padingvertical: 0,
          groupHeaderText: 'Supplier List',
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      child: CustomSearchBox(
                          caption: 'Search',
                          width: 450,
                          controller: controller.txt_search,
                          onChange: (v) {
                            controller.serach();
                          })),
                  controller.list_supp_temp.isEmpty
                      ? const SizedBox()
                      : Row(
                          children: [
                            12.widthBox,
                            InkWell(
                              onTap: () {
                                controller.print_supplier();
                              },
                              child: const Icon(
                                Icons.print_sharp,
                                color: appColorBlue,
                                size: 18,
                              ),
                            )
                          ],
                        )
                ],
              ),
              8.heightBox,
              Expanded(
                  child: CustomTableGenerator(colWidtList: const [
                25,
                80,
                90,
                35,
                25,
                15
              ], childrenHeader: [
                CustomTableColumnHeaderBlack('Code'),
                CustomTableColumnHeaderBlack('Name'),
                CustomTableColumnHeaderBlack('Address'),
                CustomTableColumnHeaderBlack('Contact No'),
                CustomTableColumnHeaderBlack('Status'),
                CustomTableColumnHeaderBlack('*', Alignment.center),
              ], childrenTableRowList: [
                ...controller.list_supp_temp.map((f) => TableRow(
                        decoration: BoxDecoration(
                            color: controller.editedSupplier.value.id == f.id
                                ? appColorPista.withOpacity(0.3)
                                : Colors.white),
                        children: [
                          CustomTableCellx(text: f.code ?? ''),
                          CustomTableCellx(text: f.name ?? ''),
                          CustomTableCellx(text: (f.address ?? '').trim()),
                          CustomTableCellx(text: f.mob ?? ''),
                          CustomTableCellx(
                              text:
                                  (f.status ?? 0) == 1 ? 'Active' : 'Inactive'),
                          CustomTableEditCell(() {
                            controller.setEdit(f);
                          }, Icons.edit, 14)
                        ])),
              ]))
            ],
          )),
    );

_supplierEntryPanel(SupplierMasterController controller) =>
    controller.isNew.value
        ? Stack(
            children: [
              CustomGroupBox(
                  groupHeaderText: 'Supplier Info',
                  child: Column(
                    children: [
                      8.heightBox,
                      Row(
                        children: [
                          CustomTextBox(
                              caption: 'Code',
                              width: 100,
                              isDisable: true,
                              isReadonly: true,
                              maxlength: 15,
                              controller: controller.txt_code),
                          10.widthBox,
                          Flexible(
                              child: CustomTextBox(
                                  caption: 'Name',
                                  width: 400,
                                  maxlength: 150,
                                  controller: controller.txt_name))
                        ],
                      ),
                      12.heightBox,
                      Row(
                        children: [
                          Flexible(
                              child: CustomTextBox(
                                  caption: 'Address',
                                  width: 400 + 10 + 100,
                                  height: 75,
                                  maxLine: 5,
                                  maxlength: 250,
                                  textInputType: TextInputType.multiline,
                                  controller: controller.txt_address)),
                        ],
                      ),
                      12.heightBox,
                      Row(
                        children: [
                          Flexible(
                              child: CustomTextBox(
                                  caption: 'Contact No',
                                  width: 160,
                                  maxlength: 25,
                                  controller: controller.txt_contactno)),
                          12.widthBox,
                          CustomDropDown2(
                              width: 100,
                              id: controller.cmb_status.value,
                              list: controller.statusList,
                              onTap: (v) {
                                controller.cmb_status.value = v!;
                              }),
                          12.widthBox,
                          controller.editedSupplier.value.id != null
                              ? const SizedBox()
                              : SizedBox(
                                  width: 136,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                          value: controller
                                              .iscreateFinanceLedger.value,
                                          onChanged: (v) {
                                            controller.iscreateFinanceLedger
                                                .value = v!;
                                          }),
                                      4.widthBox,
                                      Flexible(
                                          child: Text(
                                        'Is Create finance  Sub Ledger?',
                                        style: customTextStyle.copyWith(
                                            fontSize: 10, color: Colors.black),
                                      ))
                                    ],
                                  ),
                                ),
                          22.widthBox,
                          CustomSaveUpdateButtonWithUndo(
                              controller.editedSupplier.value.id != null, () {
                            controller.save_update_supplier();
                          }, () {
                            controller.undo();
                          })
                        ],
                      ),
                      12.heightBox,
                    ],
                  )),
              Positioned(
                  right: 8,
                  top: 10,
                  child: CustomUndoButtonRounded(
                      bgColor: Colors.transparent,
                      onTap: () {
                        controller.hideEntry();
                      }))
            ],
          )
        : const SizedBox();

_addNewSupplier(SupplierMasterController controller) => controller.isNew.value
    ? const SizedBox()
    : InkWell(
        onTap: () {
          controller.setAddNew();
        },
        child: Container(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              const Icon(
                Icons.add,
                size: 24,
                color: appColorBlue,
              ),
              4.widthBox,
              Text(
                "Add new Supplier",
                style: customTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: appColorMint),
              )
            ],
          ),
        ),
      );
