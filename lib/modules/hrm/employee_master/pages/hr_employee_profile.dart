// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../../core/config/const.dart';

import '../controller/hr_employee_profile_controller.dart';

class EmployeeProfile extends StatelessWidget implements MyInterface {
  const EmployeeProfile({super.key});
  @override
  void disposeController() {
    //  print('Called----');
    mdisposeController<HrEmployeeProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    // MyWidget _w = MyWidget();
    final HrEmployeeProfileController controller =
        Get.put(HrEmployeeProfileController());
    controller.context = context;
    print(context.width);
    print(context.height);
    double screenWidth = context.width;
    double screenHeight = context.height;
    double aspectRatio = 16 / 9;

    // Calculate widget height based on aspect ratio and screen width
    double widgetHeight = screenWidth / aspectRatio;
    widgetHeight =
        widgetHeight > screenHeight ? screenHeight * 0.8 : widgetHeight;
    return Obx(() => CommonBodyWithToolBar(
            controller,
            [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //  Obx(() => CustomTooBar(controller.list_tool)),
                      _empSearch(controller),
                      CustomGroupBox(
                        // bgColor: Colors.white,
                        child: Wrap(
                          children: [
                            _generalInfo(controller),
                            12.widthBox,
                            _officialPanel(controller),
                          ],
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: controller.context.width < 500
                              ? controller.context.height * .60
                              : (controller.context.height > 950
                                      ? controller.context.height
                                      : controller.context.height - 100) *
                                  0.600, // Set a suitable height
                        ),
                        child: _tabPanel(controller),
                      ),
                    ],
                  ),
                ),
              )
            ],
            controller.list_tool, (e) {
          if (ToolMenuSet.file == e) {
            
             mToolEnableDisable(controller.list_tool, [ToolMenuSet.undo],[ToolMenuSet.file]);
            
            
          }
          if (ToolMenuSet.undo == e) {
            
             mToolEnableDisable(controller.list_tool, [ToolMenuSet.file],[ToolMenuSet.undo]);
            
            
          }
        }, Colors.white));
  }
}

Widget _tabPanel(HrEmployeeProfileController controller) => CustomGroupBox(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...controller.list_tab.map((f) => CustomTabWithCheckBox(
                  text: f.name!,
                  isCheck: controller.checkedID.value == f.id ? true : false,
                  fun: () {
                    controller.checkedID.value = f.id!;
                  }))
            ],
          ),
        ),
        _tab(controller.checkedID.value, controller)
      ],
    ));

Widget _empSearch(HrEmployeeProfileController controller) => CustomGroupBox(
    borderWidth: 1.5,
    // bgColor: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Row(
        children: [
          MyWidget().TextBox
            ..width = 100
            ..controller = TextEditingController()
            ..caption = 'Emp. No'
            ..onChange = (v) {
              print(v);
            },

          //myWidget().textBox..o
          // mGetWidget(WidgetType.textbox, params: {
          //   'controller': TextEditingController(),
          //   'inputType':TextInputType.number,
          //   'onChange': (v) {

          //   }
          // }),
          // CustomTextBox(
          //     width: 100,R
          //     caption: 'Emp ID',
          //     controller: TextEditingController()),
          4.widthBox,
          MyWidget().ButtonRound
            ..iconColor = appColorBlue
            ..icon = Icons.search
            ..bgColor = Colors.transparent
            ..iconSize = 24
            ..onTap = () {
              print('Click');
            }
          // CustomRoundedButton(
          //     iconColor: appColorBlue,
          //     icon: Icons.search,
          //     bgColor: Colors.transparent,
          //     iconSize: 24,
          //     onTap: () {}),
        ],
      ),
    ));

