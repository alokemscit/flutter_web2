import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/core/config/config.dart';
import 'package:web_2/data/data_api.dart';

import 'package:web_2/core/config/mixin_attr_for_controller.dart';
import 'package:web_2/modules/hms_setup/model/model_hms_charges_config.dart';
import 'package:web_2/modules/hms_setup/model/model_hrms_section_master.dart';
import 'package:web_2/modules/hrm/setup_attributes/model/model_hr_common_master.dart';

class HmsChargesConfigController extends GetxController with MixInController {
  final TextEditingController text_search = TextEditingController();
  var service_head_List = <ModelCommonMaster>[].obs;

  var section_list_all = <ModelHmsSectionMaster>[].obs;
  var section_list_temp = <ModelHmsSectionMaster>[].obs;

  var config_list_all = <ModelHmsChargesConfig>[].obs;

  var selectedSectionID = ''.obs;
  //
  //var loadAgin = false.obs;

  void search() async {
  
    var x = section_list_all.where((p0) =>
        p0.hmsDeptName!
            .toUpperCase()
            .contains(text_search.text.toUpperCase()) ||
        p0.name!.toUpperCase().contains(text_search.text.toUpperCase()));
    section_list_temp.clear();
    section_list_temp.addAll(x);
    //loadAgin.value = false;
  }

  void updateCheckBox(String sid, String hid) {
    ModelHmsChargesConfig x = config_list_all
        .where((p0) => p0.chargeId == hid && p0.secId == sid)
        .first;
    x.issec = x.issec == "0" ? "1" : "0";

    config_list_all.removeWhere((p0) => p0.chargeId == hid && p0.secId == sid);
    config_list_all.add(x);

    print({
      "tag": "52",
      "cid": user.value.cid,
      "sid": sid,
      "hid": hid,
      "val": (x.issec == "0" ? "1" : "0")
    });
    api.createLead([
      {
        "tag": "52",
        "cid": user.value.cid,
        "sid": sid,
        "hid": hid,
        "val": (x.issec)
      }
    ]).then((value) {});

    // print(x.length);

    // config_list_all.map((element) {
    //   print(element.chargeId.toString() + " : " + hid);
    //   print(element.secId.toString() + " : " + sid);
    //   //element.secId == sid &&
    //   if (element.chargeId == hid && element.secId == sid) {
    //     element.issec = element.issec == "1" ? "0" : "1";
    //     print("Updated");
    //   }
    //   return element;
    // });
    //config_list_all.clear();
    // config_list_all.addAll(x);
  }

  void saveConfig() {
    //print(user.value.cname);
  }

  @override
  void onInit() async {
    api = data_api2();
    super.onInit();
    isLoading.value = true;
    try {
      user.value = await getUserInfo();

      var x = await api.createLead([
        {"tag": "41", "cid": user.value.cid}
      ]);
      service_head_List
          .addAll(x.map((e) => ModelCommonMaster.fromJson(e)).toList());

      x = await api.createLead([
        {"tag": "48", "cid": user.value.cid}
      ]);

      section_list_all
          .addAll(x.map((e) => ModelHmsSectionMaster.fromJson(e)).toList());
      section_list_temp.addAll(section_list_all);

      x = await api.createLead([
        {"tag": "51", "cid": user.value.cid}
      ]);

      config_list_all
          .addAll(x.map((e) => ModelHmsChargesConfig.fromJson(e)).toList());

      // List<dynamic> m = service_head_List.map((element) {
      //   for (var i = 0; i < section_list_temp.length;) {
      //     return {
      //       'id': element.id,
      //       'name': element.name,
      //       'hmsDeptName': section_list_temp[i].hmsDeptName,
      //       'hmsDeptName2': section_list_temp[i].hmsDeptName,
      //       "val": "0"
      //     };
      //   }
      // }).toList();

      // print(m.map((e) => e));

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
