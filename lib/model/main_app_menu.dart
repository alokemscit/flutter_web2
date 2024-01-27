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
    "id": 19,
    "name": "Admin",
    "description":
        "Admin module setting up secure interface that allows administrators to manage various aspects of the ERP system",
    "icon": "settings.png"
  },
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
    "icon": "appointment.png"
  },
   {
    "id": 3,
    "name": "OPD And Prescription Management",
    "description": "The Prescription Management module allows doctors to create and manage patient prescriptions, including medications and dosages.",
    "icon": "prescription2.png"
  },
  
  {
    "id": 4,
    "name": "Billing and Invoicing",
    "description":
        "This module handles financial transactions, generates bills for patients, and tracks payments and insurance claims.",
    "icon": "billing2.png"
  },
  
  {
    "id": 6,
    "name": "Laboratory Information System",
    "description":
        "This module manages lab tests, records test results, and facilitates communication between lab technicians and doctors.",
    "icon": "laboratory.png"
  },
  // {
  //   "id": 5,
  //   "name": "OPD And Pharmacy Management",
  //   "description":
  //       "Pharmacy management module tracks medication inventory, issues prescriptions, and manages medication dispensing.",
  //   "icon": "pharmacy.png"
  // },
  
  {
    "id": 6,
    "name": "Operation Theatre Management",
    "description":
        "Operation theater management is crucial for a hospital's overall functionality, patient safety, and resource utilization.",
    "icon": "ot.png"
  },


{
    "id": 7,
    "name": "Inpatient Management",
    "description":
        "Inpatient management involves admitting and caring for patients in healthcare facilities.",
    "icon": "bedmanagement.png"
  },

{
    "id": 8,
    "name": "Nursing workbenches",
    "description":
        "Nursing workbenches streamline nursing processes, reduce administrative tasks, and enhance patient care quality and safety.",
    "icon": "nursing.png"
  },

{
    "id": 9,
    "name": "Dietary Management System",
    "description":
        "A dietary management system optimizes dietary and nutritional management in healthcare, education, and foodservice.",
    "icon": "diet.png"
  },


{
    "id": 10,
    "name": "House Keeping System",
    "description":
        "A housekeeping system streamlines and manages cleaning operations in settings like hotels and hospitals.",
    "icon": "housekeeping.png"
  },


 {
    "id": 11,
    "name": "Pharmacy Management",
    "description":
        "Managing and tracking pharmaceutical inventory, including ordering, stocking, and monitoring medication supplies.",
    "icon": "pharmacy.png"
  },



  {
    "id": 12,
    "name": "Inventory Management",
    "description":
        "Inventory management module helps track and manage medical supplies, equipment, and other hospital resources.",
    "icon": "inventory2.png"
  },
  {
    "id": 13,
    "name": "Human Resources Management",
    "description":
        "HR module manages hospital staff, including recruitment, payroll, and attendance records.",
    "icon": "hrm.png"
  },
  {
    "id": 14,
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
    "id": 15,
    "name": "Ward And Bed Management",
    "description":
        "Ward management module helps in assigning and tracking patient admissions, discharges, and transfers within the hospital.",
    "icon": "bedmanagement.png"
  },
  
  {
    "id": 16,
    "name": "Patient Feedback and Surveys",
    "description":
        "Collects and analyzes patient feedback to improve the quality of care and services provided by the hospital.",
    "icon": "feedback.png"
  },
  
  {
    "id": 17,
    "name": "Medical Equipment Maintenance",
    "description":
        "Tracks maintenance schedules and repairs for medical equipment to ensure their proper functioning.",
    "icon": "medicalequipment.png"
  },
 {
    "id": 18,
    "name": "Electronic Health Records (EHR)",
    "description":
        "EHR module stores patient medical records electronically, making it easy to access patient information, medical history, and test results.",
    "icon": "emr.png"
  },

].toList();
