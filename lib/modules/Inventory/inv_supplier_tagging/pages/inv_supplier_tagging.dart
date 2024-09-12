import '../../../../core/config/const.dart';
import '../controller/inv_supplier_tagging_controller.dart';

class InvSupplierTagging extends StatelessWidget {
  const InvSupplierTagging({super.key});
  void disposeController() {
    try {
      Get.delete<InvSupplierTaggingController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final InvSupplierTaggingController controller =
        Get.put(InvSupplierTaggingController());
    controller.context = context;
    return Obx(() => CommonBody3(
          controller,
          [
            Expanded(
              child: context.width > 1050
                  ? _buildRowLayout(controller)
                  : _buildColumnLayout(controller),
            )
          ],
          'Supplier Tagging::',
        ));
  }
}

Widget _buildRowLayout(InvSupplierTaggingController controller) {
  return Row(
    children: [
      Expanded(flex: 4, child: _companyList(controller)),
      8.widthBox,
      Expanded(flex: 6, child: _supplierList(controller)),
    ],
  );
}

Widget _buildColumnLayout(InvSupplierTaggingController controller) {
  return Column(
    children: [
      Expanded(flex: 4, child: _companyList(controller)),
      8.heightBox,
      Expanded(flex: 5, child: _supplierList(controller)),
    ],
  );
}

Widget _companyList(InvSupplierTaggingController controller) => CustomGroupBox(
    padingvertical: 0,
    groupHeaderText: 'Company',
    child: Column(
      children: [
        8.heightBox,
        Row(
          children: [
            Expanded(
              child: CustomGroupBox(
                  groupHeaderText: '',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomDropDown2(
                        id: controller.cmb_store_type.value,
                        list: controller.list_storeTypeList,
                        onTap: (v) {
                          controller.setStoreType(v!);
                        },
                        width: 180,
                      ),
                      8.widthBox,
                      Flexible(
                          child: CustomSearchBox(
                              width: 300,
                              caption: 'Search Company',
                              controller: controller.txt_search_company,
                              onChange: (v) {
                                controller.searchCompany();
                              }))
                    ],
                  )),
            ),
          ],
        ),
        4.heightBox,
        Expanded(
            child: CustomGroupBox(
                groupHeaderText: 'Company list',
                child: CustomTableGenerator(colWidtList: const [
                  20,
                  80,
                  60,
                  30,
                  30
                ], childrenHeader: [
                  CustomTableColumnHeaderBlack('ID'),
                  CustomTableColumnHeaderBlack('Name'),
                  CustomTableColumnHeaderBlack('Address'),
                  CustomTableColumnHeaderBlack('Contact No'),
                  CustomTableColumnHeaderBlack('*', Alignment.center),
                ], childrenTableRowList: [
                  ...controller.list_company_temp.map((f) => TableRow(
                          decoration: BoxDecoration(
                              color: controller.selectedCompany.value.id == f.id
                                  ? appColorPista.withOpacity(0.3)
                                  : Colors.white),
                          children: [
                            CustomTableCellx(text: f.id!),
                            CustomTableCellx(text: f.name!),
                            CustomTableCellx(text: f.address!),
                            CustomTableCellx(text: f.mob!),
                            CustomTableEditCell(() {
                              controller.setCompanyForSettiongs(f);
                            }, Icons.settings, 14)
                          ]))
                ]))),
        8.heightBox,
      ],
    ));

