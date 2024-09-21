// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../core/config/const.dart';

import '../controller/hr_employee_profile_controller.dart';

class EmployeeProfile extends StatelessWidget {
  const EmployeeProfile({super.key});
  void disposeController() {
    mdisposeController<HrEmployeeProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    final HrEmployeeProfileController controller =
        Get.put(HrEmployeeProfileController());
    controller.context = context;
    // print(context.height);
    return Obx(() => CommonBodyWithToolBar(
        controller,
        [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  _menuBar(),
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
                      maxHeight: (controller.context.height > 950
                              ? controller.context.height
                              : controller.context.height - 100) *
                          0.605, // Set a suitable height
                    ),
                    child: _tabPanel(controller),
                  ),
                ],
              ),
            ),
          )
        ],
        [
          CustomTool(
            menu: ToolMenuSet.file,
            onTap: () {},
          ),
          CustomTool(
            menu: ToolMenuSet.save,
            onTap: () {},
          ),
          CustomTool(
            menu: ToolMenuSet.edit,
            onTap: () {},
            isDisable: true,
          ),
          CustomTool(
            menu: ToolMenuSet.undo,
            onTap: () {},
          ),
          CustomTool(
            menu: ToolMenuSet.close,
            onTap: () {
              //mCloseTab(context);
            },
          ),
        ],
        Colors.white));
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
        )
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
          CustomTextBox(
              width: 100,
              caption: 'Emp ID',
              controller: TextEditingController()),
          4.widthBox,
          CustomRoundedButton(
              iconColor: appColorBlue,
              icon: Icons.search,
              bgColor: Colors.transparent,
              iconSize: 24,
              onTap: () {}),
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
                          child: CustomDropDown2(
                              labeltext: 'Department Type',
                              id: controller.cmb_department_category.value,
                              list: controller.getList('departmentcategory'),
                              onTap: (v) {
                                controller.cmb_department.value = '';
                                controller.cmb_department.value = '';
                                controller.cmb_department_category.value = v!;
                                // controller.setDepartmentType(v!);
                              }),
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
                              id: controller.cmb_designation.value,
                              list: controller.getList('designation'),
                              onTap: (v) {}),
                        ),
                        8.widthBox,
                        Expanded(
                          child: CustomDropDown2(
                              labeltext: 'Designation',
                              id: controller.cmb_designation.value,
                              list: controller.getList('designation'),
                              onTap: (v) {}),
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
                                    width: 120,
                                    textfontSize: 11.3,
                                    date_controller: TextEditingController()),
                              ),
                              8.widthBox,
                              Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    Checkbox(value: false, onChanged: (v) {}),
                                    Expanded(
                                      child: CustomDatePickerDropDown(
                                          label: 'Contract End Date',
                                          width: 120,
                                          textfontSize: 11.3,
                                          date_controller:
                                              TextEditingController()),
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
                              Checkbox(value: false, onChanged: (v) {}),
                              Text(
                                'Is In Probation',
                                style: customTextStyle.copyWith(fontSize: 10),
                              ),
                              8.widthBox,
                              CustomTextBox(
                                  caption: '',
                                  textInputType: TextInputType.phone,
                                  textAlign: TextAlign.center,
                                  maxlength: 3,
                                  width: 40,
                                  controller: TextEditingController()),
                              Expanded(
                                child: CustomDropDown2(
                                    labeltext: 'Duration',
                                    id: null,
                                    list: [],
                                    onTap: (v) {}),
                              )
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
                                      fillColor: Colors.white,
                                      caption: 'First Name',
                                      controller: TextEditingController())),
                              8.heightBox,
                              _responsive2(
                                  controller.context.width,
                                  CustomTextBox(
                                      fillColor: Colors.white,
                                      caption: 'Middle Name',
                                      controller: TextEditingController()),
                                  CustomTextBox(
                                      fillColor: Colors.white,
                                      caption: 'Last Name',
                                      controller: TextEditingController()),
                                  true),
                              8.heightBox,
                              Row(
                                children: [
                                  CustomDatePickerDropDown(
                                      width: 120,
                                      textfontSize: 12,
                                      date_controller: TextEditingController()),
                                  8.widthBox,
                                  Expanded(
                                      child: CustomDropDown2(
                                          labeltext: 'Nationality',
                                          id: controller.cmb_nationality.value,
                                          list: controller.getList('country'),
                                          onTap: (v) {})),
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
                                      onTap: (v) {}),
                                  CustomDropDown2(
                                      width: 120,
                                      labeltext: 'Religion',
                                      id: controller.cmb_religion.value,
                                      list: controller.getList('religion'),
                                      onTap: (v) {}),
                                  CustomDropDown2(
                                      width: 120,
                                      labeltext: 'Marital Status',
                                      id: controller.cmb_maritalstatus.value,
                                      list: controller.getList('marital'),
                                      onTap: (v) {})),
                              8.heightBox,
                              Row(
                                children: [
                                  CustomDropDown2(
                                      width: 120,
                                      labeltext: 'Identity Type',
                                      id: controller.cmb_identitytype.value,
                                      list: controller.getList('identitytype'),
                                      onTap: (v) {}),
                                  8.widthBox,
                                  Expanded(
                                      child: CustomTextBox(
                                          caption: "Identity No",
                                          controller: TextEditingController())),
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

_responsive2(double width, Widget widget1, Widget widget2,
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

_imageBox(HrEmployeeProfileController controller)=> Column(
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
                      
                      child:  controller.imageFile.value.path != ''
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
                          )
                  );
}),
                    
                    


     
        4.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async{
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