Widget _officialPanel(HrEmployeeProfileController controller) => SizedBox(
      width: 580,
      child: Column(
        children: [
          CustomGroupBox(
              borderWidth: 1.3,
              groupHeaderText: 'Official Info',
              // bgColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    24.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: MyWidget().DropDown
                              ..labeltext = 'Department Type'
                              ..id = controller.cmb_department_category.value
                              ..list = controller.getList('departmentcategory')
                              ..onTap = (v) {
                                controller.cmb_section.value = '';
                                controller.cmb_department.value = '';
                                controller.cmb_department_category.value = v!;
                              }

                            // CustomDropDown2(
                            //     labeltext: 'Department Type',
                            //     id: controller.cmb_department_category.value,
                            //     list: controller.getList('departmentcategory'),
                            //     onTap: (v) {
                            //       controller.cmb_section.value = '';
                            //       controller.cmb_department.value = '';
                            //       controller.cmb_department_category.value = v!;
                            //       // controller.setDepartmentType(v!);
                            //     }),
                            ),
                        8.widthBox,
                        Expanded(
                            child: CustomDropDown2(
                                labeltext: 'Department',
                                id: controller.cmb_department.value,
                                list: controller.list_department
                                    .where((e) =>
                                        e.catId ==
                                            controller.cmb_department_category
                                                .value &&
                                        e.status == '1')
                                    .toList(),
                                onTap: (v) {
                                  //print(v!);
                                  controller.cmb_section.value = '';
                                  controller.cmb_department.value = '';
                                  controller.cmb_department.value = v!;
                                })),
                        8.widthBox,
                        Expanded(
                          child: CustomDropDown2(
                              labeltext: 'Unit/Section',
                              id: controller.cmb_section.value,
                              list: controller.list_unit
                                  .where((e) =>
                                      e.depId ==
                                          controller.cmb_department.value &&
                                      e.status == '1')
                                  .toList(),
                              onTap: (v) {
                                controller.cmb_section.value = v!;
                              }),
                        ),
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropDown2(
                              labeltext: 'Corporate Designation',
                              id: controller.cmb_corp_designation.value,
                              list: controller.getList('corpdesignation'),
                              onTap: (v) {
                                controller.cmb_designation.value = '';
                                controller.cmb_corp_designation.value = v!;
                              }),
                        ),
                        8.widthBox,
                        Expanded(
                          child: CustomDropDown2(
                              labeltext: 'Designation',
                              id: controller.cmb_designation.value,
                              list: controller.list_designation_master
                                  .where((e) =>
                                      e.corpDesigId.toString() ==
                                          controller
                                              .cmb_corp_designation.value &&
                                      e.status == 1)
                                  .toList(),
                              onTap: (v) {
                                controller.cmb_designation.value = v!;
                              }),
                        ),
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: CustomDropDown2(
                                labeltext: 'Grade',
                                id: controller.cmb_grade.value,
                                list: controller.getList('grade'),
                                onTap: (v) {
                                  controller.cmb_grade.value = v!;
                                })),
                        8.widthBox,
                        Expanded(
                            child: CustomDropDown2(
                                labeltext: 'Employment Type',
                                id: controller.cmb_emptype.value,
                                list: controller.getList('employementtype'),
                                onTap: (v) {
                                  controller.cmb_emptype.value = v!;
                                })),
                      ],
                    ),
                    8.heightBox,
                    _multiWidgetPanel(
                        controller.context.width,
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: CustomDatePickerDropDown(
                                    label: 'Date of Join',
                                    labelFontSize: 11,
                                    width: 120,
                                    textfontSize: 11.3,
                                    date_controller: controller.txt_doj),
                              ),
                              8.widthBox,
                              Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    Checkbox(
                                        value: controller.isContactEnd.value,
                                        onChanged: (v) {
                                          controller.isContactEnd.value = v!;
                                          if (!v) {
                                            controller
                                                .txt_contact_end_date.text = '';
                                          }
                                        }),
                                    Expanded(
                                      child: !controller.isContactEnd.value
                                          ? Text(
                                              'Is Contract End Date',
                                              style: customTextStyle.copyWith(
                                                  fontSize: 10),
                                            )
                                          : CustomDatePickerDropDown(
                                              label: 'Contract End Date',
                                              width: 120,
                                              textfontSize: 11.3,
                                              date_controller: controller
                                                  .txt_contact_end_date),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                  value: controller.isProbation.value,
                                  onChanged: (v) {
                                    controller.isProbation.value = v!;
                                    if (!v) {
                                      controller.txt_probation_duration.text =
                                          '';
                                      controller.cmb_probation_duration.value =
                                          '';
                                    }
                                  }),
                              Text(
                                'Is In Probation',
                                style: customTextStyle.copyWith(fontSize: 10),
                              ),
                              8.widthBox,
                              !controller.isProbation.value
                                  ? const SizedBox()
                                  : Expanded(
                                      child: Row(
                                        children: [
                                          CustomTextBox(
                                              caption: '',
                                              textInputType:
                                                  TextInputType.phone,
                                              textAlign: TextAlign.center,
                                              maxlength: 3,
                                              width: 40,
                                              controller: controller
                                                  .txt_probation_duration),
                                          Expanded(
                                            child: CustomDropDown2(
                                                labeltext: 'Duration',
                                                id: controller
                                                    .cmb_probation_duration
                                                    .value,
                                                list: controller.list_duration,
                                                onTap: (v) {
                                                  controller
                                                      .cmb_probation_duration
                                                      .value = v!;
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        )),
                    8.heightBox,
                    _multiWidgetPanel(
                        controller.context.width,
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: CustomDatePickerDropDown(
                                    label: 'Date of Confirmation',
                                    width: 120,
                                    textfontSize: 11.3,
                                    date_controller: TextEditingController()),
                              ),
                              8.widthBox,
                              Expanded(
                                  flex: 5,
                                  child: CustomDropDown2(
                                      labeltext: 'Current Job Status',
                                      id: controller.cmb_jobstatus.value,
                                      list: controller.getList('jobstatus'),
                                      onTap: (v) {
                                        controller.cmb_jobstatus.value = v!;
                                      }))
                            ],
                          ),
                        ),
                        Expanded(
                            child: Row(
                          children: [
                            Expanded(
                              child: CustomDropDown2(
                                  labeltext: 'Blood Group',
                                  id: controller.cmb_bloodgroup.value,
                                  list: controller.getList('bloodgroup'),
                                  onTap: (v) {}),
                            ),
                            8.widthBox,
                            Expanded(
                              child: CustomDropDown2(
                                  labeltext: 'Medical Status',
                                  id: controller.cmb_medical_status.value,
                                  list: controller.getList('medicalstatus'),
                                  onTap: (v) {
                                    controller.cmb_medical_status.value = v!;
                                  }),
                            )
                          ],
                        ))),
                    12.heightBox,
                  ],
                ),
              )),
        ],
      ),
    );

