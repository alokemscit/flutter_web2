import 'package:flutter/material.dart';
import 'package:web_2/component/widget/custom_container.dart';
import 'package:web_2/component/widget/custom_search_box.dart';
import 'package:web_2/pages/ot/doctor_cat_page/model/module_for_set_doctor_type.dart';

import '../../../component/settings/config.dart';
import 'share/ot_share_data.dart';

class DoctorCategorySetuo extends StatelessWidget {
  const DoctorCategorySetuo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 5,
                child: CustomContainer(
                  label: "All Doctors List",
                  labelToChildDistance: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: CustomSearchBox(
                                  caption: "Search Doctor",
                                  controller: TextEditingController(),
                                  isFilled: true,
                                  width: double.infinity,
                                  maxlength: 50,
                                  height: 32,
                                  onChange: (v) {}),
                            ),
                            const Expanded(flex: 4, child: SizedBox())
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: 
                          
                          
                          FutureBuilder(
                             future: get_doctor(),
                            builder: (BuildContext context, AsyncSnapshot<List<ModelForSetDoctorType>> snapshot) {

                                   if (snapshot.connectionState == ConnectionState.waiting) {
                              //             // While the Future is still running, you can return a loading indicator or placeholder
                                          return const Center(child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: CircularProgressIndicator(),
                                          ));
                                          } else if (snapshot.hasError) {
                                          // If there's an error, handle it accordingly
                                          return Text('Error: ${snapshot.error}');
                                        }



                              return Table(
                                columnWidths: const {
                                  0: FixedColumnWidth(80),
                                  1: FlexColumnWidth(110),
                                  // 2: FlexColumnWidth(100),
                                  3: FlexColumnWidth(30),
                                },
                                children: [
                                  TableRow(
                                      decoration: BoxDecoration(
                                        color: kBgLightColor,
                                        //   color: Colors.grey,
                                        boxShadow: myboxShadow,
                                      ),
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Code'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("Doctor's Name"),
                                        ),
                                        //  Padding(
                                        //    padding: EdgeInsets.all(8.0),
                                        //    child: Text('Unit'),
                                        //  ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(""),
                                        ),
                                      ]),
                              
                                         
  ...snapshot.data!.map((e) {
    return TableRow(
      children: [
        Text(e.eMPNAME!),
        Text(e.eMPID!),
        Text(""),
      ],
    );
  }).toList(),
 

                                ],
                                border: TableBorder.all(
                                    width: 0.3,
                                    color: const Color.fromARGB(255, 89, 92, 92)),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(
              width: 4,
            ),
            const Expanded(
                flex: 5,
                child: CustomContainer(
                  label: "All Doctors List",
                  labelToChildDistance: 10,
                ))
          ],
        ),
      ),
    );
  }
}
