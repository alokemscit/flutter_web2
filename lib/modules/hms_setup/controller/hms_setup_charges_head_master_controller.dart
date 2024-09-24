import 'package:web_2/core/config/const.dart';

class LabServiceCategoryHeadController extends GetxController {
  //LabServiceCategoryHeadController({required this.context});
  late BuildContext context;
  late data_api2 api;
  late CustomAwesomeDialog dialog;
  late CustomBusyLoader loader;
  var user = ModelUser().obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var statusList = <ModelCommonMaster>[].obs;
  var service_urgency_List = <ModelCommonMaster>[].obs;
  var service_head_List = <ModelCommonMaster>[].obs;

  // var department_list_all = <ModelDepartment>[].obs;
  var cmb_service_cat_status = ''.obs;
  var cmb_head_status = ''.obs;
  var editServiceCatID = ''.obs;
  var editHeadID = ''.obs;

  final TextEditingController txt_ServiceCatName = TextEditingController();
  final TextEditingController txt_HeadName = TextEditingController();
  final TextEditingController txt_HeadName_search = TextEditingController();

  var list_tasks = <ModelCommonMaster>[].obs;

  void saveUpdateHead() async {
    dialog = CustomAwesomeDialog(context: context);
    if (txt_HeadName.text == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please enter Charge Name"
        ..show();
      return;
    }
    if (cmb_head_status.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select valid status"
        ..show();
      return;
    }
    try {
      loader = CustomBusyLoader(context: context);
      loader.show();
      var x = await api.createLead([
        {
          "tag": "43",
          "id": editHeadID.value,
          "cid": user.value.cid,
          "name": txt_HeadName.text,
          "status": cmb_head_status.value
        }
      ]);
      loader.close();
      if (checkJson(x)) {
        ModelStatus st = await getStatusWithDialog(x, dialog);
        if (st.status == '1') {
          service_head_List
              .removeWhere((element) => element.id == editHeadID.value);
          service_head_List.insert(
              0,
              ModelCommonMaster(
                  id: st.id,
                  name: txt_HeadName.text,
                  status: cmb_head_status.value));
          txt_HeadName.text = '';
          editHeadID.value = '';
          cmb_head_status.value = '1';
          dialog
            ..dialogType = DialogType.success
            ..message = st.msg!
            ..show();
        }
      }
    } catch (e) {
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
      loader.close();
    }
  }

  void saveUpdateServiceUrgebcy() {
    dialog = CustomAwesomeDialog(context: context);
    if (txt_ServiceCatName.text == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please enter valid Service of Urgency Name"
        ..show();
      return;
    }
    if (cmb_service_cat_status.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please select valid status for Service of Urgency Name"
        ..show();
      return;
    }

    try {
      loader = CustomBusyLoader(context: context);
      loader.show();
      //@id,@cid ,@name ,@status
      api.createLead([
        {
          "tag": "42",
          "id": editServiceCatID.value,
          "cid": user.value.cid,
          "name": txt_ServiceCatName.text,
          "status": cmb_service_cat_status.value
        }
      ]).then((value) {
        loader.close();
        getStatusWithDialog(value, dialog).then((value) {
          if (value.status == "1") {
            service_urgency_List
                .removeWhere((element) => element.id == editServiceCatID.value);
            service_urgency_List.insert(
                0,
                ModelCommonMaster(
                    id: value.id,
                    name: txt_ServiceCatName.text,
                    status: cmb_service_cat_status.value));
            txt_ServiceCatName.text = '';
            editServiceCatID.value = '';
            cmb_service_cat_status.value = "1";
          }
        });
      });
    } catch (e) {
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
      loader.close();
    }
  }


  @override
  void onInit() async {
    super.onInit();
    list_tasks.add(ModelCommonMaster(id: "1", name: "Store Type"));
    list_tasks.add(ModelCommonMaster(id: "2", name: "Item Group"));
    list_tasks.add(ModelCommonMaster(id: "3", name: "Item Sub Group"));
    list_tasks.add(ModelCommonMaster(id: "4", name: "Unit Master"));
    api = data_api2();
    isLoading.value = true;
    try {
      statusList.addAll(getStatusMaster());
      user.value = await getUserInfo();
      var x = await api.createLead([
        {"tag": "40", "cid": user.value.cid}
      ]);
      service_urgency_List
          .addAll(x.map((e) => ModelCommonMaster.fromJson(e)).toList());

      x = await api.createLead([
        {"tag": "41", "cid": user.value.cid}
      ]);
      service_head_List
          .addAll(x.map((e) => ModelCommonMaster.fromJson(e)).toList());

      isLoading.value = false;
      isError.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
  }
}
