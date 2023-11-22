


import 'package:flutter/material.dart';

import '../../../../component/settings/config.dart';
import '../../../../component/widget/custom_button.dart';
import '../../../../component/widget/custom_container.dart';
import '../../../../component/widget/custom_dropdown.dart';
import '../../../../component/widget/custom_search_box.dart';
import '../../../../component/widget/custom_textbox.dart';
import '../../../../data/module_image_data.dart';
import '../../../appointment/doctor_leave_page/model/doctor_list_model.dart';

Widget rightPanel( TextEditingController txtSearch) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: CustomContainer(
      child: TablePart(txtSearch: txtSearch, dList: const []),
    ),
  );
}

Widget leftPanel(String? iid, TextEditingController txtModule,
    TextEditingController txtDesc) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.3),
              color: kBgLightColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 5.1,
                  spreadRadius: 3.1,
                )
              ]),
          child: Column(
            children: [
              CustomTextBox(
                  width: double.infinity,
                  isFilled: true,
                  caption: "Module Name",
                  controller: txtModule,
                  onChange: (onChange) {}),
              const SizedBox(
                height: 4,
              ),
              CustomTextBox(
                  width: double.infinity,
                  textInputType: TextInputType.multiline,
                  isFilled: true,
                  maxLine: 3,
                  maxlength: 250,
                  height: 65,
                  caption: "Description",
                  controller: txtDesc,
                  onChange: (onChange) {}),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: FutureBuilder(
                    future: moduleImageList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!;
                          return CustomDropDown(
                            id: iid,
                            isFilled: true,
                            labeltext: "Select Icon",
                            list: data.map((item) {
                              return DropdownMenuItem<String>(
                                value:
                                    item.category, // Convert item.id to String.
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            "assets/images/${item.category!}.png"),
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        item.category!,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                            onTap: (String? value) {
                              iid = value!;
                            },
                            width: double.infinity,
                          );
                        } else {
                          return const SizedBox();
                        }
                      } else {
                        return const SizedBox();
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      text: "Save",
                      onPressed: () {
                        print(iid);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

class TablePart extends StatelessWidget {
  const TablePart({
    super.key,
    required this.txtSearch,
    required this.dList,
  });

  final TextEditingController txtSearch;
  final List<DoctorList> dList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSearchBox(
          isFilled: true,
          width: double.infinity,
          caption: "Search Module",
          controller: txtSearch,
          onChange: (String value) {},
        ),
        Expanded(
            child: Column(
          children: [
            const TableHeader(),
            Expanded(
                child: SingleChildScrollView(
                    child: ModuleListTable(dList: dList))),
          ],
        ))
      ],
    );
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(80),
          1: FlexColumnWidth(80),
          2: FlexColumnWidth(110),
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
                  child: Text('ID'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Module Name'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Description'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(""),
                ),
              ]),
        ],
        border: TableBorder.all(
            width: 0.3, color: const Color.fromARGB(255, 89, 92, 92)),
      ),
    );
  }
}

class ModuleListTable extends StatelessWidget {
  const ModuleListTable({
    super.key,
    required this.dList,
  });

  final List<DoctorList> dList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(80),
          1: FlexColumnWidth(80),
          2: FlexColumnWidth(110),
          3: FlexColumnWidth(30),
        },
        children: dList.map((e) {
          return TableRow(
              decoration: BoxDecoration(
                  color: Colors.white, border: Border.all(color: Colors.black)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(e.dOCID!),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    e.dOCTORNAME!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(e.uNIT!),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.black.withOpacity(0.4),
                      size: 24,
                    ),
                  ),
                ),
              ]);
        }).toList(),
        border: TableBorder.all(
            width: 0.3, color: const Color.fromARGB(255, 89, 92, 92)),
      ),
    );
  }
}