Widget _multiWidgetPanel(double width, Widget w1, Widget w2) => width < 600
    ? Column(
        children: [
          Row(
            children: [
              w1,
            ],
          ),
          8.heightBox,
          Row(
            children: [
              w2,
            ],
          )
        ],
      )
    : Row(
        children: [w1, 8.widthBox, w2],
      );

Widget _generalInfo(HrEmployeeProfileController controller) => SizedBox(
      width: 580,
      child: Column(
        children: [
          CustomGroupBox(
              borderWidth: 1.3,
              // bgColor: Colors.white,
              groupHeaderText: 'General Information',
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    24.heightBox,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _imageBox(controller),
                        16.widthBox,
                        Expanded(
                          child: Column(
                            children: [
                              _responsive2(
                                  controller.context.width,
                                  CustomDropDown2(
                                      width: 120,
                                      labeltext: 'Prefix',
                                      id: controller.cmb_prefix.value,
                                      list: controller.getList('prefix'),
                                      onTap: (v) {}),
                                  CustomTextBox(
                                      //  isFilled: true,

                                      fillColor: const Color.fromARGB(
                                              255, 252, 254, 255)
                                          .withOpacity(0.1),
                                      caption: 'First Name',
                                      controller: controller.txt_first_name)),
                              8.heightBox,
                              _responsive2(
                                  controller.context.width,
                                  CustomTextBox(
                                      fillColor: Colors.white,
                                      caption: 'Middle Name',
                                      controller: controller.txt_middle_name),
                                  CustomTextBox(
                                      fillColor: Colors.white,
                                      caption: 'Last Name',
                                      controller: controller.txt_last_name),
                                  true),
                              8.heightBox,
                              Row(
                                children: [
                                  CustomDatePickerDropDown(
                                      width: 120,
                                      label: 'D.O.B',
                                      textfontSize: 12,
                                      date_controller: controller.txt_dob),
                                  8.widthBox,
                                  Expanded(
                                      child: CustomDropDown2(
                                          labeltext: 'Nationality',
                                          id: controller.cmb_nationality.value,
                                          list: controller.getList('country'),
                                          onTap: (v) {
                                            controller.cmb_nationality.value =
                                                v!;
                                          })),
                                ],
                              ),
                              8.heightBox,
                              _responsive3(
                                  controller.context.width,
                                  CustomDropDown2(
                                      width: 120,
                                      labeltext: 'Gender',
                                      id: controller.cmb_gender.value,
                                      list: controller.getList('gender'),
                                      onTap: (v) {
                                        controller.cmb_gender.value = v!;
                                      }),
                                  CustomDropDown2(
                                      width: 120,
                                      labeltext: 'Religion',
                                      id: controller.cmb_religion.value,
                                      list: controller.getList('religion'),
                                      onTap: (v) {
                                        controller.cmb_religion.value = v!;
                                      }),
                                  CustomDropDown2(
                                      width: 120,
                                      labeltext: 'Marital Status',
                                      id: controller.cmb_maritalstatus.value,
                                      list: controller.getList('marital'),
                                      onTap: (v) {
                                        controller.cmb_maritalstatus.value = v!;
                                      })),
                              8.heightBox,
                              Row(
                                children: [
                                  CustomDropDown2(
                                      width: 120,
                                      labeltext: 'Identity Type',
                                      id: controller.cmb_identitytype.value,
                                      list: controller.getList('identitytype'),
                                      onTap: (v) {
                                        controller.cmb_identitytype.value = v!;
                                      }),
                                  8.widthBox,
                                  Expanded(
                                      child: CustomTextBox(
                                          caption: "Identity No",
                                          controller:
                                              controller.txt_identity_no)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    16.heightBox,
                  ],
                ),
              )),
        ],
      ),
    );

Widget _responsive2(double width, Widget widget1, Widget widget2,
        [bool isAllExpanded = false]) =>
    width < 451
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isAllExpanded
                  ? Row(
                      children: [
                        Expanded(child: widget1),
                      ],
                    )
                  : widget1,
              8.heightBox,
              Row(
                children: [
                  Expanded(child: widget2),
                ],
              )
            ],
          )
        : Row(
            children: [
              isAllExpanded ? Expanded(child: widget1) : widget1,
              8.widthBox,
              Expanded(child: widget2)
            ],
          );

_responsive3(double width, Widget widget1, Widget widget2, Widget widget3) =>
    width < 451
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: widget1),
                ],
              ),
              8.heightBox,
              Row(
                children: [
                  Expanded(child: widget2),
                ],
              ),
              8.heightBox,
              Row(
                children: [
                  Expanded(child: widget3),
                ],
              ),
            ],
          )
        : Row(
            children: [
              widget1,
              8.widthBox,
              widget2,
              8.widthBox,
              Expanded(child: widget3)
            ],
          );

