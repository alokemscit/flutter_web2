import 'package:flutter/cupertino.dart';

import '../../../../component/widget/custom_panel.dart';
import '../../../../core/config/const.dart';

import '../controller/ledger_master_controller.dart';
import '../model/model_ledger_master.dart';

class LedgerMasterPage extends StatelessWidget implements MyInterface {
  const LedgerMasterPage({super.key});
  @override
  void disposeController() {
    mdisposeController<LedgerMasterController>();
  }

  @override
  Widget build(BuildContext context) {
    LedgerMasterController controller = Get.put(LedgerMasterController());
    controller.context = context;
    return Obx(
      () =>
          CommonBodyWithToolBar(controller, [ _tree(controller)], controller.list_tools, (v) {}),

      // CommonBody2(controller, _desktop(controller)),
    );
  }
}

 
Widget _tree(LedgerMasterController controller) => Expanded(
  child: CustomGroupBox(
    pading: const EdgeInsets.only(top: 8,left: 8),
      //groupHeaderText: "Chart of Account",
      bgColor: Colors.white,
      //borderWidth: 0.5,
      textColor: Colors.black,
      child: ListView(
            children: controller.ledger_list
        .where((p0) => p0.pARENTID == '0')
        .map((e) => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _chartAccount(controller, e)))
        .toList(),
          )),
);

Widget _chartAccount(LedgerMasterController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _node(
          0,
          Row(
            children: [
              Text(
                '${e.cODE!} - ${e.nAME!}',
                style: customTextStyle.copyWith(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              10.widthBox,
              Text('(Chart of Acc)', style: _style())
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 27.0),
            child: PoppupMenu(menuList: [
              PopupMenuItem(
                child: const ListTile(
                  title: Text("Add Group"),
                  trailing: Icon(Icons.add_rounded),
                ),
                onTap: () {
                  _groupPopup(controller, e, false);
                },
              ),
              //PopupMenuItem(child: ListTile(title: Text("Edit Group"), leading: Icon(Icons.add),)),
            ], child: const Icon(Icons.construction_sharp)),
          ),
          controller.ledger_list
              .where((p0) => p0.pARENTID == e.iD)
              .map((e) => _groupPart(controller, e))
              .toList()),
    );

Widget _subGroupPart(LedgerMasterController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: _node(
          26,
          Row(
            children: [
              Text('${e.cODE!} - ${e.nAME!}',
                  style: customTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: appFontMuli
                      //color: appColorLogo,
                      )),
              10.widthBox,
              Text('(Sub Group)', style: _style())
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: PoppupMenu(
                menuList: [
                  PopupMenuItem(
                      child: const ListTile(
                        title: Text("Add Ledger Category"),
                        trailing: Icon(Icons.add_rounded),
                      ),
                      onTap: () => _ledgerCategoryPopup(controller, e, false)),
                  PopupMenuItem(
                      child: const ListTile(
                        title: Text("Edit Sub Group"),
                        trailing: Icon(Icons.edit_rounded),
                      ),
                      onTap: () => _sub_GroupPopup(controller, e, true)),
                ],
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.construction_sharp,
                    size: 22,
                    color: appColorBlue,
                  ),
                )),
          ),
          controller.ledger_list
              .where((p0) => p0.pARENTID == e.iD)
              .map(
                (e) => _ledgerCategoryPart(controller, e),
              )
              .toList()),
    );

