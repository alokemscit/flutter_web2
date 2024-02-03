import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/functions.dart';
import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_search_box.dart';
import 'package:web_2/component/widget/custom_textbox.dart';
import 'package:web_2/pages/opd/doctor_setup/doctor_opd_setup_controller.dart';

class DoctorOPDSetuo extends StatelessWidget {
  const DoctorOPDSetuo({super.key});
  void disposeController() {
    try {
      Get.delete<DoctorOPDsetupController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    DoctorOPDsetupController dcontroller = Get.put(DoctorOPDsetupController());
    return Scaffold(
      body: Obx(
        () {
          if (dcontroller.isLoading.value) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (dcontroller.isError.value) {
            return Text(
              dcontroller.errorMessage.value.toString(),
              style: const TextStyle(color: Colors.red),
            );
          }
          return Responsive(
            mobile: _tablet(dcontroller),
            tablet: _tablet(dcontroller),
            desktop: _desktop(dcontroller),
          );
        },
      ),
    );
  }
}

_leftPart(DoctorOPDsetupController econtroller) {
  return Container(
    //decoration:customBoxDecoration.copyWith(color: kWebBackgroundDeepColor),
    decoration: CustomCaptionDecoration(),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCaptionForContainer("Departmental Information"),
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
              children: [
                Expanded(child: CustomSearchBox(
                   borderRadious: 2,
                                    enabledBorderColor: Colors.grey,
                                    focusedBorderColor: Colors.black,
                                    enabledBorderwidth: 0.4,
                                    focusedBorderWidth: 0.3,
                  
                  caption: "Search Doctor", maxlength: 100, controller: TextEditingController(), onChange: (onChange){})),
              ],
            ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomDropDown(
                            labeltext: "Job Category",
                            labelTextColor: Colors.black54,
                            id: null, // econtroller.cmb_pat_type.value,
                            height: 28,
                            borderRadious: 2,
                            enabledBorderColor: Colors.grey,
                            focusedBorderColor: Colors.black,
                            enabledBorderwidth: 0.4,
                            focusedBorderWidth: 0.3,
                            list: [],
                            //_getDropdownItemPat(econtroller, "patienttype"),
                            onTap: (value) {}, width: 150,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: CustomDropDown(
                          labeltext: "Department",
                          labelTextColor: Colors.black54,
                          id: null, // econtroller.cmb_pat_type.value,
                          height: 28,
                          borderRadious: 2,
                          enabledBorderColor: Colors.grey,
                          focusedBorderColor: Colors.black,
                          enabledBorderwidth: 0.4,
                          focusedBorderWidth: 0.3,
                          list: [],
                          //_getDropdownItemPat(econtroller, "patienttype"),
                          onTap: (value) {}, width: 150,
                        ))
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomDropDown(
                            labeltext: "Section",
                            labelTextColor: Colors.black54,
                            id: null, // econtroller.cmb_pat_type.value,
                            height: 28,
                            borderRadious: 2,
                            enabledBorderColor: Colors.grey,
                            focusedBorderColor: Colors.black,
                            enabledBorderwidth: 0.4,
                            focusedBorderWidth: 0.3,
                            list: [],
                            //_getDropdownItemPat(econtroller, "patienttype"),
                            onTap: (value) {}, width: 150,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: CustomDropDown(
                          labeltext: "Doctor Name",
                          labelTextColor: Colors.black54,
                          id: null, // econtroller.cmb_pat_type.value,
                          height: 28,
                          borderRadious: 2,
                          enabledBorderColor: Colors.grey,
                          focusedBorderColor: Colors.black,
                          enabledBorderwidth: 0.4,
                          focusedBorderWidth: 0.3,
                          list: [],
                          //_getDropdownItemPat(econtroller, "patienttype"),
                          onTap: (value) {}, width: 150,
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

_rightPart(DoctorOPDsetupController econtroller) {
  return Container(
    //decoration:customBoxDecoration.copyWith(color: kWebBackgroundDeepColor),
    decoration: CustomCaptionDecoration(),
    // height: 200,
    //  color: Colors.amber,

    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCaptionForContainer("Fees Information"),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             

             Container(
                padding: EdgeInsets.zero,
                //width: double.infinity,
                decoration: CustomCaptionDecoration(
                  0.3,
                  Colors.black,
                ),
                child: Column(
                  children: [
                    CustomCaptionForContainer("Visiting setup details",
                        kWebBackgroundDeepColor, Colors.grey.shade400),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomTextBox(
                                    labelTextColor: Colors.black54,
                                    height: 28,
                                    borderRadious: 2,
                                    enabledBorderColor: Colors.grey,
                                    focusedBorderColor: Colors.black,
                                    enabledBorderwidth: 0.4,
                                    focusedBorderWidth: 0.3,
                                    caption: 'Cycle',
                                    controller: TextEditingController(),
                                    onChange: (String value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomTextBox(
                                  
                                    caption: 'Avg Time/Patient',
                                    controller: TextEditingController(),
                                    onChange: (String value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomTextBox(
                                    labelTextColor: Colors.black54,
                                    height: 28,
                                    borderRadious: 2,
                                    enabledBorderColor: Colors.grey,
                                    focusedBorderColor: Colors.black,
                                    enabledBorderwidth: 0.4,
                                    focusedBorderWidth: 0.3,
                                    caption: 'Max visit/day',
                                    controller: TextEditingController(),
                                    onChange: (String value) {},
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                 
                 
                  ],
                ),
              ),

             Container(
                padding: EdgeInsets.zero,
                //width: double.infinity,
                decoration: CustomCaptionDecoration(
                  0.3,
                  Colors.black,
                ),
                child: Column(
                  children: [
                    CustomCaptionForContainer("Visiting feed details",
                        kWebBackgroundDeepColor, Colors.grey.shade400),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomTextBox(
                                    labelTextColor: Colors.black54,
                                    height: 28,
                                    borderRadious: 2,
                                    enabledBorderColor: Colors.grey,
                                    focusedBorderColor: Colors.black,
                                    enabledBorderwidth: 0.4,
                                    focusedBorderWidth: 0.3,
                                    caption: 'First Visit Fees',
                                    controller: TextEditingController(),
                                    onChange: (String value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomTextBox(
                                    labelTextColor: Colors.black54,
                                    height: 28,
                                    borderRadious: 2,
                                    enabledBorderColor: Colors.grey,
                                    focusedBorderColor: Colors.black,
                                    enabledBorderwidth: 0.4,
                                    focusedBorderWidth: 0.3,
                                    caption: 'Second Visit Fees',
                                    controller: TextEditingController(),
                                    onChange: (String value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomTextBox(
                                    labelTextColor: Colors.black54,
                                    height: 28,
                                    borderRadious: 2,
                                    enabledBorderColor: Colors.grey,
                                    focusedBorderColor: Colors.black,
                                    enabledBorderwidth: 0.4,
                                    focusedBorderWidth: 0.3,
                                    caption: 'Report Visit Fees',
                                    controller: TextEditingController(),
                                    onChange: (String value) {},
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                 
                 
                  ],
                ),
              ),

             Container(
                padding: EdgeInsets.zero,
                //width: double.infinity,
                decoration: CustomCaptionDecoration(
                  0.3,
                  Colors.black,
                ),
                child: Column(
                  children: [
                    CustomCaptionForContainer("Doctor Accounting (FFS)",
                        kWebBackgroundDeepColor, Colors.grey.shade400),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomTextBox(
                                    labelTextColor: Colors.black54,
                                    height: 28,
                                    borderRadious: 2,
                                    enabledBorderColor: Colors.grey,
                                    focusedBorderColor: Colors.black,
                                    enabledBorderwidth: 0.4,
                                    focusedBorderWidth: 0.3,
                                    caption: 'First Visit Fees',
                                    controller: TextEditingController(),
                                    onChange: (String value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomTextBox(
                                    labelTextColor: Colors.black54,
                                    height: 28,
                                    borderRadious: 2,
                                    enabledBorderColor: Colors.grey,
                                    focusedBorderColor: Colors.black,
                                    enabledBorderwidth: 0.4,
                                    focusedBorderWidth: 0.3,
                                    caption: 'Second Visit Fees',
                                    controller: TextEditingController(),
                                    onChange: (String value) {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomTextBox(
                                    labelTextColor: Colors.black54,
                                    height: 28,
                                    borderRadious: 2,
                                    enabledBorderColor: Colors.grey,
                                    focusedBorderColor: Colors.black,
                                    enabledBorderwidth: 0.4,
                                    focusedBorderWidth: 0.3,
                                    caption: 'Report Visit Fees',
                                    controller: TextEditingController(),
                                    onChange: (String value) {},
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                 
                 
                  ],
                ),
              ),


            ],
          ),
        ),
      ],
    ),
  );
}

_tablet(DoctorOPDsetupController econtroller) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: LayoutBuilder(builder: (context, constraints) {
        // print('TAB'+constraints.maxWidth.toString());
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            constraints.maxWidth > 900
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _leftPart(econtroller),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: _rightPart(econtroller),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _leftPart(econtroller),
                      const SizedBox(
                        height: 8,
                      ),
                      _rightPart(econtroller),
                    ],
                  )
          ],
        );
      }),
    ),
  );
}

_desktop(DoctorOPDsetupController econtroller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _leftPart(econtroller),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: _rightPart(econtroller),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