_imageBox(HrEmployeeProfileController controller) => Column(
      children: [
        Obx(() {
          return Container(
              height: 120,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                  border: Border.all(
                      color: appColorGrayDark.withOpacity(0.6), width: 0.5)),
              child: controller.imageFile.value.path != ''
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        controller.imageFile.value.path,
                        width: 120.0, // Adjust width as needed
                        height: 100.0,
                        fit: BoxFit.cover, // Adjust height as needed
                      ),
                    )
                  : const Icon(
                      Icons.people_alt_sharp,
                      size: 52,
                      color: Colors.grey,
                    ));
        }),
        4.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                var file = await getImage();

                controller.imageFile.value = file;
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.upload,
                    size: 14,
                    color: appColorLogoDeep,
                  ),
                  Text(
                    'Browse Image',
                    style: customTextStyle.copyWith(
                        color: appColorMint, fontSize: 11),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );

Widget __responsive(double width, Widget w1, Widget w2,
        [bool isExpandedW1 = false]) =>
    width > 1200
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [isExpandedW1 ? Expanded(child: w1) : w1, 8.widthBox, w2],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [w1, 2.heightBox, w2],
          );

Widget _qualificationTab(HrEmployeeProfileController controller) =>
    _common('Qualification History', [
      CustomButtonIconText(
          text: 'Add New Qualification',
          onTap: () {
            print('aa');
          }),
      8.heightBox,
      Expanded(
        child: CustomTableGenerator(colWidtList: const [
          30,
          50,
          50,
          30,
          30,
          25,
          20
        ], childrenHeader: [
          CustomTableColumnHeaderBlack('Gegree'),
          CustomTableColumnHeaderBlack('Institute'),
          CustomTableColumnHeaderBlack('Main Subject'),
          CustomTableColumnHeaderBlack('Passing Year'),
          CustomTableColumnHeaderBlack('Result'),
          CustomTableColumnHeaderBlack('Is Verified'),
          CustomTableColumnHeaderBlack('*', Alignment.center),
        ], childrenTableRowList: []),
      )
    ]);