void _sub_GroupPopup(
    LedgerMasterController controller, ModelLedgerMaster e, bool isEdit) async {
  if (isEdit) {
    controller.txt_subgeroup_code.text = e.cODE!;
    controller.txt_subgroup_Serial.text = e.sL!;
    controller.txt_subgroup_name.text = e.nAME!;
  } else {
    controller.txt_subgeroup_code.text = '';
    controller.txt_subgroup_Serial.text = '';
    controller.txt_subgroup_name.text = '';
  }

  // dialog = CustomAwesomeDialog(context: context);
  bool b = false;
  await CustomDialog(
      controller.context,
      Text(
          "${isEdit ? 'Edit ' : ''}Sub Group Under\\ ${isEdit ? controller.ledger_list.where((p0) => p0.iD == e.pARENTID).first.nAME : e.nAME!}"),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomGroupBox(
          groupHeaderText: 'Sub Group',
          borderWidth: 0.5,
          child: SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: CustomTextBox(
                              isDisable: isEdit ? false : true,
                              isFilled: false,
                              isReadonly: isEdit ? false : true,
                              caption: "Code",
                              maxlength: 15,
                              controller: controller.txt_subgeroup_code,
                              onChange: (v) {})),
                      8.widthBox,
                      Expanded(
                          flex: 3,
                          child: CustomTextBox(
                              caption: "Serial",
                              textInputType: TextInputType.number,
                              maxlength: 5,
                              controller: controller.txt_subgroup_Serial,
                              onChange: (v) {})),
                    ],
                  ),
                  12.heightBox,
                  CustomTextBox(
                      caption: "Sub Group Name",
                      maxlength: 150,
                      width: double.infinity,
                      controller: controller.txt_subgroup_name,
                      onChange: (v) {}),
                  8.heightBox,
                ],
              ),
            ),
          ),
        ),
      ), () {
    if (!b) {
      b = true;
      Future.delayed(const Duration(seconds: 2), () {
        b = false;
      });

      controller.saveSubGroup(isEdit, e);
      //p_cid in int, p_id in int, p_name in varchar2,p_pid in int, p_code in varchar2, p_sl in int, p_isgroup in int
    }
  });
}

Widget _ledgerCategoryPart(
        LedgerMasterController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: _node(
          26,
          Row(
            children: [
              Text('${e.cODE!} - ${e.nAME!}',
                  style: customTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: appFontMuli,
                    // color: kTextColor,
                  )),
              10.widthBox,
              Text('(Ledger Category)', style: _style())
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: PoppupMenu(
                menuList: [
                  PopupMenuItem(
                      child: const ListTile(
                        title: Text("Add Ledger"),
                        trailing: Icon(Icons.add_rounded),
                      ),
                      onTap: () => _ledgerPopup(controller, e, false)),
                  PopupMenuItem(
                      child: const ListTile(
                        title: Text("Edit Ledger Category"),
                        trailing: Icon(Icons.edit_rounded),
                      ),
                      onTap: () => _ledgerCategoryPopup(controller, e, true)),
                ],
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.construction_sharp,
                    size: 22,
                    color: kTextColor,
                  ),
                )),
          ),
          controller.ledger_list
              .where((p0) => p0.pARENTID == e.iD)
              .map(
                (e) => _ledgerPart(controller, e),
              )
              .toList()),
    );

void _ledgerPopup(
    LedgerMasterController controller, ModelLedgerMaster e, bool isEdit) async {
  if (isEdit) {
    controller.txt_ledger_code.text = e.cODE!;
    controller.txt_ledger_Serial.text = e.sL!;
    controller.txt_ledger_name.text = e.nAME!;
    controller.is_cc.value = e.isCC == '1' ? true : false;
    controller.is_sl.value = e.isSL == '1' ? true : false;
  } else {
    controller.txt_ledger_code.text = '';
    controller.txt_ledger_Serial.text = '';
    controller.txt_ledger_name.text = '';
    controller.is_cc.value = false;
    controller.is_sl.value = false;
  }

  bool b = false;
  await CustomDialog(
      controller.context,
      Text(
        "${isEdit ? 'Edit ' : ''} Ledger Under\\ ${isEdit ? controller.ledger_list.where((p0) => p0.iD == e.pARENTID).first.nAME : e.nAME!}",
        style: customTextStyle.copyWith(fontWeight: FontWeight.bold),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 350,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                6.heightBox,
                CustomGroupBox(
                  // padding: const EdgeInsets.all(8),
                  // decoration: customBoxDecoration,
                  groupHeaderText: 'Ledger',
                  borderWidth: 0.5,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: CustomTextBox(
                                  isDisable: isEdit ? false : true,
                                  isFilled: false,
                                  isReadonly: isEdit ? false : true,
                                  caption: "Code",
                                  maxlength: 15,
                                  controller: controller.txt_ledger_code,
                                  onChange: (v) {})),
                          8.widthBox,
                          Expanded(
                              flex: 3,
                              child: CustomTextBox(
                                  caption: "Serial",
                                  textInputType: TextInputType.number,
                                  maxlength: 5,
                                  controller: controller.txt_ledger_Serial,
                                  onChange: (v) {})),
                        ],
                      ),
                      12.heightBox,
                      CustomTextBox(
                          caption: "Ledger Name",
                          maxlength: 150,
                          width: double.infinity,
                          controller: controller.txt_ledger_name,
                          onChange: (v) {}),
                    ],
                  ),
                ),
                8.heightBox,
                CustomGroupBox(
                  groupHeaderText: 'Option',
                  borderWidth: 0.5,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Obx(() => Checkbox(
                              value: controller.is_cc.value,
                              onChanged: (v) {
                                controller.is_cc.value = v!;
                              })),
                          2.widthBox,
                          Text("Is Cost Center mandatory?",
                              style: customTextStyle.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          Obx(() => Checkbox(
                              value: controller.is_sl.value,
                              onChanged: (v) {
                                controller.is_sl.value = v!;
                              })),
                          2.widthBox,
                          Text(
                            "Is Sub Ledger mandatory?",
                            style: customTextStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                8.heightBox,
              ],
            ),
          ),
        ),
      ), () {
    if (!b) {
      b = true;
      Future.delayed(const Duration(seconds: 2), () {
        b = false;
      });

      controller.saveLedger(e, isEdit);
      //p_cid in int, p_id in int, p_name in varchar2,p_pid in int, p_code in varchar2, p_sl in int, p_isgroup in int
    }
  });
}

