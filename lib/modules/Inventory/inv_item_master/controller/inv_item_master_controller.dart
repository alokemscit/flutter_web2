// ignore_for_file: curly_braces_in_flow_control_structures
 
 
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:web_2/component/widget/pdf_widget/api/pdf_api.dart';
import 'package:web_2/core/config/const.dart';
import 'package:web_2/modules/Inventory/attribute_setup_page/model/model_inv_brand_company.dart';
import 'package:web_2/modules/Inventory/attribute_setup_page/model/model_store_unit.dart';

import '../../attribute_setup_page/model/model_inv_generic_master.dart';
import '../../attribute_setup_page/model/model_inv_item_group_master.dart';
import '../../attribute_setup_page/model/model_inv_item_sub_group_master.dart';
import '../model/inv_model_item_master.dart';

class InvItemMasterController extends GetxController with MixInController {
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_code = TextEditingController();
  final TextEditingController txt_search = TextEditingController();

  var editItemID = ''.obs;
  var list_company_master = <ModelInvBrandCompany>[].obs;
  var cmb_companyID = ''.obs;
  var list_company_temp = <ModelInvBrandCompany>[].obs;
  var list_storeUnit = <ModelStoreUnit>[].obs;
  var list_storeUnit_temp = <ModelStoreUnit>[].obs;
  var cmb_unitID = ''.obs;
  var list_storeTypeList = <ModelCommonMaster>[].obs;
  var cmb_storetypeID = ''.obs;
  var list_group = <ModelItemGroupMaster>[].obs;
  var list_group_temp = <ModelItemGroupMaster>[].obs;
  var cmb_groupID = ''.obs;
  var list_subGroup = <ModelItemSubGroupMaster>[].obs;
  var list_subGroup_temp = <ModelItemSubGroupMaster>[].obs;
  var cmb_subGroupID = ''.obs;
  var list_generic_master = <ModelGenericMaster>[].obs;
  var list_generic_temp = <ModelGenericMaster>[].obs;
  var cmb_generic = ''.obs;
  var list_item_master = <ModelItemMaster>[].obs;
  var list_item_temp = <ModelItemMaster>[].obs;

  void search() {
    list_item_temp.clear();
    list_item_temp.addAll(list_item_master.where((f) =>
        f.name!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.code!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.conName!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.genName!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.grpName!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.sgrpName!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.stypeName!.toUpperCase().contains(txt_search.text.toUpperCase())));
  }

  void setEdit(ModelItemMaster f) async {
    editItemID.value = f.id!;
    cmb_storetypeID.value = f.storeTypeId!;
    cmb_companyID.value = f.comId!;

    cmb_groupID.value = f.groupId!;
    setGroup(f.groupId!);
    cmb_generic.value = f.genId!;
    cmb_subGroupID.value = f.subGroupId!;
    cmb_unitID.value = f.unitId!;
    txt_code.text = f.code!;
    txt_name.text = f.name!;
  }

  void setUndo() {
    editItemID.value = '';
    txt_code.text = '';
    txt_name.text = '';
  }

