import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_2/component/widget/custom_search_box.dart';

import '../../../component/settings/config.dart';
import '../../../data/data_api.dart';
import '../doctor_leave_page/bloc/doctor_leave_bloc.dart';
import '../doctor_leave_page/model/doctor_list_model.dart';

class TimeSlotPage extends StatelessWidget {
  const TimeSlotPage({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController txtSearch = TextEditingController();
    List<DoctorList> dList = [];
    return Scaffold(
        body: RepositoryProvider(
            create: (context) => data_api(),
            child: MultiBlocProvider(
              //create: (context) => DropdownBloc(),
              providers: [
                BlocProvider<DoctorSearchBloc>(
                  create: (BuildContext context) => DoctorSearchBloc(
                    RepositoryProvider.of<data_api>(context),
                  ),
                ),
                BlocProvider<DoctorDataBloc>(
                  create: (BuildContext context) => DoctorDataBloc(
                    RepositoryProvider.of<data_api>(context),
                  )..add(DoctorDataLoadEvent()),
                ),
              ],

              child: BlocBuilder<DoctorDataBloc, DoctorDataState>(
                builder: (context, state) {
                  if (state is DoctorDataLoading) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ));
                  }

                  if (state is DoctorDataLoaded) {
                    dList = state.list;

                    return Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: DoctorListWithSearch(
                                txtSearch: txtSearch, dList: dList)),
                        Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4, left: 4),
                              child: Column(
                                children: [
                                 
                                  Container(
                                    constraints: const BoxConstraints(minHeight: 88),
                                    decoration: const BoxDecoration(
                                        color:
                                            kBgLightColor, //.withOpacity(0.8),
                                        // color: Color.fromARGB(255, 252, 251, 251),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 5.1,
                                            spreadRadius: 3.1,
                                          )
                                        ]),
                                   // height: 88,
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomLabel(caption: 'Id', value: '1234',),
                                          CustomLabel(caption: 'Name', value: 'Abcd efgjkhfjf dgfdg',),
                                          CustomLabel(caption: 'Unit', value: 'Unit Name',),
                                          ],
                                      ),
                                    ),
                                  ),


                                 Expanded(
                                   child: Container(
                                      decoration: const BoxDecoration(
                                          color:
                                              kBgLightColor, //.withOpacity(0.8),
                                          // color: Color.fromARGB(255, 252, 251, 251),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 5.1,
                                              spreadRadius: 3.1,
                                            )
                                          ]),
                                      height: 80,
                                       
                                    ),
                                 )



                                ],
                              ),
                            )),
                      ],
                    );
                  } else {
                    return const Text("No Data Found");
                  }
                },
              ),
            )));
  }
}

class CustomLabel extends StatelessWidget {
  const CustomLabel({
    super.key, required this.caption, required this.value,
  });
  final String caption;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Row(
        children: [
           SizedBox(
              width: 50,
              child: Text(
                "$caption :",
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
          Text(value,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic))
        ],
      ),
    );
  }
}

class DoctorListWithSearch extends StatelessWidget {
  const DoctorListWithSearch({
    super.key,
    required this.txtSearch,
    required this.dList,
  });

  final TextEditingController txtSearch;
  final List<DoctorList> dList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.3),
          color: kBgLightColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 5.1,
              spreadRadius: 3.1,
            )
          ]),
      child: TablePart(txtSearch: txtSearch, dList: dList),
    );
  }
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
          caption: "Search Doctor",
          controller: txtSearch,
          onChange: (String value) {},
        ),
        Expanded(
            child: Column(
          children: [
            const TableHeader(),
            Expanded(
                child: SingleChildScrollView(
                    child: DoctorListTable(dList: dList))),
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
          1: FlexColumnWidth(100),
          2: FlexColumnWidth(80),
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
                  child: Text('Doc ID'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Doctor Name'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Unit'),
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

class DoctorListTable extends StatelessWidget {
  const DoctorListTable({
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
          1: FlexColumnWidth(100),
          2: FlexColumnWidth(80),
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
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.arrow_circle_right_sharp,
                        color: kGrayColor,
                        size: 24,
                      ),
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