Widget _addressTab(HrEmployeeProfileController controller) =>
    _common('Address Info', [
      Expanded(
        child: __responsive(
            controller.context.width,
            CustomGroupBox(
                groupHeaderText: 'Present Address::',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: CustomTextBox(
                                  maxlength: 500,
                                  caption: 'Address1',
                                  controller:
                                      controller.mAddress.value.address1_pre!)),
                        ],
                      ),
                      8.heightBox,
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextBox(
                                  maxlength: 500,
                                  caption: 'Address1',
                                  controller:
                                      controller.mAddress.value.address2_pre!)),
                        ],
                      ),
                      8.heightBox,
                      Row(
                        children: [
                          Expanded(
                              child: CustomDropDown2(
                                  labeltext: 'Country',
                                  id: controller.mAddress.value.country_pre,
                                  list: controller.getList('country'),
                                  onTap: (v) {
                                    controller.mAddress.value.country_pre = v!;
                                    controller.mAddress.refresh();
                                  })),
                          8.widthBox,
                          Expanded(
                              child: CustomTextBox(
                                  fillColor: Colors.lightBlue[100]!,
                                  caption: 'City',
                                  controller:
                                      controller.mAddress.value.city_pre!)),
                        ],
                      ),
                      8.heightBox,
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextBox(
                                  caption: 'Mobile',
                                  maxlength: 25,
                                  textInputType: TextInputType.phone,
                                  controller:
                                      controller.mAddress.value.mobile_pre!)),
                          8.widthBox,
                          Expanded(
                              child: CustomTextBox(
                                  caption: 'Email',
                                  maxlength: 50,
                                  textInputType: TextInputType.emailAddress,
                                  controller:
                                      controller.mAddress.value.email_pre!)),
                        ],
                      ),
                    ],
                  ),
                )),
            Expanded(
              child: SingleChildScrollView(
                child: CustomGroupBox(
                    groupHeaderText: 'Permanent Address::',
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: CustomTextBox(
                                      caption: 'Address1',
                                      maxlength: 500,
                                      controller: controller
                                          .mAddress.value.address1_per!)),
                            ],
                          ),
                          8.heightBox,
                          Row(
                            children: [
                              Expanded(
                                  child: CustomTextBox(
                                      caption: 'Address1',
                                      maxlength: 500,
                                      controller: controller
                                          .mAddress.value.address2_per!)),
                            ],
                          ),
                          8.heightBox,
                          Row(
                            children: [
                              Expanded(
                                child: CustomDropDown2(
                                    labeltext: 'Country',
                                    id: controller.mAddress.value.country_per,
                                    list: controller.getList('country'),
                                    onTap: (v) {
                                      controller.mAddress.value.country_per =
                                          v!;
                                      controller.mAddress.refresh();
                                    }),
                              ),
                              8.widthBox,
                              Expanded(
                                  child: CustomTextBox(
                                      caption: 'City',
                                      maxlength: 150,
                                      controller:
                                          controller.mAddress.value.city_per!))
                            ],
                          ),
                          8.heightBox,
                          Row(
                            children: [
                              Expanded(
                                  child: CustomTextBox(
                                      caption: 'Mobile',
                                      maxlength: 25,
                                      textInputType: TextInputType.phone,
                                      controller: controller
                                          .mAddress.value.mobile_per!)),
                              8.widthBox,
                              Expanded(
                                  child: CustomTextBox(
                                      maxlength: 50,
                                      textInputType: TextInputType.emailAddress,
                                      caption: 'Email',
                                      controller: controller
                                          .mAddress.value.email_per!)),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            true),
      ),
    ]);

Widget _employmentTab(HrEmployeeProfileController controller) =>
    _common('Employment History', [
      CustomButtonIconText(
          text: 'Add New Emp History',
          onTap: () {
            print('aa');
          }),
      8.heightBox,
      Expanded(
        child: CustomTableGenerator(colWidtList: const [
          30,
          30,
          80,
          50,
          50,
          25
        ], childrenHeader: [
          CustomTableColumnHeaderBlack('Start Date'),
          CustomTableColumnHeaderBlack('End Date'),
          CustomTableColumnHeaderBlack('Organization Name'),
          CustomTableColumnHeaderBlack('Department'),
          CustomTableColumnHeaderBlack('Designation'),
          CustomTableColumnHeaderBlack('*', Alignment.center),
        ], childrenTableRowList: []),
      ),
    ]);