void _ledgerCategoryPopup(
    LedgerMasterController controller, ModelLedgerMaster e, bool isEdit) async {
  if (isEdit) {
    controller.txt_ledgerCategory_code.text = e.cODE!;
    controller.txt_ledgerCat_Serial.text = e.sL!;
    controller.txt_LedgerCat_name.text = e.nAME!;
  } else {
    controller.txt_ledgerCategory_code.text = '';
    controller.txt_ledgerCat_Serial.text = '';
    controller.txt_LedgerCat_name.text = '';
  }

  bool b = false;
  await CustomDialog(
      controller.context,
      Text(
          "${isEdit ? 'Edit ' : ''}Ledger Category Under\\ ${isEdit ? controller.ledger_list.where((p0) => p0.iD == e.pARENTID).first.nAME : e.nAME!}"),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomGroupBox(
          groupHeaderText: 'Category',
          borderWidth: 0.5,
          child: SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: CustomTextBox(
                              isDisable: isEdit ? false : true,
                              isFilled: false,
                              isReadonly: isEdit ? false : true,
                              caption: "Code",
                              maxlength: 15,
                              controller: controller.txt_ledgerCategory_code,
                              onChange: (v) {})),
                      8.widthBox,
                      Expanded(
                          flex: 3,
                          child: CustomTextBox(
                              caption: "Serial",
                              textInputType: TextInputType.number,
                              maxlength: 5,
                              controller: controller.txt_ledgerCat_Serial,
                              onChange: (v) {})),
                    ],
                  ),
                  12.heightBox,
                  CustomTextBox(
                      caption: "Ledger Category Name",
                      maxlength: 150,
                      width: double.infinity,
                      controller: controller.txt_LedgerCat_name,
                      onChange: (v) {}),
                  8.heightBox,
                ],
              ),
            ),
          ),
        ),
      ), () {
    if (!b) {
      b = true;
      Future.delayed(const Duration(seconds: 2), () {
        b = false;
      });

      controller.saveLedgerCategory(e.iD!, isEdit, e);
      //p_cid in int, p_id in int, p_name in varchar2,p_pid in int, p_code in varchar2, p_sl in int, p_isgroup in int
    }
  });
}

Widget _groupPart(LedgerMasterController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: _node(
          26,
          Row(
            children: [
              Text('${e.cODE!} - ${e.nAME!}',
                  style: customTextStyle.copyWith(
                    fontSize: 15.5,
                    fontFamily: appFontMuli,
                    fontWeight: FontWeight.bold,
                    // color: appColorLogoDeep,
                  )),
              10.widthBox,
              Text(
                '(Group)',
                style: _style(),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: PoppupMenu(
                menuList: [
                  PopupMenuItem(
                      child: const ListTile(
                        title: Text("Add Sub Group"),
                        trailing: Icon(Icons.add_rounded),
                      ),
                      onTap: () => _sub_GroupPopup(controller, e, false)),
                  PopupMenuItem(
                      child: const ListTile(
                        title: Text("Edit Group"),
                        trailing: Icon(Icons.edit_rounded),
                      ),
                      onTap: () {
                        _groupPopup(controller, e, true);
                      }),
                ],
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.construction_sharp,
                    size: 22,
                    color: appColorLogo,
                  ),
                )),
          ),
          controller.ledger_list
              .where((p0) => p0.pARENTID == e.iD)
              .map(
                (e) => _subGroupPart(controller, e),
              )
              .toList()),
    );

