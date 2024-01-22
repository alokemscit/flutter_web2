// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/component/widget/custom_container.dart';
import 'package:web_2/component/widget/custom_datepicker.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_elevated_button.dart';
import 'package:web_2/component/widget/custom_icon_button.dart';
import 'package:web_2/component/widget/custom_textbox.dart';
import 'package:web_2/pages/hrm/employee_master_page/widget/controller/employee_controller.dart';

import '../../../component/widget/menubutton.dart';

//Responsive(mobile: _mobile(), tablet: _desktopTab(), desktop: _desktopTab()),

class EmployeeMaster extends StatelessWidget {
  const EmployeeMaster({super.key});

  @override
  Widget build(BuildContext context) {
    //final EmployeeController econtroller = EmployeeController();
    final EmployeeController econtroller = Get.put(EmployeeController());
    
    print("Call Widget");
    //List<ModelMasterEmpTable> list = [];
    // print(MediaQuery.of(context).size.width.toString());
    return BlocProvider(
      create: (context) => EmployeeBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(top: 4, left: 4),
          // child: _mobile()
          child: Obx(() {
            if (econtroller.isLoading.value) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (econtroller.isError.value) {
              return Text(
                econtroller.errorMessage.value.toString(),
                style: const TextStyle(color: Colors.red),
              );
            }
            // list = econtroller.elist;
            // print(list);
            return Responsive(
              mobile: _mobile(context, econtroller),
              tablet: _desktopTab(context, econtroller),
              desktop: _desktopTab(context, econtroller),
            );
          }),
        ),
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
              _leftPart(econtroller),
              _middlePart(context, econtroller),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          const _TabContainer(),
          const _TabBody(),
          // const Expanded(
          //   child: SingleChildScrollView(
          //       child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 12),
          //     child: _TabBody(),
          //   )),
          // )
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
      decoration: BoxDecorationTopRounded.copyWith(color: kBgLightColor),
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

_desktopTab(BuildContext context, EmployeeController econtroller) =>
    SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: _leftPart(econtroller),
              ),
              Expanded(
                flex: 5,
                child: _middlePart(context, econtroller),
              ),
            ],
          ),

          const SizedBox(
            height: 4,
          ),
          const _TabContainer(),
          // const Expanded(
          //   child: SingleChildScrollView(
          //       child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 12),
          //     child: _TabBody(),
          //   )),
          // )
          _TabBody(),
        ],
      ),
    );

class _TabContainer extends StatelessWidget {
  const _TabContainer();