Widget _leaveTab(HrEmployeeProfileController controller) =>
    _common('Leave Info', [
      8.heightBox,
      Row(
        children: [
          Flexible(
              child: CustomDropDown2(
            id: null,
            list: [],
            onTap: (v) {},
            width: 450,
          ))
        ],
      ),
      8.heightBox,
      Expanded(
        child: CustomTableGenerator(colWidtList: const [
          60,
          30,
          30,
          30
        ], childrenHeader: [
          CustomTableColumnHeaderBlack('Leave Type'),
          CustomTableColumnHeaderBlack('Entitled'),
          CustomTableColumnHeaderBlack('Availed'),
          CustomTableColumnHeaderBlack('Balance'),
        ], childrenTableRowList: []),
      ),
    ]);

Widget _common(String header, List<Widget> children) => Expanded(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: CustomGroupBox(
                borderWidth: 2,
                groupHeaderText: header,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...children,
                    ],
                  ),
                )))
      ],
    ));

Widget _selparation(HrEmployeeProfileController controller) =>
    _common('Separation Info', [
      __responsive(
        controller.context.width,
        SizedBox(
            width: 460,
            child: CustomGroupBox(
                groupHeaderText: 'Separation Info',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomTextHeaderWithCaptinAndWidget(
                          capWidth: 150,
                          caption: 'Resignation Submit Date',
                          child: CustomDatePickerDropDown(
                              date_controller: controller
                                  .mSeparation.value.reg_submit_date!)),
                      8.heightBox,
                      CustomTextHeaderWithCaptinAndWidget(
                          capWidth: 150,
                          caption: 'Last Working Date',
                          child: CustomDatePickerDropDown(
                              date_controller: controller
                                  .mSeparation.value.last_work_date!)),
                      8.heightBox,
                      CustomTextHeaderWithCaptinAndWidget(
                          capWidth: 150,
                          caption: 'Reason for Separation',
                          child: Expanded(
                              child: CustomTextBox(
                                  maxLine: 3,
                                  height: 55,
                                  maxlength: 500,
                                  textInputType: TextInputType.multiline,
                                  caption: '',
                                  controller: controller.mSeparation.value
                                      .reason_of_separation!)))
                    ],
                  ),
                ))),
        SizedBox(
            width: 460,
            child: CustomGroupBox(
                groupHeaderText: 'Exit Interview Info',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomTextHeaderWithCaptinAndWidget(
                          capWidth: 150,
                          caption: 'Exit interview Date',
                          child: CustomDatePickerDropDown(
                              date_controller: controller
                                  .mSeparation.value.exit_interview_date!)),
                      8.heightBox,
                      CustomTextHeaderWithCaptinAndWidget(
                          capWidth: 150,
                          caption: 'Separation Date',
                          child: CustomDatePickerDropDown(
                              date_controller: controller
                                  .mSeparation.value.separation_date!)),
                      8.heightBox,
                      CustomTextHeaderWithCaptinAndWidget(
                          capWidth: 150,
                          caption: 'Exit Interview Note',
                          child: Expanded(
                              child: CustomTextBox(
                                  maxLine: 3,
                                  height: 55,
                                  maxlength: 500,
                                  textInputType: TextInputType.multiline,
                                  caption: '',
                                  controller:
                                      controller.mSeparation.value.exit_note!)))
                    ],
                  ),
                ))),
      )
    ]);

Widget _dependants(HrEmployeeProfileController controller) =>
    _common('Dependants Info', [
      CustomButtonIconText(
          text: 'Add New Dependant',
          onTap: () {
            print('aa');
          }),
      8.heightBox,
      Expanded(
        child: CustomTableGenerator(colWidtList: const [
          60,
          35,
          30,
          30,
          30,
          40,
          20
        ], childrenHeader: [
          CustomTableColumnHeaderBlack('Depndant Name'),
          CustomTableColumnHeaderBlack('Date of Birth'),
          CustomTableColumnHeaderBlack('Sex'),
          CustomTableColumnHeaderBlack('Relation'),
          CustomTableColumnHeaderBlack('Type'),
          CustomTableColumnHeaderBlack('Nominee Share %'),
          CustomTableColumnHeaderBlack('*', Alignment.center),
        ], childrenTableRowList: []),
      ),
    ]);

