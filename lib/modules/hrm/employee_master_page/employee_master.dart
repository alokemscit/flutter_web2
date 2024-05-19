// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/functions.dart';

import 'package:web_2/component/widget/custom_container.dart';
import 'package:web_2/component/widget/custom_datepicker.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_elevated_button.dart';
import 'package:web_2/component/widget/custom_group_container.dart';
import 'package:web_2/component/widget/custom_icon_button.dart';
import 'package:web_2/component/widget/custom_textbox.dart';
import 'package:web_2/component/widget/custom_widget_list.dart';

import 'package:web_2/modules/hrm/employee_master_page/widget/controller/employee_controller.dart';

import '../../../component/widget/menubutton.dart';

//Responsive(mobile: _mobile(), tablet: _desktopTab(), desktop: _desktopTab()),

class EmployeeMaster extends StatelessWidget {
  const EmployeeMaster({super.key});

  void disposeController() {
    try {
      Get.delete<EmployeeController>();
    } catch (e) {
      //print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final EmployeeController econtroller =
        Get.put(EmployeeController(context: context));
    // econtroller.context = context;
    return BlocProvider(
      create: (context) => EmployeeBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => CustomCommonBody(
            econtroller.isLoading.value,
            econtroller.isError.value,
            econtroller.errorMessage.value,
            _mobile(context, econtroller),
            _desktopTab(context, econtroller),
            _desktopTab(context, econtroller))),
      ),
    );
  }
}

_mobile(BuildContext context, EmployeeController econtroller) =>
    SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _leftPart(econtroller, context),
              _rightPart(context, econtroller, true),
            ],
          ),
          height(4),
          const _TabContainer(),
          const _TabBody(),
        ],
      ),
    );

class _TabBody extends StatelessWidget {
  const _TabBody({super.key});

  @override
  Widget build(BuildContext context) {
    int? index;
    return Container(
      width: double.infinity,
      decoration: BoxDecorationTopRounded.copyWith(color: kWebBackgroundColor),
      //height: 400,
      child: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeSetTabTextState) {
            index = state.index;
          }
          return index != null ? _widget[index!] : const SizedBox();
        },
      ),
    );
  }
}

_desktopTab(BuildContext context, EmployeeController econtroller,
        [bool isMob = false]) =>
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: _leftPart(econtroller, context),
                ),
                width(),
                Expanded(
                  flex: 5,
                  child: _rightPart(context, econtroller, isMob),
                ),
              ],
            ),
            height(),
            const _TabContainer(),
            const _TabBody(),
          ],
        ),
      ),
    );

class _TabContainer extends StatelessWidget {
  const _TabContainer();

