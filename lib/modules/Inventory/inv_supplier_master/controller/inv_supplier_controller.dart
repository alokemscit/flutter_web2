import 'package:pdf/widgets.dart';
import 'package:web_2/component/custom_pdf_report_generator.dart';
import 'package:web_2/core/config/const.dart';

import '../model/inv_model_supplier_master.dart';

class SupplierMasterController extends GetxController with MixInController {
  final TextEditingController txt_code = TextEditingController();
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_address = TextEditingController();
  final TextEditingController txt_contactno = TextEditingController();
  final TextEditingController txt_search = TextEditingController();

  //var editSupplierID = ''.obs;

  var statusList = <ModelCommonMaster>[].obs;
  //var list_store_type = <ModelCommonMaster>[].obs;
  var isNew = false.obs;
  var iscreateFinanceLedger = false.obs;
  var cmb_status = ''.obs;
  var list_supp_master = <ModelSupplierMaster>[].obs;
  var list_supp_temp = <ModelSupplierMaster>[].obs;
  var editedSupplier = ModelSupplierMaster().obs;
  late Font? font;

  void undo() {
    txt_address.text = '';
    txt_code.text = '';
    txt_contactno.text = '';
    txt_search.text = '';
    txt_name.text = '';
    editedSupplier.value = ModelSupplierMaster();
  }

  void setEdit(ModelSupplierMaster f) {
    editedSupplier.value = f;
    isNew.value = true;
    txt_name.text = f.name ?? '';
    txt_address.text = f.address ?? '';
    txt_code.text = f.code ?? '';
    txt_contactno.text = f.mob ?? '';
    cmb_status.value = (f.status ?? 1).toString();
  }

  void save_update_supplier() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    if (isCheckCondition(txt_name.text == '', dialog, 'Name required')) return;
    if (isCheckCondition(
        cmb_status.value == '', dialog, 'Please select status')) return;
    // loader.show();
    try {
      //@cid int,@id int, @code varchar(15),  @eid int,@name varchar(150),@address varchar(250),@mob varchar(25),@status tinyint,@is_sub_ledger tinyint
      ModelStatus st = await commonSaveUpdate(api, loader, dialog, [
        {
          "tag": "70",
          "cid": user.value.cid,
          "id": editedSupplier.value.id ?? '0',
          "code": txt_code.text,
          "eid": user.value.uid,
          "name": txt_name.text,
          "address": txt_address.text,
          "mob": txt_contactno.text,
          "status": cmb_status.value,
          "is_sub_ledger": iscreateFinanceLedger.value ? '1' : '0'
        }
      ]);
      if (st.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show()
          ..onTap = () {
            if (editedSupplier.value.id != null) {
              list_supp_master
                  .removeWhere((e) => e.id == editedSupplier.value.id);
            }
            list_supp_master.insert(
                0,
                ModelSupplierMaster(
                    id: int.parse(st.id ?? '0'),
                    address: txt_address.text,
                    code: editedSupplier.value.code ?? st.extra,
                    mob: txt_contactno.text,
                    name: txt_name.text,
                    slId: 0,
                    status: int.parse(cmb_status.value)));
            list_supp_temp
              ..clear()
              ..addAll(list_supp_master);

            undo();
          };
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void setAddNew() {
    dialog = CustomAwesomeDialog(context: context);

    clearControllervalue();
    isNew.value = true;
  }

  void clearControllervalue() {
    txt_address.text = '';
    txt_code.text = '';
    txt_contactno.text = '';
    txt_search.text = '';
    txt_name.text = '';
    isNew.value = false;
  }

  @override
  void onInit() async {
    isLoading.value = true;
    statusList.addAll(getStatusMaster());
    api = data_api2();
    user.value = await getUserInfo();
    if (!await isValidLoginUser(this)) return;
    font = await CustomLoadFont(appFontPathLato);
    try {
      var x = await api.createLead([
        {"tag": "71", "cid": user.value.cid}
      ]);
      if (checkJson(x)) {
        list_supp_master.addAll(x.map((e) => ModelSupplierMaster.fromJson(e)));
        list_supp_temp.addAll(list_supp_master);
      }
      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }
    super.onInit();
  }

  void hideEntry() {
    editedSupplier.value = ModelSupplierMaster();
    isNew.value = false;
  }

  void serach() {
    list_supp_temp
      ..clear()
      ..addAll(list_supp_master.where((e) =>
          e.name
              .toString()
              .toUpperCase()
              .contains(txt_search.text.toUpperCase()) ||
          e.code
              .toString()
              .toUpperCase()
              .contains(txt_search.text.toUpperCase()) ||
          e.address
              .toString()
              .toUpperCase()
              .contains(txt_search.text.toUpperCase()) ||
          e.mob
              .toString()
              .toUpperCase()
              .contains(txt_search.text.toUpperCase())));
  }

  print_supplier() {
    loader = CustomBusyLoader(context: context);
    loader.show();
    //list_supp_master.sort((a, b) => b.name!.compareTo(a.name!));
    list_supp_master.sort((a, b) => a.name!.compareTo(b.name!));
    list_supp_master.refresh();
    CustomPDFGenerator(
        font: font,
        header: [
          pwTextOne(font, '', user.value.cname!, 14),
          pwHeight(8),
          pwTextOne(font, '', 'List of Suppliers'),
          //pwHeight(4),
          // pwText2Col(font, caption1, text1, caption2, text2)
          //pwText2Col(font, '', text1, caption2, text2)
        ],
        footer: [
          pwTextOne(font, 'Printed By : ', user.value.name!, 9,
              pwMainAxisAlignmentStart),
        ],
        body: [
          pwGenerateTable([
            20,
            80,
            60,
            30,
            20
          ], [
            pwTableColumnHeader('Code', font, pwAligmentCenter),
            pwTableColumnHeader('Name', font),
            pwTableColumnHeader('Address', font),
            pwTableColumnHeader('Contact no.', font),
            pwTableColumnHeader('Status', font, pwAligmentCenter),
          ], [
            ...list_supp_master.map((f) => pwTableRow([
                  pwTableCell(f.code ?? '', font, pwAligmentCenter),
                  pwTableCell(f.name ?? '', font),
                  pwTableCell(f.address ?? '', font),
                  pwTableCell(f.mob ?? '', font),
                  pwTableCell((f.status ?? 0) == 1 ? 'Active' : 'inactive',
                      font, pwAligmentCenter),
                ]))
          ])
        ],
        fun: () {
          loader.close();
        }).ShowReport();
  }
}