Widget _training(HrEmployeeProfileController controller) =>
    _common('Training History', [
      CustomButtonIconText(
          text: 'Add New Training Record',
          onTap: () {
            print('aa');
          }),
      8.heightBox,
      Expanded(
        child: CustomTableGenerator(colWidtList: const [
          60,
          35,
          30,
          30,
          40,
          20
        ], childrenHeader: [
          CustomTableColumnHeaderBlack('Name of the Program'),
          CustomTableColumnHeaderBlack('Major Area'),
          CustomTableColumnHeaderBlack('From'),
          CustomTableColumnHeaderBlack('To'),
          CustomTableColumnHeaderBlack('Duratin(Days)'),
          CustomTableColumnHeaderBlack('*', Alignment.center),
        ], childrenTableRowList: []),
      ),
    ]);

Widget _misconduct(HrEmployeeProfileController controller) =>
    _common('Misconduct History', [
      CustomButtonIconText(
          text: 'Add New Misconduct',
          onTap: () {
            print('aa');
          }),
      8.heightBox,
      Expanded(
        child: CustomTableGenerator(colWidtList: const [
          80,
          40,
          40,
          40,
          20
        ], childrenHeader: [
          CustomTableColumnHeaderBlack('Description'),
          CustomTableColumnHeaderBlack('Reason'),
          CustomTableColumnHeaderBlack('Warning Date'),
          CustomTableColumnHeaderBlack('Effective Date'),
          CustomTableColumnHeaderBlack('*', Alignment.center),
        ], childrenTableRowList: []),
      ),
    ]);
