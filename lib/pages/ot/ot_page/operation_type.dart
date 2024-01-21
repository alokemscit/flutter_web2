import 'package:flutter/material.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/custom_button.dart';
import 'package:web_2/component/widget/custom_textbox.dart';

import 'model/model_ot_type.dart';
import 'share/ot_share_data.dart';

class OperationType extends StatelessWidget {
  const OperationType({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController remController = TextEditingController();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _leftSide(nameController, remController),
                ),
                const Expanded(
                    flex: 6,
                    child:  _rightSide())
              ],
            ),
          ),
        );
      },
    );
  }
}

// ignore: camel_case_types
class _rightSide extends StatelessWidget {
  const _rightSide({super.key});

  @override
  Widget build(BuildContext context) {
    List<ModelOtType>? list = [];
    return Container(
     decoration: BoxDecorationTopRounded,
    child: SingleChildScrollView(
      child: FutureBuilder(
        future: get_ot_type(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //             // While the Future is still running, you can return a loading indicator or placeholder
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ));
          } else if (snapshot.hasError) {
            // If there's an error, handle it accordingly
            return Text('Error: ${snapshot.error}');
          }
           list = snapshot.data!;
          
          return Table(
            columnWidths: const {
              0: FixedColumnWidth(80),
              1: FlexColumnWidth(110),
              2: FlexColumnWidth(150),
              3: FlexColumnWidth(50),
              4: FlexColumnWidth(30),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: kBgLightColor,
                  //   color: Colors.grey,
                  boxShadow: myboxShadow,
                  //border: Border.all(color: Colors.grey)
                ),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Code'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Operation Type Name"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Remarks"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Sataus"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Edit"),
                  ),
                ],
              ),
              ...list!
                  .map((e) => TableRow(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)),
                          children: [
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8,),
                                child: Text(e.tYPEID!),
                              ),
                            ),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(e.tYPETITLE!),
                                )),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(e.rEMARKS!),
                                )),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(e.aCTIVE!.toString() == "1"
                                      ? "Active"
                                      : "Inactive"),
                                )),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.edit,
                                      color: kGrayColor,
                                      size: 20,
                                    ),
                                  ),
                                )),
                          ]))
                  .toList(),
            ],
            border: TableBorder.all(
                width: 0.3, color: const Color.fromARGB(255, 89, 92, 92)),
          );
        },
      ),
    ),
  );

  }
}

// _rightSide1() {
  
  
//   return

//    Container(
//      decoration: BoxDecorationTopRounded,
//     child: SingleChildScrollView(
//       child: FutureBuilder(
//         future: get_ot_type(),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             //             // While the Future is still running, you can return a loading indicator or placeholder
//             return const Center(
//                 child: Padding(
//               padding: EdgeInsets.all(8.0),
//               child: CircularProgressIndicator(),
//             ));
//           } else if (snapshot.hasError) {
//             // If there's an error, handle it accordingly
//             return Text('Error: ${snapshot.error}');
//           }
//            list = snapshot.data!;
          
//           return Table(
//             columnWidths: const {
//               0: FixedColumnWidth(80),
//               1: FlexColumnWidth(110),
//               2: FlexColumnWidth(150),
//               3: FlexColumnWidth(50),
//               4: FlexColumnWidth(18),
//             },
//             children: [
//               TableRow(
//                 decoration: BoxDecoration(
//                   color: kBgLightColor,
//                   //   color: Colors.grey,
//                   boxShadow: myboxShadow,
//                   //border: Border.all(color: Colors.grey)
//                 ),
//                 children: const [
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('Code'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text("Operation Type Name"),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text("Remarks"),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text("Sataus"),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text("Edit"),
//                   ),
//                 ],
//               ),
//               ...list!
//                   .map((e) => TableRow(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(color: Colors.grey)),
//                           children: [
//                             TableCell(
//                               verticalAlignment: TableCellVerticalAlignment.middle,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8,),
//                                 child: Text(e.tYPEID!),
//                               ),
//                             ),
//                             TableCell(
//                                 verticalAlignment:
//                                     TableCellVerticalAlignment.middle,
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(horizontal: 8),
//                                   child: Text(e.tYPETITLE!),
//                                 )),
//                             TableCell(
//                                 verticalAlignment:
//                                     TableCellVerticalAlignment.middle,
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(horizontal: 8),
//                                   child: Text(e.rEMARKS!),
//                                 )),
//                             TableCell(
//                                 verticalAlignment:
//                                     TableCellVerticalAlignment.middle,
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(horizontal: 8),
//                                   child: Text(e.aCTIVE!.toString() == "1"
//                                       ? "Active"
//                                       : "Inactive"),
//                                 )),
//                             TableCell(
//                                 verticalAlignment:
//                                     TableCellVerticalAlignment.middle,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 8, vertical: 4),
//                                   child: InkWell(
//                                     onTap: () {},
//                                     child: const Icon(
//                                       Icons.edit,
//                                       color: kGrayColor,
//                                       size: 20,
//                                     ),
//                                   ),
//                                 )),
//                           ]))
//                   .toList(),
//             ],
//             border: TableBorder.all(
//                 width: 0.3, color: const Color.fromARGB(255, 89, 92, 92)),
//           );
//         },
//       ),
//     ),
//   );


//}

_leftSide(
    TextEditingController nameController, TextEditingController remController) {
  return Container(
    decoration: BoxDecorationTopRounded,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text(
            "Operation Type:",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
               ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
          child: Container(
             
             decoration: BoxDecoration(
              color: kBgLightColor,
               // border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                boxShadow:const [
          BoxShadow(
            blurRadius: 0.5,
            spreadRadius: 0.45,
            color: Colors.grey,
            offset: Offset(0, 0)
          )
                ]
              ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  CustomTextBox(
                    caption: "Type Name",
                    controller: nameController,
                    onChange: (onChange) {},
                    width: double.infinity,
                    isFilled: true,
                    maxlength: 150,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  CustomTextBox(
                    caption: "Remarks",
                    controller: remController,
                    onChange: (onChange) {},
                    width: double.infinity,
                    isFilled: true,
                    maxlength: 200,
                    textInputType: TextInputType.multiline,
                    height: 70,
                    maxLine: 3,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [CustomButton(text: "Save", onPressed: () {})],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