Widget _supplierList(InvSupplierTaggingController controller) => controller
            .selectedCompany.value.id ==
        null
    ? const SizedBox()
    : Stack(
        children: [
          CustomGroupBox(
              padingvertical: 0,
              groupHeaderText: 'Supplier',
              child: Column(
                children: [
                  8.heightBox,
                  !controller.isAdd.value
                      ? _addButton(controller)
                      : Row(
                          children: [
                            Expanded(
                              child: CustomGroupBox(
                                bgColor: Colors.white,
                                borderWidth: 2,
                                padingvertical: 0,
                                groupHeaderText: '',
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                            child: CustomSearchBox(
                                                width: 300,
                                                caption: 'Search Supplier',
                                                controller: controller
                                                    .txt_search_supplier,
                                                onChange: (v) {
                                                  controller.searchSuppEntry();
                                                })),
                                        12.widthBox,
                                        CustomUndoButtonRounded(
                                          onTap: () {
                                            controller.isAdd.value = false;
                                          },
                                          bgColor: Colors.transparent,
                                        )
                                      ],
                                    ),
                                    6.heightBox,
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: appColorGrayDark,
                                              width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      height: 250,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: CustomTableGenerator(
                                                  colWidtList: const [
                                                30,
                                                100,
                                                // 80,
                                                30,
                                                20
                                              ],
                                                  childrenHeader: [
                                                CustomTableColumnHeaderBlack(
                                                    'Code'),
                                                CustomTableColumnHeaderBlack(
                                                    'Name'),
                                                // CustomTableColumnHeaderBlack(
                                                //     'Address'),
                                                CustomTableColumnHeaderBlack(
                                                    'Contact No'),
                                                CustomTableColumnHeaderBlack(
                                                    '*', Alignment.center),
                                              ],
                                                  childrenTableRowList: [
                                                ...controller.list_supp_temp
                                                    .map((f) =>
                                                        TableRow(children: [
                                                          CustomTableCellx(
                                                              text:
                                                                  f.code ?? ''),
                                                          CustomTableCellx(
                                                              text:
                                                                  f.name ?? ''),
                                                          //CustomTableCellx(text: f.address??''),
                                                          CustomTableCellx(
                                                              text:
                                                                  f.mob ?? ''),
                                                          CustomTableEditCell(
                                                            () {
                                                              controller
                                                                  .addSupp(f);
                                                            },
                                                            Icons.add,
                                                          )
                                                        ]))
                                              ])),
                                        ],
                                      ),
                                    ),
                                    6.heightBox,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                  6.heightBox,
                  Expanded(
                      child: Stack(
                        children: [
                          CustomGroupBox(
                              groupHeaderText: 'Supplier List',
                              child: CustomTableGenerator(colWidtList: const [
                                30,
                                80,
                                70,
                                50,
                                20
                              ], childrenHeader: [
                                CustomTableColumnHeaderBlack('Code'),
                                CustomTableColumnHeaderBlack('Name'),
                                CustomTableColumnHeaderBlack('Address'),
                                CustomTableColumnHeaderBlack('Contact No'),
                                CustomTableColumnHeaderBlack('*', Alignment.center),
                              ], childrenTableRowList: [
                                ...controller.list_supp_tag
                                    .map((f) => TableRow(
                                      decoration: const BoxDecoration(color: Colors.white),
                                      children: [
                                          CustomTableCellx(text: f.code ?? ''),
                                          CustomTableCellx(text: f.name ?? ''),
                                          CustomTableCellx(text: f.address ?? ''),
                                          CustomTableCellx(text: f.mob ?? ''),
                                          CustomTableEditCell(() {
                                            controller.deleteTagSup(f);
                                          }, Icons.delete, 14, Colors.red)
                                        ]))
                              ])),
                        
                         controller.list_supp_tag.isEmpty?const SizedBox():         Positioned(
                        bottom: 8,right: 8,
                        child: CustomButton(Icons.save, 'Save',(){}))
                        ],
                      )),
                  8.heightBox,
                ],
              )),
          Positioned(
              top: 0,
              right: 0,
              child: CustomCloseButtonRounded(onTap: () {
                controller.closeClick();
              }))
        ],
      );
_addButton(InvSupplierTaggingController controller) => InkWell(
      onTap: () {
        controller.isAdd.value = true;
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            const Icon(
              Icons.add,
              color: appColorBlue,
              size: 24,
            ),
            Text(
              'Add Supplier',
              style:
                  customTextStyle.copyWith(fontSize: 10, color: appColorBlue),
            )
          ],
        ),
      ),
    );
