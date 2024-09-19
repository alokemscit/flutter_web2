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
                    bgColor: Colors.white,
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
                          0.520, // Set a suitable height
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

Widget _menuBar() => CustomTooBar([
      CustomTool(
        menu: ToolMenuSet.file,
        onTap: () {},
      ),
      CustomTool(
        menu: ToolMenuSet.save,
        onTap: () {},
      ),
      CustomTool(
        menu: ToolMenuSet.undo,
        onTap: () {},
      ),
      CustomTool(
        menu: ToolMenuSet.close,
        onTap: () {},
      ),
    ]);

Widget _tabPanel(HrEmployeeProfileController controller) => CustomGroupBox(
        child: Column(
      children: [],
    ));

Widget _empSearch(HrEmployeeProfileController controller) => CustomGroupBox(
    borderWidth: 1.5,
    bgColor: Colors.white,
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
          12.widthBox,
          Container(
            color: kGrayColor,
            height: 18,
            width: 1,
          ),
          Row(
            children: [
              24.widthBox,
              CustomRoundedButton(
                  iconColor: appColorLogoDeep,
                  icon: Icons.edit,
                  bgColor: Colors.transparent,
                  iconSize: 24,
                  onTap: () {}),
              8.widthBox,
              CustomRoundedButton(
                  iconColor: appColorBlue,
                  icon: Icons.undo,
                  bgColor: Colors.transparent,
                  iconSize: 24,
                  onTap: () {})
            ],
          )
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
              bgColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    24.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropDown2(
                              labeltext: 'Designation',
                              id: null,
                              list: [],
                              onTap: (v) {}),
                        ),
                        8.widthBox,
                        Expanded(
                            child: CustomTextBox(
                                caption: "Grade",
                                controller: TextEditingController())),
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropDown2(
                              labeltext: 'Department Type',
                              id: null,
                              list: [],
                              onTap: (v) {}),
                        ),
                        8.widthBox,
                        Expanded(
                            child: CustomTextBox(
                                caption: "Department",
                                controller: TextEditingController())),
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropDown2(
                              labeltext: 'Unit/Section',
                              id: null,
                              list: [],
                              onTap: (v) {}),
                        ),
                        8.widthBox,
                        Expanded(
                            child: CustomTextBox(
                                caption: "Type of employment",
                                controller: TextEditingController())),
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        CustomDatePickerDropDown(
                            label: 'Date of Join',
                            width: 110,
                            textfontSize: 11.3,
                            date_controller: TextEditingController()),
                        8.widthBox,
                        Expanded(
                            child: CustomDropDown2(
                                labeltext: 'Current Job Status',
                                id: null,
                                list: [],
                                onTap: (v) {})),
                      ],
                    ),
                    12.heightBox,
                  ],
                ),
              )),
          12.heightBox,
        ],
      ),
    );

Widget _generalInfo(HrEmployeeProfileController controller) => SizedBox(
      width: 580,
      child: Column(
        children: [
          CustomGroupBox(
              borderWidth: 1.3,
              bgColor: Colors.white,
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
                        Expanded(
                          child: Column(
                            children: [
                              _prefixAndName(
                                  controller,
                                  CustomDropDown2(
                                      width: 110,
                                      labeltext: 'Prefix',
                                      id: null,
                                      list: [],
                                      onTap: (v) {}),
                                  CustomTextBox(
                                      caption: 'Name',
                                      controller: TextEditingController())),
                              8.heightBox,
                              Row(
                                children: [
                                  CustomDatePickerDropDown(
                                      width: 110,
                                      textfontSize: 11.3,
                                      date_controller: TextEditingController()),
                                  8.widthBox,
                                  Expanded(
                                      child: CustomDropDown2(
                                          labeltext: 'Nationality',
                                          id: null,
                                          list: [],
                                          onTap: (v) {})),
                                ],
                              ),
                              8.heightBox,
                              Row(
                                children: [
                                  Expanded(
                                      child: CustomTextBox(
                                          caption: "Fathers's Name",
                                          controller: TextEditingController()))
                                ],
                              ),
                              8.heightBox,
                              Row(
                                children: [
                                  Expanded(
                                      child: CustomTextBox(
                                          caption: "Mother's Name",
                                          controller: TextEditingController()))
                                ],
                              ),
                              8.heightBox,
                              Row(
                                children: [
                                  Expanded(
                                      child: CustomTextBox(
                                          caption: "Spouse Name",
                                          controller: TextEditingController()))
                                ],
                              ),
                              8.heightBox,
                              Row(
                                children: [
                                  CustomDropDown2(
                                      width: 110,
                                      labeltext: 'Gender',
                                      id: null,
                                      list: [],
                                      onTap: (v) {}),
                                  8.widthBox,
                                  Expanded(
                                      child: CustomDropDown2(
                                          width: 110,
                                          labeltext: 'Religion',
                                          id: null,
                                          list: [],
                                          onTap: (v) {})),
                                  8.widthBox,
                                  Expanded(
                                      child: CustomDropDown2(
                                          width: 110,
                                          labeltext: 'Marital Status',
                                          id: null,
                                          list: [],
                                          onTap: (v) {}))
                                ],
                              ),
                              8.heightBox,
                              Row(
                                children: [
                                  CustomDropDown2(
                                      width: 110,
                                      labeltext: 'Identity Type',
                                      id: null,
                                      list: [],
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
                        16.widthBox,
                        _imageBox(),
                      ],
                    ),
                    12.heightBox,
                  ],
                ),
              )),
        ],
      ),
    );

_prefixAndName(HrEmployeeProfileController controller, CustomDropDown2 dropdown,
        CustomTextBox textbox) =>
    controller.context.width < 450
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dropdown,
              8.heightBox,
              Row(
                children: [
                  Expanded(child: textbox),
                ],
              )
            ],
          )
        : Row(
            children: [dropdown, 8.widthBox, Expanded(child: textbox)],
          );

_imageBox() => Column(
      children: [
        Container(
          height: 120,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
              border: Border.all(
                  color: appColorGrayDark.withOpacity(0.6), width: 0.5)),
        ),
        4.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
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
            )
          ],
        )
      ],
    );