Widget _adtiotional(HrEmployeeProfileController controller) =>
    _common('Addiotional info', [
      Expanded(
        child: __responsive(
            controller.context.width,
            CustomGroupBox(
                groupHeaderText: 'Personal Information',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextHeaderWithCaptinAndWidget(
                          capWidth: 120,
                          caption: "Father's Name",
                          child: Expanded(
                              child: CustomTextBox(
                                  caption: '',
                                  controller: TextEditingController()))),
                      8.heightBox,
                      CustomTextHeaderWithCaptinAndWidget(
                          capWidth: 120,
                          caption: "Mothrs's Name",
                          child: Expanded(
                              child: CustomTextBox(
                                  caption: '',
                                  controller: TextEditingController()))),
                      8.heightBox,
                      CustomTextHeaderWithCaptinAndWidget(
                          capWidth: 120,
                          caption: "Country of Birth",
                          child: Flexible(
                              child: CustomDropDown2(
                                  width: 300,
                                  id: null,
                                  list: [],
                                  onTap: (v) {}))),
                      8.heightBox,
                      CustomTextHeaderWithCaptinAndWidget(
                          capWidth: 120,
                          caption: "Place of Birth",
                          child: Expanded(
                              child: CustomTextBox(
                                  caption: '',
                                  controller: TextEditingController()))),
                      8.heightBox,
                      CustomTextHeaderWithCaptinAndWidget(
                          capWidth: 120,
                          caption: "Marriage Date",
                          child: Expanded(
                              child: Row(
                            children: [
                              Checkbox(value: false, onChanged: (v) {}),
                              Flexible(
                                  child: CustomDatePickerDropDown(
                                      width: 120,
                                      date_controller: TextEditingController()))
                            ],
                          ))),
                      8.heightBox,
                      CustomTextHeaderWithCaptinAndWidget(
                          capWidth: 120,
                          caption: "Spouse Name",
                          child: Expanded(
                              child: CustomTextBox(
                                  caption: '',
                                  controller: TextEditingController()))),
                      8.heightBox,
                      CustomTextHeaderWithCaptinAndWidget(
                          capWidth: 120,
                          caption: "Emergency Contact Person",
                          child: Expanded(
                              child: CustomTextBox(
                                  caption: '',
                                  controller: TextEditingController()))),
                      8.heightBox,
                      CustomTextHeaderWithCaptinAndWidget(
                          capWidth: 120,
                          caption: "Relation With Contact Person",
                          child: Expanded(
                              child: CustomTextBox(
                                  caption: '',
                                  controller: TextEditingController()))),
                    ],
                  ),
                )),
            Expanded(
              child: SingleChildScrollView(
                child: CustomGroupBox(
                    groupHeaderText: 'Referance Info',
                    child: Column(
                      children: [
                        CustomGroupBox(
                          groupHeaderText: 'Reference(1)Info',
                          child: Column(
                            children: [
                              CustomTextHeaderWithCaptinAndWidget(
                                  capWidth: 150,
                                  caption: "Name of Referee (2)",
                                  child: Expanded(
                                      child: CustomTextBox(
                                          caption: '',
                                          controller:
                                              TextEditingController()))),
                              8.heightBox,
                              CustomTextHeaderWithCaptinAndWidget(
                                  capWidth: 150,
                                  caption: "Prefession",
                                  child: Expanded(
                                      child: CustomTextBox(
                                          caption: '',
                                          controller:
                                              TextEditingController()))),
                              8.heightBox,
                              CustomTextHeaderWithCaptinAndWidget(
                                  capWidth: 150,
                                  caption: "Address",
                                  child: Expanded(
                                      child: CustomTextBox(
                                          caption: '',
                                          controller:
                                              TextEditingController()))),
                              8.heightBox,
                              CustomTextHeaderWithCaptinAndWidget(
                                  capWidth: 150,
                                  caption: "Mobile & Email",
                                  child: Expanded(
                                      child: Row(
                                    children: [
                                      Expanded(
                                          child: CustomTextBox(
                                              caption: 'Mobile',
                                              controller:
                                                  TextEditingController())),
                                      8.widthBox,
                                      Expanded(
                                          child: CustomTextBox(
                                              caption: 'Email',
                                              controller:
                                                  TextEditingController()))
                                    ],
                                  ))),
                              8.heightBox,
                              CustomTextHeaderWithCaptinAndWidget(
                                  capWidth: 150,
                                  caption: "Relation With Referee",
                                  child: Expanded(
                                      child: CustomTextBox(
                                          caption: '',
                                          controller:
                                              TextEditingController()))),
                            ],
                          ),
                        ),
                        2.heightBox,
                        CustomGroupBox(
                          groupHeaderText: 'Reference(2) Info',
                          child: Column(
                            children: [
                              CustomTextHeaderWithCaptinAndWidget(
                                  capWidth: 150,
                                  caption: "Name of Referee (1)",
                                  child: Expanded(
                                      child: CustomTextBox(
                                          caption: '',
                                          controller:
                                              TextEditingController()))),
                              8.heightBox,
                              CustomTextHeaderWithCaptinAndWidget(
                                  capWidth: 150,
                                  caption: "Prefession",
                                  child: Expanded(
                                      child: CustomTextBox(
                                          caption: '',
                                          controller:
                                              TextEditingController()))),
                              8.heightBox,
                              CustomTextHeaderWithCaptinAndWidget(
                                  capWidth: 150,
                                  caption: "Address",
                                  child: Expanded(
                                      child: CustomTextBox(
                                          caption: '',
                                          controller:
                                              TextEditingController()))),
                              8.heightBox,
                              CustomTextHeaderWithCaptinAndWidget(
                                  capWidth: 150,
                                  caption: "Mobile & Email",
                                  child: Expanded(
                                      child: Row(
                                    children: [
                                      Expanded(
                                          child: CustomTextBox(
                                              caption: 'Mobile',
                                              controller:
                                                  TextEditingController())),
                                      8.widthBox,
                                      Expanded(
                                          child: CustomTextBox(
                                              caption: 'Email',
                                              controller:
                                                  TextEditingController()))
                                    ],
                                  ))),
                              8.heightBox,
                              CustomTextHeaderWithCaptinAndWidget(
                                  capWidth: 150,
                                  caption: "Relation With Referee",
                                  child: Expanded(
                                      child: CustomTextBox(
                                          caption: '',
                                          controller:
                                              TextEditingController()))),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
            true),
      )
    ]);

Widget _tab(String id, HrEmployeeProfileController controller) {
  switch (id) {
    case '1':
      return _addressTab(controller);
    case '2':
      return _qualificationTab(controller);
    case '3':
      return _employmentTab(controller);
    case '4':
      return _leaveTab(controller);
    case '5':
      return _selparation(controller);
    case '6':
      return _dependants(controller);
    case '7':
      return _training(controller);
    case '8':
      return _misconduct(controller);
    case '9':
      return _adtiotional(controller);
    default:
      return const SizedBox();
  }
}
