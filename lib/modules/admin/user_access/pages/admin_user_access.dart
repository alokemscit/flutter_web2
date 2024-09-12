// ignore_for_file: empty_catches

import '../../../../core/config/const.dart';
import '../controller/adin_user_access_controller.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'dart:html' as html;

import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:webview_flutter/webview_flutter.dart';
 

class AdminUserAccess extends StatelessWidget {
  const AdminUserAccess({super.key});
  void disposeController() {
    try {
      Get.delete<AdminUserAccessController>(force: true);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    
    final AdminUserAccessController controller =
        Get.put(AdminUserAccessController());
    controller.context = context;
    return Obx(() =>
        CommonBody3(controller, [_mainWidget(controller)], 'User Access::'));
  }
}

Widget _mainWidget(AdminUserAccessController controller) => Expanded(
    child: controller.context.width > 1150
        ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 650,
                height: double.infinity,
                child: CustomGroupBox(
                    padingvertical: 0,
                    groupHeaderText: 'Employee list',
                    child: _userList(controller)),
              ),
              8.widthBox,
              _treeList(controller)
            ],
          )
        : Column(
          
            children: [
              SizedBox(
                height: 350,
                child: CustomGroupBox(
                    padingvertical: 0,
                    groupHeaderText: 'Employee list',
                    child: _userList(controller)),
              ),
              4.heightBox,
              _treeList(controller)
            ],
          ));

Widget _userList(AdminUserAccessController controller) => Column(
      children: [
        6.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
                child: CustomSearchBox(
              caption: 'Search Employee',
              controller: controller.txt_search,
              onChange: (v) {
                controller.search();
              },
              width: 300,
            ))
          ],
        ),
        8.heightBox,
        Expanded(
            child: CustomTableGenerator(colWidtList: const [
          20,
          60,
          40,
          40,
          15
        ], childrenHeader: [
          CustomTableColumnHeaderBlack('Emp. ID'),
          CustomTableColumnHeaderBlack('Name'),
          CustomTableColumnHeaderBlack('Designation'),
          CustomTableColumnHeaderBlack('Department'),
          CustomTableColumnHeaderBlack('*', Alignment.center),
        ], childrenTableRowList: [
          ...controller.list_emp_temp.map((f) => TableRow(
                  decoration: BoxDecoration(
                      color: controller.selectedEmployee.value.id == f.id
                          ? appColorBlue.withOpacity(0.08)
                          : Colors.white),
                  children: [
                    CustomTableCellx(text: f.eno ?? ''),
                    CustomTableCellx(text: f.name ?? ''),
                    CustomTableCellx(text: f.desigName ?? ''),
                    CustomTableCellx(text: f.depName ?? ''),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Checkbox(
                            value: controller.selectedEmployee.value.id == f.id
                                ? true
                                : false,
                            onChanged: (v) {
                              controller.setEmployee(f);
                            }))
                  ]))
        ])),
        4.heightBox,
        CustomButton(Icons.save, 'Testing', () {
          controller.testing();
        })
      ],
    );

Widget _treeList(AdminUserAccessController controller) => Expanded(
    child: CustomGroupBox(
        bgColor: Colors.white,
        groupHeaderText: '',
        child:  
          controller.htmlView.value
         ));