  @override
  Widget build(BuildContext context) {
    String? name;
    return Container(
      padding: const EdgeInsets.only(top: 8),
      decoration:
          const BoxDecoration(color: kWebBackgroundDeepColor, boxShadow: [
        BoxShadow(
          color: Colors.white,
          blurRadius: 5.5,
          spreadRadius: 1.1,
        )
      ]),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              BlocBuilder<EmployeeBloc, EmployeeState>(
                builder: (context, state) {
                  if (state is EmployeeSetTabTextState) {
                    name = state.text;
                  }
                  return Wrap(
                    spacing: 1,
                    children: _data
                        .map(
                          (item) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.2),
                            child: MenuButton(
                                borderRadius: 2,
                                color: name == item
                                    ? Colors.white
                                    : kWebHeaderColor.withOpacity(0.13),
                                isCrossButton: false,
                                text: item,
                                buttonClick: () {
                                  BlocProvider.of<EmployeeBloc>(context).add(
                                      EmployeeSetTabTextEvent(
                                          text: item,
                                          index: _data.indexOf(item)));
                                },
                                crossButtonClick: () {},
                                isSelected: false,
                                textColor: name != item
                                    ? Colors.black
                                    : const Color.fromARGB(255, 0, 48, 87)),
                          ),

                          //)
                        )
                        .toList(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<dynamic> _data = [
  //"Photo",
  "Reporting Authority",
  "Address",
  "Leave Info",
  "Employeement History",
  "Academic History"
];

List<Widget> _widget = [
  //_photoPart(),
  _Reporting_supervisor(),
  _Address(),
  CustomTextBox(
      labelTextColor: Colors.black54,
      caption: "Leave Info",
      controller: TextEditingController(),
      onChange: (v) {}),
  CustomTextBox(
      labelTextColor: Colors.black54,
      caption: "Employeement History",
      controller: TextEditingController(),
      onChange: (v) {}),
  CustomTextBox(
      labelTextColor: Colors.black54,
      caption: "Academic History",
      controller: TextEditingController(),
      onChange: (v) {}),
];

_Address() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 5,
                child: CustomContainer(
                    label: "Present Address",
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
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
                                        id: null,
                                        height: 32,
                                        labeltext: "District",
                                        list: const [],
                                        onTap: (v) {},
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
                                        id: null,
                                        height: 32,
                                        labeltext: "Thana",
                                        list: const [],
                                        onTap: (v) {},
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
                        CustomTextBox(
                            labelTextColor: Colors.black54,
                            caption: "Notes",
                            width: double.infinity,
                            textInputType: TextInputType.multiline,
                            isFilled: true,
                            maxLine: 4,
                            maxlength: 500,
                            height: 116,
                            controller: TextEditingController(),
                            onChange: (v) {}),
                      ],
                    ))),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                flex: 5,
                child: CustomContainer(
                  label: "Present Address",
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (v) {},
                          ),
                          const Text("Same as Permanent")
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
                                      id: null,
                                      height: 32,
                                      labeltext: "District",
                                      list: const [],
                                      onTap: (v) {},
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
                                      id: null,
                                      height: 32,
                                      labeltext: "Thana",
                                      list: const [],
                                      onTap: (v) {},
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
                      CustomTextBox(
                          labelTextColor: Colors.black54,
                          caption: "Notes",
                          width: double.infinity,
                          textInputType: TextInputType.multiline,
                          isFilled: true,
                          maxLine: 4,
                          maxlength: 500,
                          height: 116,
                          controller: TextEditingController(),
                          onChange: (v) {}),
                    ],
                  ),
                ))
          ],
        )
      ],
    ),
  );
}

_Reporting_supervisor() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomDropDown(
                labelTextColor: Colors.black54,
                id: null,
                height: 33,
                labeltext: "Report to",
                list: const [],
                onTap: (v) {},
                width: 100),
            const SizedBox(
              width: 8,
            ),
            CustomTextBox(
                labelTextColor: Colors.black54,
                width: 120,
                caption: "Emp ID",
                isFilled: true,
                controller: TextEditingController(),
                onChange: (v) {}),
            const SizedBox(
              width: 8,
            ),
            CustomDatePicker(
              width: 140,
              date_controller: TextEditingController(),
              label: "Active From",
              bgColor: Colors.white,
              height: 32,
              isBackDate: true,
            ),
            const SizedBox(
              width: 8,
            ),
            CustomDatePicker(
              width: 140,
              date_controller: TextEditingController(),
              label: "Active Till",
              bgColor: Colors.white,
              height: 32,
              isBackDate: true,
            ),
            const SizedBox(
              width: 8,
            ),
            CustomIconButton(
              caption: "Save",
              icon: Icons.save,
              onTap: () {},
              bgColor: kBgDarkColor,
            )
          ],
        )
      ],
    ),
  );
}

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

_image_container(EmployeeController econtroller) => Container(
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
                    return econtroller.imageFile.value.path != ''
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              econtroller.imageFile.value.path,
                              width: 100.0, // Adjust width as needed
                              height: 100.0,
                              fit: BoxFit.cover, // Adjust height as needed
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
                    color: kWebBackgroundColor.withOpacity(0.03),
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
                          econtroller.isImageUpdate.value = true;
                        }
                      },
                      child: _iconButton(Icons.upload, Colors.grey),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    InkWell(
                      onTap: () async {
                        final File imageFile =
                            File(econtroller.imageFile.value.path);

                        await econtroller.ImageUpload();
                      },
                      child: _iconButton(
                          Icons.save, kWebHeaderColor.withOpacity(0.4)),
                    )
                  ],
                ),
              ))
        ],
      ),
    );

