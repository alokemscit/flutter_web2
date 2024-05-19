import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/component/widget/custom_elevated_button.dart';

import 'package:web_2/modules/patient_registration/new_registration/controller/patient_registration_controller.dart';

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
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    PatRegController rController = Get.put(PatRegController());
    rController.context = context;
    return Scaffold(
      body: Obx(
        () {
          if (rController.isLoading.value) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (rController.isError.value) {
            return Text(
              rController.errorMessage.value.toString(),
              style: const TextStyle(color: Colors.red),
            );
          }
          return Responsive(
            mobile: _tablet(rController),
            tablet: _tablet(rController),
            desktop: _desktop(rController),
          );
        },
      ),
    );
  }
}

_tablet(PatRegController econtroller) {
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

_desktop(PatRegController econtroller) {
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

_leftPart(PatRegController econtroller) {
  // print("Call Again");
  // File? image;

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            econtroller.isSearch.value
                                ? CustomTextBox(
                                    //focusNode: econtroller.f_emp_id,
                                    labelTextColor: Colors.black54,
                                    // isDisable: econtroller.isDisableID.value, // true,
                                    // isReadonly: econtroller.isDisableID.value,
                                    caption: "HCN",
                                    isCapitalization: true,
                                    width: 150,
                                    maxlength: 11,
                                    height: 28,
                                    isFilled: true,
                                    controller: econtroller
                                        .txt_hcn, //econtroller.txt_emp_id,
                                    onChange: (v) {
                                      
                                      if (v.length == 11) {

                                      econtroller.LoadEmployee(v);

                                      }
                                    },
                                    onSubmitted: (p0) {
                                      //print("p0.characters");
                                    },
                                  )
                                : const SizedBox(),
                            InkWell(
                              onTap: () {
                                // econtroller.EditEmployee();
                                if (econtroller.isSearch.value) {
                                  econtroller.hid.value = 0;
                                  econtroller.SetUndo();
                                  return;
                                }
                                econtroller.isSearch.value =
                                    !econtroller.isSearch.value;
                                // context.read<PatRegBloc>().add(
                                //     PatRegSetIsSearchEvent(
                                //         isSearch: !isSearch));
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(left: 4),
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: kWebBackgroundDeepColor)),
                                  child: Icon(
                                    econtroller.isSearch.value
                                        ? Icons.undo_sharp
                                        : Icons.search,
                                    size: 18,
                                    color: kGrayColor,
                                  )),
                            ),

                               
                                econtroller.isSearch.value?InkWell(
                                  onTap: () {
                                    
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 4),
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: kWebBackgroundDeepColor)),
                                    child: const Icon(
                                      
                                          Icons.print_sharp,
                                          
                                      size: 18,
                                      color: kGrayColor,
                                    )),
                                ):SizedBox(),

                            econtroller.isSearch.value
                                ? InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 4),
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 2,
                                                blurRadius: 1,
                                                color: Colors.grey
                                                    .withOpacity(0.1))
                                          ],
                                          border: Border.all(
                                              color: kWebBackgroundDeepColor)),
                                      child: Text(
                                        "Advance Search",
                                        style: customTextStyle.copyWith(
                                            fontSize: 11),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Obx(() => Checkbox(
                                  value: econtroller.isNewBorn.value,
                                  onChanged: (onChanged) {
                                    onChanged == true
                                        ? econtroller.txt_mother_hcn.text =
                                            econtroller.txt_mother_hcn.text
                                        : econtroller.txt_mother_hcn.text = '';
                                    econtroller.isNewBorn.value = onChanged!;
                                    // context.read<PatRegBloc>().add(
                                    //     PatRegSetIsNebornEvent(
                                    //         isNewBorn: onChanged!));
                                  })),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "Is New Born",
                                style: customTextStyle,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Obx(() {
                            if (econtroller.isNewBorn.value) {
                              return CustomTextBox(
                                labelTextColor: Colors.black54,

                                caption: "Mother's HCN",
                                width: 120,
                                maxlength: 11,
                                height: 28,
                                isFilled: true,
                                controller: econtroller
                                    .txt_mother_hcn, //econtroller.txt_emp_id,
                                onChange: (v) {
                                  if (v.length == 11) {}
                                },
                                onSubmitted: (p0) {
                                  //print("p0.characters");
                                },
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                        ],
                      )
                    ],
                  ),
                  Flexible(
                    child: 
                    
                    Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      // padding:const EdgeInsets.symmetric(horizontal: 2) ,
                      height: 120,
                      width: 100,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 0,
                              child: Container(
                                  height: 120,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: kWebBackgroundDeepColor,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 1)
                                      ]),
                                  // ignore: unrelated_type_equality_checks

                                  child: Obx(() {
                                    return econtroller.imageFile.value.path !=
                                            ''
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              econtroller.imageFile.value.path,
                                              width:
                                                  100.0, // Adjust width as needed
                                              height: 100.0,
                                              fit: BoxFit
                                                  .cover, // Adjust height as needed
                                            ),
                                          )
                                        : const Icon(
                                            Icons.people_alt_sharp,
                                            size: 52,
                                            color: Colors.grey,
                                          );
                                  }))),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        kWebBackgroundColor.withOpacity(0.03),
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.13),
                                          spreadRadius: 0.5,
                                          blurRadius: 1)
                                    ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        var file = await getImage();

                                        if (file != null) {
                                          // ignore: use_build_context_synchronously

                                          econtroller.imageFile.value = file;
                                          econtroller.isImageUpdate.value =
                                              true;
                                          // var abcx = await fileToBase64(
                                          //   file.path,
                                          // );
                                          // print(abcx);

                                          // context.read<PatRegBloc>().add(
                                          //     PatRegSetImageEvent(
                                          //         image: file));
                                          //print(file.path);
                                          // econtroller.imgPath.value =
                                          //     file.path;
                                        }
                                      },
                                      child: _iconButton(
                                          Icons.upload, Colors.grey),
                                    ),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final File imageFile = File(
                                            econtroller.imageFile.value.path);

                                        await econtroller.ImageUpload();
                                      },
                                      child: _iconButton(Icons.save,
                                          kWebHeaderColor.withOpacity(0.4)),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                 
                 
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomDropDown(
                      labelTextColor: Colors.black54,
                      id: econtroller.cmb_prefix.value == ''
                          ? null
                          : econtroller.cmb_prefix.value,
                      height: 28,
                      borderRadious: 2,
                      enabledBorderColor: Colors.grey,
                      focusedBorderColor: Colors.black,
                      enabledBorderwidth: 0.4,
                      focusedBorderWidth: 0.3,
                      labeltext: "Prefix",
                      list: _getDropdownItem(econtroller,
                          "prefix"), // _getDropdownItem(econtroller, "prefix"),
                      onTap: (v) {
                        econtroller.cmb_prefix.value = v.toString();
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
                        controller:
                            econtroller.txt_name, // econtroller.txt_emp_name,
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
                        date_controller:
                            econtroller.txt_dob, // econtroller.txt_emp_dob,
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
                    child: CustomDropDown(
                        labelTextColor: Colors.black54,
                        id: econtroller.cmb_nationality.value,
                        height: 28,
                        labeltext: "Nationality",
                        list: _getDropdownItem(econtroller, "country"),
                        onTap: (v) {
                          econtroller.cmb_nationality.value = v.toString();
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
                  controller: econtroller
                      .txt_father_name, // econtroller.txt_emp_father,
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
                  controller: econtroller
                      .txt_mother_name, // econtroller.txt_emp_mother,
                  onChange: (v) {}),
              CustomTextBox(
                  labelTextColor: Colors.black54,
                  caption: "Spouse Name",
                  width: double.infinity,
                  maxlength: 100,
                  height: 28,
                  isFilled: true,
                  controller: econtroller
                      .txt_spouse_name, // econtroller.txt_emp_spouse,
                  onChange: (v) {}),
              CustomTextBox(
                  labelTextColor: Colors.black54,
                  caption: "Guardian's Name",
                  width: double.infinity,
                  maxlength: 100,
                  height: 28,
                  isFilled: true,
                  controller: econtroller
                      .txt_guardian_name, // econtroller.txt_emp_spouse,
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
                              id: econtroller.cmb_gender.value,
                              height: 28,
                              labeltext: "Gender",
                              list: _getDropdownItem(econtroller, "gender"),
                              onTap: (v) {
                                econtroller.cmb_gender.value = v.toString();
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
                          child: CustomDropDown(
                              labelTextColor: Colors.black54,
                              id: econtroller.cmb_religion.value,
                              height: 28,
                              labeltext: "Religion",
                              list: _getDropdownItem(econtroller, "religion"),
                              onTap: (v) {
                                econtroller.cmb_religion.value = v.toString();
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
                              id: econtroller.cmb_maritalstatus.value,
                              height: 28,
                              labeltext: "Marital Status",
                              list: _getDropdownItem(econtroller, "marital"),
                              onTap: (v) {
                                econtroller.cmb_maritalstatus.value =
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
                          child: CustomDropDown(
                              labelTextColor: Colors.black54,
                              id: econtroller.cmb_bloodgroup.value,
                              height: 28,
                              labeltext: "Blood Group",
                              list: _getDropdownItem(econtroller, "bloodgroup"),
                              onTap: (v) {
                                econtroller.cmb_bloodgroup.value = v.toString();
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
                          child: CustomDropDown(
                              labelTextColor: Colors.black54,
                              //identitytype
                              id: econtroller.cmb_identitytype.value,
                              height: 28,
                              labeltext: "Identity Type",
                              list:
                                  _getDropdownItem(econtroller, "identitytype"),
                              onTap: (v) {
                                econtroller.cmb_identitytype.value =
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
                              maxlength: 25,
                              isFilled: true,
                              controller: econtroller
                                  .txt_identity_number, //econtroller.txt_emp_identityname,
                              onChange: (v) {}),
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
                    child: CustomTextBox(
                        // onEditingComplete: () => FocusScope.of(Get.context!).requestFocus(econtroller.cmb_designation!),
                        labelTextColor: Colors.black54,
                        textInputType: TextInputType.phone,
                        caption: "Cell Phone",
                        width: double.infinity,
                        height: 28,
                        maxlength: 15,
                        isFilled: true,
                        controller: econtroller
                            .txt_cell_phone, //econtroller.txt_emp_identityname,
                        onChange: (v) {}),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomTextBox(
                        // onEditingComplete: () => FocusScope.of(Get.context!).requestFocus(econtroller.cmb_designation!),
                        labelTextColor: Colors.black54,
                        caption: "Home Phone",
                        width: double.infinity,
                        textInputType: TextInputType.phone,
                        height: 28,
                        maxlength: 15,
                        isFilled: true,
                        controller: econtroller
                            .txt_home_phone, //econtroller.txt_emp_identityname,
                        onChange: (v) {}),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextBox(
                        // onEditingComplete: () => FocusScope.of(Get.context!).requestFocus(econtroller.cmb_designation!),
                        labelTextColor: Colors.black54,
                        caption: "Email",
                        textInputType: TextInputType.emailAddress,
                        width: double.infinity,
                        height: 28,
                        maxlength: 100,
                        isFilled: true,
                        controller: econtroller
                            .txt_email, //econtroller.txt_emp_identityname,
                        onChange: (v) {}),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomTextBox(
                        // onEditingComplete: () => FocusScope.of(Get.context!).requestFocus(econtroller.cmb_designation!),
                        labelTextColor: Colors.black54,
                        caption: "Emergency Contact Number",
                        textInputType: TextInputType.phone,
                        width: double.infinity,
                        height: 28,
                        maxlength: 100,
                        isFilled: true,
                        controller: econtroller
                            .txt_emergency_number, //econtroller.txt_emp_identityname,
                        onChange: (v) {}),
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

_rightPart(PatRegController econtroller) {
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
        CustomCaptionForContainer("Others Information"),
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
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomDropDown(
                            labeltext: "Patient Type",
                            labelTextColor: Colors.black54,
                            id: econtroller.cmb_pat_type.value,
                            height: 28,
                            borderRadious: 2,
                            enabledBorderColor: Colors.grey,
                            focusedBorderColor: Colors.black,
                            enabledBorderwidth: 0.4,
                            focusedBorderWidth: 0.3,
                            list:
                                _getDropdownItemPat(econtroller, "patienttype"),
                            onTap: (v) {
                              econtroller.cmb_pat_type.value = v.toString();
                            },
                            width: 150),
                        const SizedBox(
                          width: 8,
                        ),
                        Obx(() {
                          return econtroller.cmb_pat_type.value == '2'
                              ? Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomTextBox(
                                          caption: "Emp ID",
                                          width: 100,
                                          maxlength: 10,
                                          height: 28,
                                          isFilled: true,
                                          controller: econtroller.txt_empid,
                                          onChange: (v) {}),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Icon(
                                        Icons.search,
                                        size: 18,
                                        color: kGrayColor,
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox();
                        }),
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
                    child: CustomDropDown(
                        labelTextColor: Colors.black54,
                        id: econtroller.cmb_corporate_company.value,
                        height: 28,
                        borderRadious: 2,
                        enabledBorderColor: Colors.grey,
                        focusedBorderColor: Colors.black,
                        enabledBorderwidth: 0.4,
                        focusedBorderWidth: 0.3,
                        labeltext: "Corporate Company",
                        list: _getDropdownItemPat(
                            econtroller, "corporatecompany"),
                        onTap: (v) {
                          econtroller.cmb_corporate_company.value =
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomDropDown(
                        labelTextColor: Colors.black54,
                        id: econtroller.cmb_pat_education.value,
                        height: 28,
                        borderRadious: 2,
                        enabledBorderColor: Colors.grey,
                        focusedBorderColor: Colors.black,
                        enabledBorderwidth: 0.4,
                        focusedBorderWidth: 0.3,
                        labeltext: "Education",
                        list: _getDropdownItemPat(
                            econtroller, "patienteducation"),
                        onTap: (v) {
                          econtroller.cmb_pat_education.value = v.toString();
                        },
                        width: 100),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomDropDown(
                        labelTextColor: Colors.black54,
                        id: econtroller.cmb_pat_occupation.value,
                        height: 28,
                        borderRadious: 2,
                        enabledBorderColor: Colors.grey,
                        focusedBorderColor: Colors.black,
                        enabledBorderwidth: 0.4,
                        focusedBorderWidth: 0.3,
                        labeltext: "Occupation",
                        list: _getDropdownItemPat(
                            econtroller, "patientoccupation"),
                        onTap: (v) {
                          econtroller.cmb_pat_occupation.value = v.toString();
                        },
                        width: 100),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomDropDown(
                        labelTextColor: Colors.black54,
                        id: econtroller.cmb_pat_income_level.value,
                        height: 28,
                        borderRadious: 2,
                        enabledBorderColor: Colors.grey,
                        focusedBorderColor: Colors.black,
                        enabledBorderwidth: 0.4,
                        focusedBorderWidth: 0.3,
                        labeltext: "Family Income Level",
                        list: _getDropdownItemPat(
                            econtroller, "patientincomelevel"),
                        onTap: (v) {
                          econtroller.cmb_pat_income_level.value = v.toString();
                        },
                        width: 100),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Container(
                  padding: EdgeInsets.zero,
                  //width: double.infinity,
                  decoration: CustomCaptionDecoration(
                    0.3,
                    Colors.black,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCaptionForContainer("Emergency  Contact  Address",
                          kWebBackgroundDeepColor, Colors.grey.shade400),
                      //const SizedBox(height: 4,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomDropDown(
                                      labelTextColor: Colors.black54,
                                      id: econtroller
                                          .cmb_emergency_country.value,
                                      height: 28,
                                      borderRadious: 2,
                                      enabledBorderColor: Colors.grey,
                                      focusedBorderColor: Colors.black,
                                      enabledBorderwidth: 0.4,
                                      focusedBorderWidth: 0.3,
                                      labeltext: "Country",
                                      list: _getDropdownItem(
                                          econtroller, "country"),
                                      onTap: (v) {
                                        econtroller.setCountryEvent(
                                            v.toString(), 'emergency');
                                      },
                                      width: 100),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomDropDown(
                                      labelTextColor: Colors.black54,
                                      id: econtroller.cmb_emergency_state.value,
                                      height: 28,
                                      borderRadious: 2,
                                      enabledBorderColor: Colors.grey,
                                      focusedBorderColor: Colors.black,
                                      enabledBorderwidth: 0.4,
                                      focusedBorderWidth: 0.3,
                                      labeltext: "State",
                                      list: econtroller.stateList_emergency
                                          .map((element) {
                                        return DropdownMenuItem<String>(
                                            value: element.id,
                                            child: Text(element.name!));
                                      }).toList(),
                                      onTap: (v) {
                                        econtroller.setSateEvent(
                                            v.toString(), 'emergency');
                                        // econtroller.cmb_emergency_state.value =
                                        //     v.toString();
                                        // econtroller.districtList_emergency
                                        //     .clear();
                                        // econtroller
                                        //     .cmb_emergency_district.value = '';
                                        // econtroller.getDistrict(
                                        //     econtroller
                                        //         .cmb_emergency_country.value,
                                        //     v.toString(),
                                        //     "emergency");
                                      },
                                      width: 100),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomDropDown(
                                      labelTextColor: Colors.black54,
                                      id: econtroller
                                          .cmb_emergency_district.value,
                                      height: 28,
                                      borderRadious: 2,
                                      enabledBorderColor: Colors.grey,
                                      focusedBorderColor: Colors.black,
                                      enabledBorderwidth: 0.4,
                                      focusedBorderWidth: 0.3,
                                      labeltext: "District",
                                      list: econtroller.districtList_emergency
                                          .map((element) {
                                        return DropdownMenuItem<String>(
                                          value: element.id,
                                          child: Text(element.name!),
                                        );
                                      }).toList(),
                                      onTap: (v) {
                                        econtroller.cmb_emergency_district
                                            .value = v.toString();
                                      },
                                      width: 100),
                                ),
                              ],
                            ),
                            CustomTextBox(
                                labelTextColor: Colors.black54,
                                caption: "Address",
                                width: double.infinity,
                                textInputType: TextInputType.multiline,
                                isFilled: true,
                                maxLine: 4,
                                borderRadious: 2,
                                enabledBorderColor: Colors.grey,
                                focusedBorderColor: Colors.black,
                                enabledBorderwidth: 0.4,
                                focusedBorderWidth: 0.3,
                                maxlength: 250,
                                height: 70,
                                controller: econtroller.txt_emergency_address,
                                onChange: (v) {}),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Container(
                  //width: double.infinity,
                  decoration: CustomCaptionDecoration(
                    0.3,
                    Colors.black,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCaptionForContainer("Present  Address",
                          kWebBackgroundDeepColor, Colors.grey.shade400),
                      //const SizedBox(height: 4,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomDropDown(
                                      labelTextColor: Colors.black54,
                                      id: econtroller.cmb_present_country.value,
                                      labeltext: "Country",
                                      list: _getDropdownItem(
                                          econtroller, "country"),
                                      onTap: (v) {
                                        econtroller.setCountryEvent(
                                            v.toString(), 'present');
                                      },
                                      width: 100),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomDropDown(
                                      labelTextColor: Colors.black54,
                                      id: econtroller.cmb_present_state.value,
                                      labeltext: "State",
                                      list: econtroller.stateList_Present
                                          .map((element) {
                                        return DropdownMenuItem<String>(
                                            value: element.id,
                                            child: Text(element.name!));
                                      }).toList(),
                                      onTap: (v) {
                                        econtroller.setSateEvent(
                                            v.toString(), 'present');
                                      },
                                      width: 100),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomDropDown(
                                      labelTextColor: Colors.black54,
                                      id: econtroller
                                          .cmb_present_district.value,
                                      labeltext: "District",
                                      list: econtroller.districtList_Present
                                          .map((element) {
                                        return DropdownMenuItem<String>(
                                          value: element.id,
                                          child: Text(element.name!),
                                        );
                                      }).toList(),
                                      onTap: (v) {
                                        econtroller.cmb_present_district.value =
                                            v.toString();
                                      },
                                      width: 100),
                                ),
                              ],
                            ),
                            CustomTextBox(
                                labelTextColor: Colors.black54,
                                caption: "Address",
                                width: double.infinity,
                                textInputType: TextInputType.multiline,
                                isFilled: true,
                                maxLine: 250,

                                // maxlength: 250,
                                height: 70,
                                controller: econtroller.txt_present_address,
                                onChange: (v) {}),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Container(
                  //width: double.infinity,
                  decoration: CustomCaptionDecoration(
                    0.3,
                    Colors.black,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCaptionForContainer("Permanent  Address",
                          kWebBackgroundDeepColor, Colors.grey.shade400),
                      //const SizedBox(height: 4,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Obx(() => Checkbox(
                                    value: econtroller
                                        .isSameAsPresentAddress.value,
                                    onChanged: (t) {
                                      econtroller.isSameAsPresentAddress.value =
                                          t!;
                                      econtroller.setPermanentPresentSame(t);
                                    })),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Same as Present Address",
                                  style: customTextStyle,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomDropDown(
                                      labelTextColor: Colors.black54,
                                      id: econtroller
                                          .cmb_permanent_country.value,
                                      height: 28,
                                      borderRadious: 2,
                                      enabledBorderColor: Colors.grey,
                                      focusedBorderColor: Colors.black,
                                      enabledBorderwidth: 0.4,
                                      focusedBorderWidth: 0.3,
                                      labeltext: "Country",
                                      list: _getDropdownItem(
                                          econtroller, "country"),
                                      onTap: (v) {
                                        econtroller.setCountryEvent(
                                            v.toString(), 'permanent');
                                      },
                                      width: 100),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomDropDown(
                                      labelTextColor: Colors.black54,
                                      id: econtroller.cmb_permanent_state.value,
                                      height: 28,
                                      borderRadious: 2,
                                      enabledBorderColor: Colors.grey,
                                      focusedBorderColor: Colors.black,
                                      enabledBorderwidth: 0.4,
                                      focusedBorderWidth: 0.3,
                                      labeltext: "State",
                                      list: econtroller.stateList_permanent
                                          .map((element) {
                                        return DropdownMenuItem<String>(
                                            value: element.id,
                                            child: Text(element.name!));
                                      }).toList(),
                                      onTap: (v) {
                                        econtroller.setSateEvent(
                                            v.toString(), 'permanent');
                                      },
                                      width: 100),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomDropDown(
                                      labelTextColor: Colors.black54,
                                      id: econtroller
                                          .cmb_permanent_district.value,
                                      height: 28,
                                      borderRadious: 2,
                                      enabledBorderColor: Colors.grey,
                                      focusedBorderColor: Colors.black,
                                      enabledBorderwidth: 0.4,
                                      focusedBorderWidth: 0.3,
                                      labeltext: "District",
                                      list: econtroller.districtList_permanent
                                          .map((element) {
                                        return DropdownMenuItem<String>(
                                          value: element.id,
                                          child: Text(element.name!),
                                        );
                                      }).toList(),
                                      onTap: (v) {
                                        econtroller.cmb_permanent_district
                                            .value = v.toString();
                                      },
                                      width: 100),
                                ),
                              ],
                            ),
                            CustomTextBox(
                                labelTextColor: Colors.black54,
                                caption: "Address",
                                width: double.infinity,
                                textInputType: TextInputType.multiline,
                                isFilled: true,
                                maxLine: 4,
                                borderRadious: 2,
                                maxlength: 250,
                                enabledBorderColor: Colors.grey,
                                focusedBorderColor: Colors.black,
                                enabledBorderwidth: 0.4,
                                focusedBorderWidth: 0.3,
                                // maxlength: 250,
                                height: 70,
                                controller: econtroller.txt_permanent_address,
                                onChange: (v) {}),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomElevatedButton(
                    child: const Text("Undo"),
                    onTap: () {
                      econtroller.SetUndo();
                    },
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  CustomElevatedButton(
                    style: customButtonStyle,
                    child: const Text("Save"),
                    onTap: () {
                      econtroller.Save();
                    },
                  ),
                ],
              )
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

_getDropdownItemPat(PatRegController econtroller, String tag) =>
    econtroller.plist.where((p0) => p0.tp == tag && p0.status == '1').map((e) {
      return DropdownMenuItem<String>(
        value: e.id,
        child: Text(e.name!),
      );
    }).toList();

_getDropdownItem(PatRegController econtroller, String tag) =>
    econtroller.elist.where((p0) => p0.tp == tag && p0.status == '1').map((e) {
      return DropdownMenuItem<String>(
        value: e.id,
        child: Text(e.name!),
      );
    }).toList();

_iconButton(IconData icon, Color color) => Container(
    decoration: BoxDecoration(
        color: kBgDarkColor.withOpacity(1),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
          )
        ]),
    child: Padding(
      padding: const EdgeInsets.all(4),
      child: Icon(
        icon,
        size: 20,
        color: color,
      ),
    ));


// abstract class PatRegState {}

// class PatRegInitialState extends PatRegState {}

// class PatRegGetImageState extends PatRegState {
//   final File image;
//   PatRegGetImageState({required this.image});
// }

// class PatRegIsNebornState extends PatRegState {
//   final bool isNewBorn;
//   PatRegIsNebornState({required this.isNewBorn});
// }

// class PatRegSetIsSearchState extends PatRegState {
//   final bool isSearch;
//   PatRegSetIsSearchState({required this.isSearch});
// }

// abstract class PatRegEvent {}

// class PatRegSetImageEvent extends PatRegEvent {
//   final File image;
//   PatRegSetImageEvent({required this.image});
// }

// class PatRegSetIsNebornEvent extends PatRegEvent {
//   final bool isNewBorn;
//   PatRegSetIsNebornEvent({required this.isNewBorn});
// }

// class PatRegSetIsSearchEvent extends PatRegEvent {
//   final bool isSearch;
//   PatRegSetIsSearchEvent({required this.isSearch});
// }

// class PatRegBloc extends Bloc<PatRegEvent, PatRegState> {
//   PatRegBloc() : super(PatRegInitialState()) {
//     on<PatRegSetImageEvent>((event, emit) {
//       emit(PatRegGetImageState(image: event.image));
//     });
//     on<PatRegSetIsNebornEvent>((event, emit) {
//       emit(PatRegIsNebornState(isNewBorn: event.isNewBorn));
//     });
//     on<PatRegSetIsSearchEvent>((event, emit) {
//       emit(PatRegSetIsSearchState(isSearch: event.isSearch));
//     });
//   }
// }