_style() => customTextStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontStyle: FontStyle.italic);

void _groupPopup(
    LedgerMasterController controller, ModelLedgerMaster e, bool isEdit) async {
  if (isEdit) {
    controller.txt_geroup_code.text = e.cODE!;
    controller.txt_group_Serial.text = e.sL!;
    controller.txt_geroup_name.text = e.nAME!;
  } else {
    controller.txt_geroup_code.text = '';
    controller.txt_group_Serial.text = '';
    controller.txt_geroup_name.text = '';
  }
  // dialog = CustomAwesomeDialog(context: context);
  bool b = false;
  await CustomDialog(
      controller.context,
      Text( overflow: TextOverflow.ellipsis,
          "${isEdit ? 'Edit ' : ''} Group Under\\ ${isEdit ? controller.ledger_list.where((p0) => p0.iD == e.pARENTID).first.nAME : e.nAME!}"),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 350,
          child: CustomGroupBox(
            borderWidth: 0.5,
            groupHeaderText: 'Group',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 5,
                          child: CustomTextBox(
                              isDisable: isEdit ? false : true,
                              isFilled: false,
                              isReadonly: isEdit ? false : true,
                              caption: "Code",
                              maxlength: 15,
                              controller: controller.txt_geroup_code,
                              onChange: (v) {})),
                      8.widthBox,
                      Expanded(
                          flex: 3,
                          child: CustomTextBox(
                              caption: "Serial",
                              textInputType: TextInputType.number,
                              maxlength: 5,
                              controller: controller.txt_group_Serial,
                              onChange: (v) {})),
                    ],
                  ),
                  12.heightBox,
                  CustomTextBox(
                      caption: "Group Name",
                      maxlength: 150,
                      width: double.infinity,
                      controller: controller.txt_geroup_name,
                      onChange: (v) {}),
                  8.heightBox,
                ],
              ),
            ),
          ),
        ),
      ), () {
    if (!b) {
      b = true;
      Future.delayed(const Duration(seconds: 2), () {
        b = false;
      });

      controller.saveGroup(e, isEdit);
      //p_cid in int, p_id in int, p_name in varchar2,p_pid in int, p_code in varchar2, p_sl in int, p_isgroup in int
    }
  });
}

Widget _ledgerPart(LedgerMasterController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(
        left: 32,
      ),
      child: Container(
       decoration: const BoxDecoration(
         color: Colors.white,
         boxShadow: [
          BoxShadow(
            color: appColorGray200,
            spreadRadius: .1,
            blurRadius: .1
          )
         ]
       ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_right),
                  4.widthBox,
                  Text(
                    '${e.cODE!} - ${e.nAME!}',
                    style: customTextStyle.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color:appColorMint),
                  ),
                ],
              ),
              8.widthBox,
              // Expanded(
              //     child: Container(
              //   height: 0.5,
              //   color: appColorBlue.withOpacity(0.3),
              // )),
              // 8.widthBox,
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, top: 8, bottom: 8, right: 35),
                child: PoppupMenu(
                    menuList: [
                      PopupMenuItem(
                          child: const ListTile(
                            title: Text("Edit Ledger"),
                            trailing: Icon(Icons.edit_rounded),
                          ),
                          onTap: () => _ledgerPopup(controller, e, true)),
                    ],
                    child: const Icon(
                      Icons.list,
                      size: 18,
                      color: appColorPrimary,
                    )),
              )
            ],
          ),
        ),
      ),
    );

Widget _node(@required double leftPad, @required Widget name,
        @required Widget event, @required List<Widget> children) =>
    Padding(
      padding: EdgeInsets.only(left: leftPad),
      child: CustomPanel(
        isExpandRow: false,
        openIcon: CupertinoIcons.folder_open,
        isSelectedColor: false,
        isSurfixIcon: false,
        isLeadingIcon: true,
        isExpanded: false,
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [name, 15.widthBox, event],
        ),
      
        /// Ledger-------
        children: children,
      ),
    );
