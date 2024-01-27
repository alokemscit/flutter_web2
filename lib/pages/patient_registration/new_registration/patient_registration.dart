import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/pages/patient_registration/new_registration/controller/patient_registration_controller.dart';

import '../../../component/settings/config.dart';
import '../../../component/settings/functions.dart';
import '../../../component/widget/custom_datepicker.dart';
import '../../../component/widget/custom_dropdown.dart';
import '../../../component/widget/custom_textbox.dart';

class PatientRegistration extends StatelessWidget {
  const PatientRegistration({super.key});
void disposeController() {
    try {
      Get.delete<PatRegController>();
    } catch (e) {
      print('Error disposing EmployeeController: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    PatRegController rController = Get.put(PatRegController());
    return Scaffold(
      body: Responsive
      (mobile: _leftPart( rController), tablet: _leftPart( rController), desktop: _leftPart( rController),),
    );
  }
}

_leftPart(PatRegController econtroller) {
  // print("Call Again");

  return Container(
    //decoration:customBoxDecoration.copyWith(color: kWebBackgroundDeepColor),
    decoration: CustomCaptionDecoration(),
    // height: 200,
    //  color: Colors.amber,

    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCaptionForContainer("General Information"),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextBox(
                        //focusNode: econtroller.f_emp_id,
                        labelTextColor: Colors.black54,
                       // isDisable: econtroller.isDisableID.value, // true,
                       // isReadonly: econtroller.isDisableID.value,
                        caption: "ID",
                        width: 100,
                        maxlength: 10,
                        height: 28,
                        isFilled: true,
                        controller: TextEditingController(),//econtroller.txt_emp_id,
                        onChange: (v) {},
                        onSubmitted: (p0) {
                          //print("p0.characters");
                        },
                      ),
                  // InkWell(
                  //   onTap: () {
                  //     econtroller.EditEmployee();
                  //   },
                  //   child: Container(
                  //     padding: const EdgeInsets.all(4),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(color: kWebBackgroundDeepColor)),
                  //     child: Obx(() => Icon(
                  //           econtroller.isDisableID.value
                  //               ? Icons.edit
                  //               : Icons.undo_sharp,
                  //           size: 18,
                  //           color: kGrayColor,
                  //         )),
                  //   ),
                  // ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    CustomDropDown(
                      labelTextColor: Colors.black54,
                      id: null,
                      height: 28,
                      borderRadious: 2,
                      enabledBorderColor: Colors.grey,
                      focusedBorderColor: Colors.black,
                      enabledBorderwidth: 0.4,
                      focusedBorderWidth: 0.3,
                      labeltext: "Prefix",
                      list:[],// _getDropdownItem(econtroller, "prefix"),
                      onTap: (v) {
                        //econtroller.cmb_prefix.value = v.toString();
                      },
                      width: 100),
                  const Icon(
                    Icons.launch_outlined,
                    size: 18,
                    color: kGrayColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: CustomTextBox(
                        labelTextColor: Colors.black54,
                        caption: "Name",
                        borderRadious: 2,
                        enabledBorderColor: Colors.grey,
                        focusedBorderColor: Colors.black,
                        enabledBorderwidth: 0.4,
                        focusedBorderWidth: 0.3,
                        width: double.infinity,
                        maxlength: 100,
                        height: 28,
                        isFilled: true,
                        controller:TextEditingController(),// econtroller.txt_emp_name,
                        onChange: (v) {
                          //econtroller.setName(txt_emp_name.text);
                        }),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 3,
                      child: CustomDatePicker(
                        labelTextColor: Colors.black54,
                        date_controller:TextEditingController(),// econtroller.txt_emp_dob,
                        isInputMode: true,
                        isFilled: true,
                        label: "Date of Birth",
                        borderRadious: 2,
                        enabledBorderColor: Colors.grey,
                        focusedBorderColor: Colors.black,
                        enabledBorderwidth: 0.4,
                        focusedBorderWidth: 0.3,
                        bgColor: Colors.white,
                        height: 28,
                        isBackDate: true,
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 5,
                    child:  CustomDropDown(
                        labelTextColor: Colors.black54,
                        id:null,// econtroller.cmb_nationality.value,
                        height: 28,
                        labeltext: "Nationality",
                        list:[],// _getDropdownItem(econtroller, "country"),
                        onTap: (v) {
                         // econtroller.cmb_nationality.value = v.toString();
                        },
                        width: 100),
                  ),
                ],
              ),
              CustomTextBox(
                  labelTextColor: Colors.black54,
                 // focusNode: econtroller.f_emp_father,
                  caption: "Father's Name",
                  width: double.infinity,
                  height: 28,
                  maxlength: 100,
                  isFilled: true,
                  controller:TextEditingController(),// econtroller.txt_emp_father,
                  onEditingComplete: () {
                    print("on onEditingComplete");
                    //print('object');
                    // FocusScope.of(Get.context!)
                    //     .requestFocus(econtroller.f_emp_mother);
                    // //FocusScopeNode currentFocusScope = FocusScope.of(Get.context!);
                    //currentFocusScope.requestFocus(econtroller.f_emp_mother);
                  },
                  onSubmitted: (p0) {
                    // print("on submir");
                    // FocusScope.of(Get.context!)
                    //     .requestFocus(econtroller.f_emp_mother);
                  },
                  onChange: (v) {
                    print("on change");
                  }),
              CustomTextBox(
                  //focusNode: econtroller.f_emp_mother,
                  labelTextColor: Colors.black54,
                  caption: "Mother's name",
                  width: double.infinity,
                  maxlength: 100,
                  height: 28,
                  isFilled: true,
                  controller:TextEditingController(),// econtroller.txt_emp_mother,
                  onChange: (v) {}),
              CustomTextBox(
                  labelTextColor: Colors.black54,
                  caption: "Spouse Name",
                  width: double.infinity,
                  maxlength: 100,
                  height: 28,
                  isFilled: true,
                  controller:TextEditingController(),// econtroller.txt_emp_spouse,
                  onChange: (v) {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomDropDown(
                              labelTextColor: Colors.black54,
                              id:null,// econtroller.cmb_gender.value,
                              height: 28,
                              labeltext: "Gender",
                              list:[],// _getDropdownItem(econtroller, "gender"),
                              onTap: (v) {
                               // econtroller.cmb_gender.value = v.toString();
                              },
                              width: 100),
                        ),
                        const Icon(
                          Icons.launch_outlined,
                          size: 18,
                          color: kGrayColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child:  CustomDropDown(
                              labelTextColor: Colors.black54,
                              id:null,// econtroller.cmb_religion.value,
                              height: 28,
                              labeltext: "Religion",
                              list: [],//_getDropdownItem(econtroller, "religion"),
                              onTap: (v) {
                               // econtroller.cmb_religion.value = v.toString();
                              },
                              width: 100),
                        ),
                        const Icon(
                          Icons.launch_outlined,
                          size: 18,
                          color: kGrayColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomDropDown(
                              labelTextColor: Colors.black54,
                              id: null,//econtroller.cmb_maritalstatus.value,
                              height: 28,
                              labeltext: "Marital Status",
                              list:[],// _getDropdownItem(econtroller, "marital"),
                              onTap: (v) {
                                
                              },
                              width: 100),
                        ),
                        const Icon(
                          Icons.launch_outlined,
                          size: 18,
                          color: kGrayColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: 
                          CustomDropDown(
                              labelTextColor: Colors.black54,
                              id: null,//econtroller.cmb_bloodgroup.value,
                              height: 28,
                              labeltext: "Blood Group",
                              list:[],// _getDropdownItem(econtroller, "bloodgroup"),
                              onTap: (v) {
                                //econtroller.cmb_bloodgroup.value = v.toString();
                              },
                              width: 100),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.launch_outlined,
                            size: 18,
                            color: kGrayColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child:  
                          CustomDropDown(
                              labelTextColor: Colors.black54,
                              //identitytype
                              id: null,
                              height: 28,
                              labeltext: "Identity Type",
                              list:[],
                                  //_getDropdownItem(econtroller, "identitytype"),
                              onTap: (v) {
                               // econtroller.cmb_identitytype.value =
                                    v.toString();
                              },
                              width: 100),
                        ),
                        const Icon(
                          Icons.launch_outlined,
                          size: 18,
                          color: kGrayColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomTextBox(
                              // onEditingComplete: () => FocusScope.of(Get.context!).requestFocus(econtroller.cmb_designation!),
                              labelTextColor: Colors.black54,
                              caption: "Identity Number",
                              width: double.infinity,
                              height: 28,
                              maxlength: 100,
                              isFilled: true,
                              controller: TextEditingController(), //econtroller.txt_emp_identityname,
                              onChange: (v) {}),
                        ),
                        // InkWell(
                        //   onTap: () {},
                        //   child: const Icon(
                        //     Icons.launch_outlined,
                        //     size: 18,
                        //     color: kGrayColor,
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    ),
  );
}