  void saveUpdateItem() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (isCheckCondition(
        cmb_storetypeID.value == '', dialog, 'Please select store type!'))
      return;
    if (isCheckCondition(
        cmb_companyID.value == '', dialog, 'Please select company!')) return;
    if (isCheckCondition(
        cmb_groupID.value == '', dialog, 'Please select group!')) return;
    if (isCheckCondition(
        cmb_subGroupID.value == '', dialog, 'Please select sub group!')) return;
    if (isCheckCondition(
        txt_name.text == '', dialog, 'Please enter valid item name!')) return;
    if (isCheckCondition(
        cmb_generic.value == '', dialog, 'Please select generic/brand name!'))
      return;
    if (isCheckCondition(
        cmb_unitID.value == '', dialog, 'Please select unit name!')) return;

//@cid int,@id int,@name varchar(200),@code varchar(15), @com_id int, @stype_id int,
//@grp_id int,@sgrp_id int, @gen_id int,@unit_id int,
//@status tinyint,@emp_id int
    ModelStatus s = await commonSaveUpdate(api, loader, dialog, [
      {
        "tag": "62",
        "cid": user.value.cid,
        "id": editItemID.value == '' ? "0" : editItemID.value,
        "name": txt_name.text,
        "code": txt_code.text,
        "com_id": cmb_companyID.value,
        "stype_id": cmb_storetypeID.value,
        "grp_id": cmb_groupID.value,
        "sgrp_id": cmb_subGroupID.value,
        "gen_id": cmb_generic.value,
        "unit_id": cmb_unitID.value,
        "status": "1",
        "emp_id": user.value.uid
      }
    ]);
    if (s.status == '1') {
      dialog
        ..dialogType = DialogType.success
        ..message = s.msg!
        ..show()
        ..onTap = () {
          if (editItemID.value != '') {
            list_item_master.removeWhere((f) => f.id == editItemID.value);
          }
          list_item_master.add(
            ModelItemMaster(
                cid: user.value.cid,
                code: s.extra,
                comId: cmb_companyID.value,
                conName: CustomListToGetName(
                    list_company_master, cmb_companyID.value),
                genId: cmb_generic.value,
                groupId: cmb_groupID.value,
                id: s.id,
                storeTypeId: cmb_storetypeID.value,
                subGroupId: cmb_subGroupID.value,
                unitId: cmb_unitID.value,
                genName:
                    CustomListToGetName(list_generic_master, cmb_generic.value),
                name: txt_name.text,
                grpName: CustomListToGetName(list_group, cmb_groupID.value),
                sgrpName:
                    CustomListToGetName(list_subGroup, cmb_subGroupID.value),
                stypeName: CustomListToGetName(
                    list_storeTypeList, cmb_storetypeID.value),
                unitName:
                    CustomListToGetName(list_storeUnit, cmb_unitID.value)),
          );
          list_item_temp.clear();
          list_item_temp.addAll(list_item_master
              .where((f) => f.storeTypeId == cmb_storetypeID.value));
          editItemID.value = '';
          txt_code.text = '';
          txt_name.text = '';
        };
    }
  }

  String CustomListToGetName(List<dynamic> list, String id) => list
      .where(
        (f) => f.id == id,
        //orElse: () => '', // Replace with your model type and default value
      )
      .first
      .name;

  void setGroup(String id) async {
    cmb_groupID.value = id;

    list_subGroup_temp.clear();
    list_subGroup_temp.addAll(list_subGroup.where(
        (f) => f.storeTypeId == cmb_storetypeID.value && f.groupId == id));
    cmb_subGroupID.value = '';
  }

  void setStoreType(String id) {
    cmb_storetypeID.value = id;
    list_company_temp.clear();
    list_company_temp.addAll(list_company_master.where((f) => f.stypeId == id));
    list_group_temp.clear();
    list_group_temp.addAll(list_group.where((f) => f.storeTypeId == id));
    list_generic_temp.clear();
    list_generic_temp.addAll(list_generic_master.where((f) => f.stypeId == id));
    list_storeUnit_temp.clear();
    list_storeUnit_temp.addAll(list_storeUnit.where((f) => f.stypeID == id));
    list_item_temp.clear();
    list_item_temp.addAll(list_item_master.where((f) => f.storeTypeId == id));
    cmb_companyID.value = '';
    cmb_generic.value = '';
    cmb_groupID.value = '';
    cmb_subGroupID.value = '';
    cmb_unitID.value = '';
  }

  @override
  void onInit() async {
    api = data_api2();
    isLoading.value = true;
    user.value = await getUserInfo();
    if (user.value.uid == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Re-Login Required';
      return;
    }
    try {
      var x = await api.createLead([
        {"tag": "30", "cid": user.value.cid}
      ]);
      //  print(x);
      if (checkJson(x)) {
        list_storeTypeList
            .addAll(x.map((e) => ModelCommonMaster.fromJson(e)).toList());
      }

      x = await api.createLead([
        {"tag": "28", "cid": user.value.cid}
      ]);
      if (checkJson(x)) {
        list_group
            .addAll(x.map((e) => ModelItemGroupMaster.fromJson(e)).toList());
      }
      api.createLead([
        {"tag": "32", "cid": user.value.cid}
      ]).then((x) {
        if (checkJson(x)) {
          list_subGroup.addAll(
              x.map((e) => ModelItemSubGroupMaster.fromJson(e)).toList());
        }
      });

      x = await api.createLead([
        {"tag": "57", "cid": user.value.cid}
      ]);
      if (checkJson(x)) {
        list_storeUnit.addAll(x.map((e) => ModelStoreUnit.fromJson(e)));
      }

      x = await api.createLead([
        {"tag": "59", "cid": user.value.cid}
      ]);
      if (checkJson(x)) {
        list_company_master
            .addAll(x.map((e) => ModelInvBrandCompany.fromJson(e)));
      }
      x = await api.createLead([
        {"tag": "61", "cid": user.value.cid}
      ]);
      // print(x);
      if (checkJson(x)) {
        list_generic_master
            .addAll(x.map((e) => ModelGenericMaster.fromJson(e)));
      }

      x = await api.createLead([
        {"tag": "63", "cid": user.value.cid}
      ]);
      // print(x);
      if (checkJson(x)) {
        list_item_master.addAll(x.map((e) => ModelItemMaster.fromJson(e)));
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }

  @override
  void onClose() {
    list_company_master.close();
    list_company_temp.close();
    list_generic_master.close();
    list_generic_temp.close();
    list_group.close();
    list_group_temp.close();
    list_item_master.close();
    list_item_temp.close();
    list_storeTypeList.close();
    list_storeUnit.close();
    list_storeUnit_temp.close();
    txt_code.dispose();
    txt_name.dispose();
    txt_search.dispose();
    super.onClose();
  }

  void print() {
    loader = CustomBusyLoader(context: context);
    _report(list: list_item_temp, user: user.value).showReport(loader);
  }
}

class _report {
  final List<ModelItemMaster> list;
  final ModelUser user;
  _report({required this.list, required this.user});

String getDate(){
return
            DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());
         
}

  pw.Widget _header() => pw.Column(children: [
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
          pw.Text(user.cname!,
              style:
                  pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        ]),
        pw.SizedBox(height: 10),
        pw.Row(children: [
          pw.Text('Store Type :',
              style:
                  pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(width: 8),
          pw.Text(list.first.stypeName!,
              style: const pw.TextStyle(fontSize: 13)),
        ]),
        pw.SizedBox(height: 15),
        pw.Divider(height: 2),
        pw.SizedBox(height: 15),
      ]);
  pw.Widget _footer() => pw.Column(children: [
        pw.Divider(height: 2),
        pw.SizedBox(height: 4),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
          pw.Text('Printed By :',
              style:
                  pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(width: 8),
          pw.Text(user.name!, style: const pw.TextStyle(fontSize: 9)),
          pw.SizedBox(width: 8),
           pw.Text('Printed Date :',
              style:
                  pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                   pw.SizedBox(width: 8),
          pw.Text(getDate(), style: const pw.TextStyle(fontSize: 9)),
        ]),
        pw.SizedBox(height: 4),

      ]);

  List<pw.Widget> _body() => [pw.Column(children: [
   pw.Table(
    border: pw.TableBorder.all(color: PdfColors.black),
  columnWidths: {
    0: const pw.FlexColumnWidth(30),  // First column
    1: const pw.FlexColumnWidth(100),  // Second column
    2: const pw.FlexColumnWidth(40),
    3: const pw.FlexColumnWidth(60), 
    4: const pw.FlexColumnWidth(60),  // Third column
  },
  children: [
    pw.TableRow(
      children: [
        pw.Text(' Code',style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
        pw.Text(' Name',style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
        pw.Text(' Unit',style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
        pw.Text(' Group',style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
         pw.Text(' Sub group',style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
      ],
    ),
    ...list.map((f)=>pw.TableRow(children:[
       pw.Padding( padding: const pw.EdgeInsets.symmetric(horizontal: 4,vertical: 2),
        child:  pw.Text( f.code!,style:const pw.TextStyle(fontSize: 10))),
        pw.Padding( padding: const pw.EdgeInsets.symmetric(horizontal: 4,vertical: 2),
        child:  pw.Text( f.name!,style:const pw.TextStyle(fontSize: 10))),
        pw.Padding( padding: const pw.EdgeInsets.symmetric(horizontal: 4,vertical: 2),
        child:  pw.Text( f.unitName!,style:const pw.TextStyle(fontSize: 10))),
         pw.Padding( padding: const pw.EdgeInsets.symmetric(horizontal: 4,vertical: 2),
        child:  pw.Text( f.grpName!,style:const pw.TextStyle(fontSize: 10))),
          pw.Padding( padding: const pw.EdgeInsets.symmetric(horizontal: 4,vertical: 2),
        child:  pw.Text( f.sgrpName!,style:const pw.TextStyle(fontSize: 10))),
    ] ))
    // Add more rows here
  ],
)
  ])
  ];

  void showReport(CustomBusyLoader loader) {
    PdfApi.showPDFformWidget(_body(), _header(), _footer(), () {
      loader.close();
    });
  }
}




 

// void showPDF(String body, dynamic controller,
//       [Function()? fun, bool isFinal = false]) async {
//     // var body = k1;

//     final pdf = pw.Document();
//     final fontData =
//         await rootBundle.load('assets/fonts/openSans/OpenSans-Regular.ttf');
//     final fontData1 =
//         await rootBundle.load('assets/fonts/openSans/OpenSans-Bold.ttf');
//     var font = pw.Font.ttf(fontData);
//     List<Font> lfont = [];
//     lfont.add(font);
//     font = pw.Font.ttf(fontData1);
//     final widgets = await HTMLToPdf().convert(body, fontFallback: lfont);
//     lfont.add(font);
//     lfont.add( await PdfGoogleFonts.robotoBlack());
//     lfont.add( await PdfGoogleFonts.latoBlack());
//     // print(widgets.toString());
//     pdf.addPage(
//       pw.MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         margin: const pw.EdgeInsets.only(left: 8, right: 8, bottom: 52, top: 8),
//         header: (pw.Context context) {
//           return header(controller, isFinal);
//         },
//         footer: (context) {
//           return footer(controller);
//         },
//         build: (context) => widgets,
//       ),
//     );

//     PdfInvoiceApi.openPdFromFile(pdf, 'Report', () {
//       if (fun != null) {
//         fun();
//       }
//     });
//   }

// class _a {
//   _a({
//     this.list = const [],
//     this.val = '',
//     this.onTap,
//     this.label = '',
//   });

//   dynamic list;
//   String val;
//   String label;
//   void Function(String vv)? onTap;
//   CustomDropDown create() {
//     return CustomDropDown(
//         id: val,
//         list: list,
//         onTap: (v) {
//           val = v!;
//           if (onTap != null) {
//             onTap!(v);
//           }
//         });
//   }

//   // CustomDropDown getCombo(dynamic list, String val) {

//   // }
// }
