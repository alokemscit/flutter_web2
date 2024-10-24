import '../../../../core/config/const.dart';
import '../controller/cost_center_controller.dart';

class ConstcenterPage extends StatelessWidget implements MyInterface {
  const ConstcenterPage({super.key});

  @override
  void disposeController() {
    mdisposeController<CostcenterController>();
  }

  @override
  Widget build(BuildContext context) {
    CostcenterController controller = Get.put(CostcenterController());
    controller.context = context;

    return Obx(() => CommonBodyWithToolBar(
            controller,
            [
              Expanded(
                  child: CustomGroupBox(
                      child: Column(
                children: [_entryPart(controller), _tablePart(controller)],
              )))
            ],
            controller.list_tool, (v) {
          controller.toolbarevent(v);
        }));
  }
}
// CommonBody2(controller, _desktop(controller)

_tablePart(CostcenterController controller) => Expanded(
      child: CustomGroupBox(
        groupHeaderText: 'Cost Cenet List',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: CustomSearchBox(
                      caption: "Search",
                      width: 400,
                      controller: controller.txt_search,
                      onChange: (v) {
                        controller.search();
                      }),
                ),
              ],
            ),
            8.heightBox,
            Expanded(
                child: CustomTableGenerator(
                    colWidtList: const [
                  50,
                  120,
                  140,
                  40
                ],
                    childrenHeader: [
                  CustomTableColumnHeaderBlack('Code'),
                  CustomTableColumnHeaderBlack('Cost Center Name'),
                  CustomTableColumnHeaderBlack('Description'),
                  CustomTableColumnHeaderBlack('*', Alignment.center),
                ],
                    childrenTableRowList: controller.list_costcenter_temp
                        .map((f) => TableRow(
                          decoration: BoxDecoration(color: controller.selectedCC.value.id==f.id?appColorRowSelected:Colors.white),
                          children: [
                              CustomTableCellx(text: f.code ?? '',isTextTuncate :true),
                              CustomTableCellx(text: f.name ?? '',isTextTuncate :true),
                              CustomTableCellx(text: f.description ?? '',isTextTuncate :true),
                              CustomTableEditCell(() {
                                controller.edit(f);
                              }, Icons.edit, 14)
                            ]))
                        .toList()))
          ],
        ),
      ),
    );

_entryPart(CostcenterController controller) => Row(
      children: [
        Flexible(
          child: SizedBox(
            width: 600,
            child: CustomGroupBox(
              groupHeaderText: 'Enrty',
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomTextBox(
                            caption: "Code",
                            isReadonly: true,
                            isDisable: true,
                            disableBackColor: appColorGrayLight,
                            maxlength: 10,
                            width: 100,
                            controller: controller.txt_code,
                            onChange: (C) {}),
                        10.widthBox,
                        Expanded(
                            child: CustomTextBox(
                                caption: "Cost Center Name",
                                maxlength: 150,
                                controller: controller.txt_name,
                                onChange: (v) {})),
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextBox(
                                caption: "Description",
                                maxlength: 150,
                                controller: controller.txt_desc,
                                onChange: (v) {})),
                      ],
                    ),
                    10.heightBox,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