_leftPart(EmployeeController econtroller, BuildContext context) {
  return CustomGroupContainer("General Information", [
    height(),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            !econtroller.isDisableID.value
                ? CustomTextBox(
                    focusNode: econtroller.f_emp_id,
                    labelTextColor: Colors.black54,
                    isDisable: econtroller.isDisableID.value, // true,
                    isReadonly: econtroller.isDisableID.value,
                    caption: "ID",
                    width: 110,
                    maxlength: 10,
                    height: 28,
                    isFilled: true,
                    controller: econtroller.txt_emp_id,
                    onChange: (v) {},
                    onSubmitted: (p0) {
                      //print("p0.characters");
                    },
                  )
                : const SizedBox(),
            InkWell(
              onTap: () {
                econtroller.EditEmployee();
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(color: kWebBackgroundDeepColor)),
                child: Icon(
                  econtroller.isDisableID.value ? Icons.edit : Icons.undo_sharp,
                  size: 18,
                  color: kGrayColor,
                ),
              ),
            ),
            width(4),
            !econtroller.isDisableID.value
                ? InkWell(
                    onTap: () {
                      econtroller.advabceSearch();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.search,
                        size: 18,
                        color: kWebHeaderColor,
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
        _image_container(econtroller),
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
            list: _getDropdownItem(econtroller, "prefix"),
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
              controller: econtroller.txt_emp_name,
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
              date_controller: econtroller.txt_emp_dob,
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
        focusNode: econtroller.f_emp_father,
        caption: "Father's Name",
        width: double.infinity,
        height: 28,
        maxlength: 100,
        isFilled: true,
        controller: econtroller.txt_emp_father,
        onEditingComplete: () {
          print("on onEditingComplete");
          //print('object');
          FocusScope.of(Get.context!).requestFocus(econtroller.f_emp_mother);
          //FocusScopeNode currentFocusScope = FocusScope.of(Get.context!);
          //currentFocusScope.requestFocus(econtroller.f_emp_mother);
        },
        onSubmitted: (p0) {
          print("on submir");
          FocusScope.of(Get.context!).requestFocus(econtroller.f_emp_mother);
        },
        onChange: (v) {
          print("on change");
        }),
    CustomTextBox(
        focusNode: econtroller.f_emp_mother,
        labelTextColor: Colors.black54,
        caption: "Mother's name",
        width: double.infinity,
        maxlength: 100,
        height: 28,
        isFilled: true,
        controller: econtroller.txt_emp_mother,
        onChange: (v) {}),
    CustomTextBox(
        labelTextColor: Colors.black54,
        caption: "Spouse Name",
        width: double.infinity,
        maxlength: 100,
        height: 28,
        isFilled: true,
        controller: econtroller.txt_emp_spouse,
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
                      econtroller.cmb_maritalstatus.value = v.toString();
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
                    list: _getDropdownItem(econtroller, "identitytype"),
                    onTap: (v) {
                      econtroller.cmb_identitytype.value = v.toString();
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
                    controller: econtroller.txt_emp_identityname,
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
    height(),
  ]);
}

_getDropdownItem(EmployeeController econtroller, String tag) =>
    econtroller.elist.where((p0) => p0.tp == tag && p0.status == '1').map((e) {
      return DropdownMenuItem<String>(
        value: e.id,
        child: Text(e.name!),
      );
    }).toList();

_rightPart(BuildContext context, EmployeeController econtroller, bool isMob) =>
    CustomGroupContainer("General Official Information", [
      isMob ? height(8) : height(130),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Obx(() => CustomTextBox(
                  labelTextColor: Colors.black54,
                  isFilled: true,
                  height: 28,
                  isDisable: true,
                  width: double.infinity,
                  caption: 'Company',
                  controller: TextEditingController(
                      text: econtroller.companyName.value),
                  onChange: (String value) {},
                )),
          ),
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
                      id: econtroller.cmb_designation.value,
                      height: 28,
                      labeltext: "Designation",
                      list: _getDropdownItem(econtroller, "designation"),
                      onTap: (v) {
                        econtroller.cmb_designation.value = v.toString();
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
                      id: econtroller.cmb_grade.value,
                      height: 28,
                      labeltext: "Grade",
                      list: _getDropdownItem(econtroller, "grade"),
                      onTap: (v) {
                        econtroller.cmb_grade.value = v.toString();
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
                      id: econtroller.cmb_department_category.value,
                      height: 28,
                      labeltext: "Department Category",
                      list: _getDropdownItem(econtroller, "departmentcategory"),
                      onTap: (v) {
                        econtroller.cmb_department_category.value =
                            v.toString();
                        econtroller.cmb_department.value = '';
                        econtroller.getDeoartment();
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
          width(),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomDropDown(
                      labelTextColor: Colors.black54,
                      id: econtroller.cmb_department.value,
                      height: 28,
                      labeltext: "Department",
                      list: econtroller.department_list
                          .map((element) => DropdownMenuItem<String>(
                              value: element.id, child: Text(element.name!)))
                          .toList(),
                      onTap: (v) {
                        econtroller.cmb_section.value = '';
                        econtroller.cmb_department.value = v.toString();
                        econtroller.getSection();
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
                      id: econtroller.cmb_section.value,
                      height: 28,
                      labeltext: "Unit/Section",
                      list: econtroller.section_list
                          .map((element) => DropdownMenuItem<String>(
                                value: element.id,
                                child: Text(element.name!),
                              ))
                          .toList(),
                      onTap: (v) {
                        econtroller.cmb_section.value = v.toString();
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
          width(),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomDropDown(
                      labelTextColor: Colors.black54,
                      id: econtroller.cmb_emptype.value,
                      height: 28,
                      labeltext: "Type of Employeement",
                      list: _getDropdownItem(econtroller, "employementtype"),
                      onTap: (v) {
                        econtroller.cmb_emptype.value = v.toString();
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
                  child: CustomDatePicker(
                    labelTextColor: Colors.black54,
                    date_controller: econtroller.txt_emp_doj,
                    isFilled: true,
                    label: "Date of Join",
                    bgColor: Colors.white,
                    height: 28,
                    isBackDate: true,
                  ),
                ),
                const SizedBox(
                  width: 18,
                )
              ],
            ),
          ),
          width(),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomDropDown(
                      labelTextColor: Colors.black54,
                      id: econtroller.cmb_jobstatus.value,
                      height: 28,
                      labeltext: "Current Job Staus",
                      list: _getDropdownItem(econtroller, "jobstatus"),
                      onTap: (v) {
                        econtroller.cmb_jobstatus.value = v.toString();
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
      CustomTextBox(
          labelTextColor: Colors.black54,
          caption: "Notes",
          width: double.infinity,
          textInputType: TextInputType.multiline,
          isFilled: true,
          maxLine: 4,
          // maxlength: 250,
          height: 70,
          controller: econtroller.txt_emp_note,
          onChange: (v) {}),
      height(5),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.withOpacity(0.5),
                foregroundColor: Colors.white),
            child: const Text("Undo"),
            onTap: () {
              //  print(econtroller.companyName.value);

              econtroller.Undo();
            },
          ),
          width(12),
          CustomElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: kWebHeaderColor,
                foregroundColor: Colors.white),
            child: const Text("Save"),
            onTap: () {
              //  print(econtroller.companyName.value);
              econtroller.SaveData();
            },
          ),
        ],
      ),
      height(5),
    ]);

abstract class EmployeeState {}

class EmployeeInitState extends EmployeeState {}

class EmployeeSetImageState extends EmployeeState {
  final File image;
  EmployeeSetImageState({required this.image});
}

class EmployeeSetTabTextState extends EmployeeState {
  final int index;
  final String text;
  EmployeeSetTabTextState({required this.index, required this.text});
}

abstract class EmployeeEvent {}

class EmployeeSetImageEvent extends EmployeeEvent {
  final File image;
  EmployeeSetImageEvent({required this.image});
}

class EmployeeSetTabTextEvent extends EmployeeEvent {
  final int index;
  final String text;
  EmployeeSetTabTextEvent({required this.index, required this.text});
}

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitState()) {
    on<EmployeeSetImageEvent>((event, emit) {
      emit(EmployeeSetImageState(image: event.image));
    });
    on<EmployeeSetTabTextEvent>((event, emit) {
      print(event.index);
      emit(EmployeeSetTabTextState(text: event.text, index: event.index));
    });
  }
}
