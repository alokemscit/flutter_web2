// ignore: camel_case_types
class main_app_menu {
  int? id;
  String? name;
  String? description;
  String? icon;

  main_app_menu({this.id, this.name, this.description, this.icon});

  main_app_menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }

}

// ignore: non_constant_identifier_names
Future< List<main_app_menu>> menu_app_list() async{
return  list.map((post) => main_app_menu.fromJson(post)).toList();
} 

List<dynamic> list = [
  {
    "id": 1,
    "name": "Patient Registration",
    "description":
        "This module allows hospital staff to register new patients, collect their personal information, and create a unique patient ID.",
    "icon": "registration.png"
  },
  {
    "id": 2,
    "name": "Appointment Scheduling",
    "description":
        "This module enables the scheduling of patient appointments with doctors, helping to manage the hospital's daily schedule efficiently.",
    "icon": "appintment3.png"
  },
  {
    "id": 3,
    "name": "Electronic Health Records (EHR)",
    "description":
        "EHR module stores patient medical records electronically, making it easy to access patient information, medical history, and test results.",
    "icon": "emr.png"
  },
  {
    "id": 4,
    "name": "Billing and Invoicing",
    "description":
        "This module handles financial transactions, generates bills for patients, and tracks payments and insurance claims.",
    "icon": "billing2.png"
  },
  {
    "id": 5,
    "name": "Pharmacy Management",
    "description":
        "Pharmacy management module tracks medication inventory, issues prescriptions, and manages medication dispensing.",
    "icon": "pharmacy.png"
  },
  {
    "id": 6,
    "name": "Laboratory Information System",
    "description":
        "This module manages lab tests, records test results, and facilitates communication between lab technicians and doctors.",
    "icon": "laboratory.png"
  },
  {
    "id": 7,
    "name": "Inventory Management",
    "description":
        "Inventory management module helps track and manage medical supplies, equipment, and other hospital resources.",
    "icon": "inventory2.png"
  },
  {
    "id": 8,
    "name": "Human Resources Management",
    "description":
        "HR module manages hospital staff, including recruitment, payroll, and attendance records.",
    "icon": "hrm.png"
  },
  {
    "id": 9,
    "name": "Radiology Imaging",
    "description":
        "The Radiology Imaging module manages the storage and retrieval of X-rays, MRIs, and other medical images for patient diagnosis and treatment.",
    "icon": "radiology.png"
  },
  // {
  //   "id": 10,
  //   "name": "Patient Check-In/Check-Out",
  //   "description":
  //       "This module handles the check-in and check-out process for patients, capturing their arrival and departure times and updating their records.",
  //   "icon": "check_in_out_icon.png"
  // },
  {
    "id": 11,
    "name": "Ward Management",
    "description":
        "Ward management module helps in assigning and tracking patient admissions, discharges, and transfers within the hospital.",
    "icon": "bedmanagement.png"
  },
  // {
  //   "id": 12,
  //   "name": "Appointment Reminders",
  //   "description":
  //       "This module sends appointment reminders and notifications to patients via SMS, email, or other communication channels.",
  //   "icon": "appointment_reminders_icon.png"
  // },
  // {
  //   "id": 13,
  //   "name": "Telemedicine Integration",
  //   "description":
  //       "Telemedicine module facilitates virtual consultations with doctors, enabling patients to receive medical advice remotely.",
  //   "icon": "telemedicine_icon.png"
  // },
  {
    "id": 14,
    "name": "Patient Feedback and Surveys",
    "description":
        "Collects and analyzes patient feedback to improve the quality of care and services provided by the hospital.",
    "icon": "feedback.png"
  },
  // {
  //   "id": 15,
  //   "name": "Insurance Management",
  //   "description":
  //       "Manages patient insurance information, verifies coverage, and handles insurance claims and reimbursements.",
  //   "icon": "insurance_management_icon.png"
  // },
  {
    "id": 16,
    "name": "Medical Equipment Maintenance",
    "description":
        "Tracks maintenance schedules and repairs for medical equipment to ensure their proper functioning.",
    "icon": "medicalequipment.png"
  },
  {
    "id": 17,
    "name": "Prescription Management",
    "description": "The Prescription Management module allows doctors to create and manage patient prescriptions, including medications and dosages.",
    "icon": "prescription2.png"
  }

].toList();
