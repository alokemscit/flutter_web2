 
 
  
import 'package:web_2/core/config/const.dart';
 
 
import 'package:web_2/modules/hms_setup/controller/hms_report_section_setup_controller.dart';

 

class ReportSectionSetup extends StatelessWidget {
  const ReportSectionSetup({super.key});
  void disposeController() {
    try {
      Get.delete<ReportSectionSetupController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    ReportSectionSetupController controller =
        Get.put(ReportSectionSetupController());
    controller.context = context;

    return Scaffold(
        body: Obx(
      () => CustomCommonBody(
          controller.isLoading.value,
          controller.isError.value,
          controller.errorMessage.value,
          _desktop(controller),
          _desktop(controller),
          _desktop(controller)),
    ));
  }
}

_desktop(ReportSectionSetupController controller) => Padding(
    padding: const EdgeInsets.all(8),
    child: CustomAccordionContainer(
      height: 0,
      headerName: "Charges Config", 
      children: [
        Expanded(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Expanded(
              flex: 5,
               child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [

                        Row(
                          children: [
                            Expanded(child: CustomSearchBox(caption: 'Search', controller: TextEditingController(), onChange: (String value) {  },)),
                          ],
                        ),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Table(
                              children: [
                                   TableRow(
                                     decoration: const BoxDecoration(
                              color: kBgDarkColor,
                            ),
                                    children: [
                                        TableCell(
                                          verticalAlignment: TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              "HR Department",
                                              style: customTextStyle,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment: TableCellVerticalAlignment.middle,
                                          child: Padding(
                                           padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              "HMS Department",
                                              style: customTextStyle,
                                            ),
                                          ),
                                        ),
                                          
                                      ]),
                                       ...controller.d_list_temp
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    //int i = entry.key;
                                    var section = entry.value;
                                    return TableRow(
                                        decoration:  BoxDecoration(
                                          color:controller.selectedSectionID.value ==
                                            section.hmsId
                                        ? Colors.lightGreen.withOpacity(0.02)
                                        : kBgColorG,
                                        ),
                                        children: [
                                                    
                                                    
                                           TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment.middle,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    controller.selectedSectionID
                                                        .value = section.hmsId!;
                                                  },
                                                  child: SizedBox(
                                                      height: 25,
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 8,
                                                            vertical: 2),
                                                        child: Text(
                                                          section.hrName!
                                                              .toString(),
                                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                                        ),
                                                      )))),
                                                    
                                                    
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment.middle,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    controller.selectedSectionID
                                                        .value = section.hmsId!;
                                                  },
                                                  child: SizedBox(
                                                      height: 25,
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 8,
                                                            vertical: 2),
                                                        child: Text(
                                                          section.hmsName!
                                                              .toString(),
                                                        ),
                                                      )))),
                                          
                                        ]);
                                  }).toList()
                              ],
                                border: CustomTableBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  8.widthBox,
                  Expanded(
                    flex: 6,
                    
                    child: Container(
                    color: Colors.amber,
                  )
                  )
                 
                ],
               ),
             ),
             const Expanded(
              flex: 3,
               child: Row(
                children: [
               
                ],
               ),
             )
          
            ],
          ),
        )

      ],
    ));