  @override
  Widget build(BuildContext context) {
    String? name;
    return Container(
      decoration:
          BoxDecoration(color: kBgDarkColor.withOpacity(0.5), boxShadow: const [
        BoxShadow(
          color: Colors.white,
          blurRadius: 0.5,
          spreadRadius: 3.1,
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
                          (item) => MenuButton(
                              color: name == item ? Colors.white : kBgDarkColor,
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
  "Photo",
  "Reporting Authority",
  "Address",
  "Leave Info",
  "Employeement History",
  "Academic History"
];

List<Widget> _widget = [
  _photoPart(),
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

_photoPart() => const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: _RoghtPart(), //_rightPart(context, _image),
    );

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

_leftPart(EmployeeController econtroller) {
  print("Call Again");
  String? pid, countryId, genderId, religionId, maritalId, bgId, identityId;
  final TextEditingController txt_emp_name = TextEditingController();
  return Container(
    decoration:
        BoxDecorationTopRounded.copyWith(color: kWebBackgroundDeepColor),
    // height: 200,
    //  color: Colors.amber,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                "Basic Information:",
                style: customTextStyle.copyWith(
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    decorationColor: kWebHeaderColor,
                    color: kWebHeaderColor),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => CustomTextBox(
                      labelTextColor: Colors.black54,
                      isDisable: econtroller.isDisableID.value, // true,
                      isReadonly: econtroller.isDisableID.value,
                      caption: "ID",
                      width: 100,
                      maxlength: 10,
                      isFilled: true,
                      controller: TextEditingController(),
                      onChange: (v) {},
                      onSubmitted: (p0) {
                        //print("p0.characters");
                      },
                    )),
                InkWell(
                  onTap: () {
                    econtroller.setEnableDisableID();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        border: Border.all(color: kWebBackgroundDeepColor)),
                    child: Obx(() => Icon(
                          econtroller.isDisableID.value
                              ? Icons.edit
                              : Icons.undo,
                          size: 18,
                          color: kGrayColor,
                        )),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => CustomDropDown(
                    labelTextColor: Colors.black54,
                    id: pid,
                    height: 32,
                    labeltext: "Prefix",
                    list: _getDropdownItem(econtroller, "prefix"),
                    onTap: (v) {},
                    width: 100)),
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
                      width: double.infinity,
                      maxlength: 100,
                      isFilled: true,
                      controller: txt_emp_name,
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
                    date_controller: TextEditingController(),
                    isFilled: true,
                    label: "Date of Birth",
                    bgColor: Colors.white,
                    height: 32,
                    isBackDate: true,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 5,
                  child: Obx(() => CustomDropDown(
                      labelTextColor: Colors.black54,
                      id: countryId,
                      height: 32,
                      labeltext: "Nationality",
                      list: _getDropdownItem(econtroller, "country"),
                      onTap: (v) {},
                      width: 100)),
                ),
              ],
            ),
            CustomTextBox(
                labelTextColor: Colors.black54,
                caption: "Father's Name",
                width: double.infinity,
                maxlength: 100,
                isFilled: true,
                controller: TextEditingController(),
                onChange: (v) {}),
            CustomTextBox(
                labelTextColor: Colors.black54,
                caption: "Mother's name",
                width: double.infinity,
                maxlength: 100,
                isFilled: true,
                controller: TextEditingController(),
                onChange: (v) {}),
            CustomTextBox(
                labelTextColor: Colors.black54,
                caption: "Spouse Name",
                width: double.infinity,
                maxlength: 100,
                isFilled: true,
                controller: TextEditingController(),
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
                            id: genderId,
                            height: 32,
                            labeltext: "Gender",
                            list: _getDropdownItem(econtroller, "gender"),
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
                            id: religionId,
                            height: 32,
                            labeltext: "Religion",
                            list: _getDropdownItem(econtroller, "religion"),
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
                            id: maritalId,
                            height: 32,
                            labeltext: "Marital Status",
                            list: _getDropdownItem(econtroller, "marital"),
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
                            id: bgId,
                            height: 32,
                            labeltext: "Blood Group",
                            list: _getDropdownItem(econtroller, "bloodgroup"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Obx(() => CustomDropDown(
                      labelTextColor: Colors.black54,
                      //identitytype
                      id: identityId,
                      height: 32,
                      labeltext: "Identity Type",
                      list: _getDropdownItem(econtroller, "identitytype"),
                      onTap: (v) {},
                      width: 100)),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 5,
                  child: CustomTextBox(
                      labelTextColor: Colors.black54,
                      caption: "Identity Number",
                      width: double.infinity,
                      maxlength: 100,
                      isFilled: true,
                      controller: TextEditingController(),
                      onChange: (v) {}),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

_getDropdownItem(EmployeeController econtroller, String tag) =>
    econtroller.elist.where((p0) => p0.tp == tag && p0.status == '1').map((e) {
      return DropdownMenuItem<String>(
        value: e.id,
        child: Text(e.name!),
      );
    }).toList();

_middlePart(BuildContext context, EmployeeController econtroller) {
  String? dpId, desigId;
  return Container(
    decoration:
        BoxDecorationTopRounded.copyWith(color: kWebBackgroundDeepColor),
    // height: 200,
    //  color: Colors.amber,
    child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 4, vertical:  8  ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal:  8  ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 4, bottom:   8  ),
              child: Text(
                "General Official Information:",
                style: customTextStyle.copyWith(
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    decorationColor: kWebHeaderColor,
                    color: kWebHeaderColor),
              ),
            ),
            SizedBox(
              height:  38 ,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomDropDown(
                      labelTextColor: Colors.black54,
                      id: null,
                      height: 32,
                      labeltext: "Company",
                      list: const [],
                      onTap: (v) {},
                      width: double.infinity),
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
                            id: desigId,
                            height: 32,
                            labeltext: "Designation",
                            list: _getDropdownItem(econtroller, "designation"),
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
                            labeltext: "Grade",
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
                            id: dpId,
                            height: 32,
                            labeltext: "Department",
                            list: _getDropdownItem(econtroller, "department"),
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
                            labeltext: "Unit/Section",
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
                            id: null,
                            height: 32,
                            labeltext: "Type of Employeement",
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
                            labeltext: "Current Job Status",
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
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomDatePicker(
                          labelTextColor: Colors.black54,
                          date_controller: TextEditingController(),
                          isFilled: true,
                          label: "Date of Join",
                          bgColor: Colors.white,
                          height: 32,
                          isBackDate: true,
                        ),
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
                            labeltext: "Current Job Status",
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
                maxLine: 3,
                // maxlength: 250,
                height: 70,
                controller: TextEditingController(),
                onChange: (v) {}),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomElevatedButton(
                  child: Text("Save"),
                  onTap: () {
                    econtroller.SaveData();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    ),
  );
}

Future<File> _getImage() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    return File(pickedImage.path);
  } else {
    return File(''); // or return File(); for an empty file
  }
}

class _RoghtPart extends StatelessWidget {
  const _RoghtPart({super.key});
  @override
  Widget build(BuildContext context) {
    File? image;
    return Container(
      decoration: BoxDecorationTopRounded,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, top: 8),
            child: Text(
              "Profile Photo:",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline),
            ),
          ),
          const SizedBox(
            height: 48,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<EmployeeBloc, EmployeeState>(
                  builder: (context, state) {
                    return Container(
                      width: 160,
                      height: 180,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: image == null || image!.path == ""
                          ? const SizedBox()
                          : kIsWeb
                              ? Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Image.network(
                                    image!.path,
                                    width: 300.0, // Adjust width as needed
                                    height: 300.0,
                                    fit:
                                        BoxFit.cover, // Adjust height as needed
                                  ),
                                )
                              : Image.file(image!),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () async {
                        image = await _getImage();
                        //  print(_image!.path!);
                        if (image != null) {
                          BlocProvider.of<EmployeeBloc>(context)
                              .add(EmployeeSetImageEvent(image: image!));
                        }
                      },
                      child: const Text(
                        "browse image",
                        style: TextStyle(
                            color: Colors.blue,
                            fontStyle: FontStyle.italic,
                            fontSize: 13),
                      )),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 102,
          )
        ],
      ),
    );
  }
}

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
