import 'package:flutter/material.dart';
import 'package:web_2/pages/admin/module_page/model/module_model.dart';
import 'package:web_2/pages/hrm/employee_master_page/employee_master.dart';

import '../../pages/admin/module_page/form_page.dart';
import '../../pages/admin/module_page/module_page.dart';
import '../../pages/appointment/doctor_appointment.dart';

import '../../pages/appointment/doctor_leave_page/doctor_leave_page.dart';
import '../../pages/appointment/time_slot_page/time_slot_page.dart';

Widget getPage(ModuleMenuList module, String id) {
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
    case "81":
      return const EmployeeMaster();

    default:
      return SizedBox();
  }
}