import 'package:flutter/material.dart';
import 'package:web_2/modules/Inventory/attribute_setup_page/pages/inventory_attribute_setup.dart';
import 'package:web_2/modules/Inventory/warehouse_setup/warehouse_inv_setup.dart';
import 'package:web_2/modules/admin/module_page/model/model_module.dart';
import 'package:web_2/modules/finance/cost_center_page/cost_center_page.dart';
import 'package:web_2/modules/hms_setup/pages/hms_charges_config.dart';
import 'package:web_2/modules/hms_setup/pages/hms_report_section_setup.dart';
import 'package:web_2/modules/hrm/department_setup/department_setup_page.dart';
import 'package:web_2/modules/hrm/employee_master_page/employee_master.dart';
import 'package:web_2/modules/hrm/setup_attributes/attributes_setup_hr_page.dart';
import 'package:web_2/modules/hms_setup/pages/hms_department_Setup_setup.dart';
import 'package:web_2/modules/hms_setup/pages/hms_setup_charges_head_master.dart';
import 'package:web_2/modules/hms_setup/pages/hms_section_master.dart';
import 'package:web_2/modules/opd/doctor_setup/doctor_opd_setup_page.dart';
import 'package:web_2/modules/ot/ot_page/doctor_category_setup.dart';
import 'package:web_2/modules/ot/ot_page/operation_type.dart';
import 'package:web_2/modules/patient_registration/new_registration/patient_registration.dart';

import '../../modules/Inventory/inv_item_master/pages/inv_item_master_page.dart';
import '../../modules/admin/module_page/form_page.dart';
import '../../modules/admin/module_page/module_page.dart';
import '../../modules/appointment/doctor_appointment.dart';

import '../../modules/appointment/doctor_leave_page/doctor_leave_page.dart';
import '../../modules/appointment/time_slot_page/time_slot_page.dart';
import '../../modules/finance/ledger_master_page/ledger_master_page.dart';
import '../../modules/finance/sub_ledger_linkage_page/sub_ledger_linkage_page.dart';
import '../../modules/finance/sub_ledger_master/sub_ledger_master_page.dart';

Widget getPage(String id) {
  switch (id) {
    case "28":
      {
        return const TimeSlotPage();
      }
    case "30":
      {
        return const DoctorAppointment();
      }
    case "31":
      {
        return const DoctorLeave();
      }

    case "4":
      {
        return const Text("4");
      }
    case "24":
      {
        return const ModulePage();
      }
    case "25":
      {
        return const FormPage();
      }
    case "41":
      {
        return const PatientRegistration();
      }
    case "81":
      return const EmployeeMaster();
    case "88":
      return const OperationType();
    case "87":
      return const DoctorCategorySetup();
    case "102":
      return const DoctorOPDSetuo();
    case "103":
      return const DepartmentSetup();
    case "104":
      return const AttributesSetupHRM();
    // -------------------  Inventory ----------------
    case "106":
      return const InvAttributeSetup();
    case "107":
      return const WareHouseSetup();
    case '134':
      return const InvItemMaster();
    // ##################  end of inventory ------------------
    case "115":
      return const HmsChargeHeadMaster();
    case "114":
      return const HmsDepartmentSetup();
    case "116":
      return const HmsSectionMaster();
    case "117":
      return const HmsChargesConfig();
    case "121":
      return const ReportSectionSetup();

// Accounts ###############################
    case "126":
      return const LedgerMasterPage();
    case "127":
      return const SubLedgerMaster();
    case "128":
      return const ConstcenterPage();
    case "129":
      return const SubLeaderLinkageMaster();
//###########################################

    case "":
      return const SizedBox(
          //child: Text("Under Construction!"),
          );
    default:
      return const Center(
        child: Text(
          "Access Denied: You do not have permission to access this menu. \n Please contact with developer +8801744285616!",
          style: TextStyle(fontSize: 30, color: Colors.blue),
        ),
      );
  }
}