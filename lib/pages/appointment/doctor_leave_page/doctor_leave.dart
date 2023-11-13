import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/component/widget/custom_datepicker.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/pages/appointment/doctor_leave_page/model/doctor_leave_list.dart';
import 'package:web_2/pages/appointment/doctor_leave_page/model/doctor_list_model.dart';

import '../../../component/widget/custom_button.dart';

import '../../../component/widget/custom_search_box.dart';
import '../../../component/widget/custom_textbox.dart';
import '../../../data/data_api.dart';

// ignore: must_be_immutable
class DoctorLeave extends StatelessWidget {
  DoctorLeave({super.key});
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? did;
    String? docId = '', docName = '';
    bool isSected = true;
    List<DoctorList> dList = [];
    List<DoctorList> dlistMain = [];
    List<DoctorList> dlistCombo = [];
    bool isChecked = false;
    // double _width = 0;
    // print(size.width);

    var myBlocBuilder = BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
      builder: (context, state) {
        var searchDoctorPanel =
            searchBoxDoctor(size, _searchController, dlistMain, dList);

        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 4),
        //   child: CustomSearchBox(
        //     borderBolor: Colors.black,
        //     isFilled: true,
        //     caption: "Search Doctor",
        //     borderRadious: 8.0,
        //     width: size.width < 650 ? size.width : 340,
        //     controller: _searchController,
        //     onChange: (val) {
        //       dList = dlistMain
        //           .where((element) =>
        //               element.dOCTORNAME!.toLowerCase().contains(
        //                   _searchController.text.toString().toLowerCase()) ||
        //               element.uNIT!.toLowerCase().contains(
        //                   _searchController.text.toString().toLowerCase()) ||
        //               element.dOCID!.toLowerCase().contains(
        //                   _searchController.text.toString().toLowerCase()))
        //           .toList();
        //       //  print(dList.length);

        //       context.read<DoctorSearchBloc>().add(DoctorListSearchEvent());
        //     },
        //     onTap: () {
        //       //  _width = 0;
        //       context
        //           .read<DoctorSearchBloc>()
        //           .add(DoctorSearchIsSelectedEvent(isSelected: true));
        //     },
        //   ),
        // );

        var doctorSelectPanel = doctorSelectedPart(size, docId, docName!);

        // Padding(
        //   padding: const EdgeInsets.only(top: 45),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //         decoration: const BoxDecoration(color: kBgLightColor),
        //         padding: const EdgeInsets.only(left: 8),
        //         child: const Text(
        //           "Selected Doctor",
        //           style: TextStyle(
        //               fontSize: 12,
        //               fontStyle: FontStyle.italic,
        //               fontWeight: FontWeight.w500,
        //               color: Colors.blue),
        //         ),
        //       ),
        //       Container(
        //         padding: const EdgeInsets.all(8),
        //         width: size.width < 650 ? size.width : 350,
        //         margin: const EdgeInsets.only(top: 0),
        //         //color: Colors.amber,
        //         // margin:EdgeInsets.only(left: 0) ,
        //         decoration: BoxDecoration(
        //           color: kBgLightColor,
        //           borderRadius: BorderRadius.circular(4),
        //           border: Border.all(color: Colors.grey, width: 0.1),
        //         ),
        //         // alignment: Alignment.topCenter,
        //         child: docId != ''
        //             ? Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   const Text(
        //                     "ID: ",
        //                     style: TextStyle(fontWeight: FontWeight.w600),
        //                   ),
        //                   Text(docId!),
        //                   const SizedBox(
        //                     width: 6,
        //                   ),
        //                   const Text(
        //                     "NAME: ",
        //                     style: TextStyle(fontWeight: FontWeight.w600),
        //                   ),
        //                   ConstrainedBox(
        //                       constraints: const BoxConstraints(
        //                           maxWidth: 220, maxHeight: 15),
        //                       child: Text(
        //                         docName!,
        //                         style: const TextStyle(
        //                             color: Color.fromARGB(255, 0, 42, 77)),
        //                       )),
        //                 ],
        //               )
        //             : const Text(
        //                 "No Doctor Selected",
        //                 style: TextStyle(color: Colors.red),
        //                 textAlign: TextAlign.left,
        //               ),
        //       ),
        //     ],
        //   ),
        // );

        var infoEntryPanel = leaveInfoEntry(size, did, dlistCombo);
        // Padding(
        //   padding: const EdgeInsets.only(top: 100),
        //   child: Column(
        //     children: [
        //       Container(
        //         padding: const EdgeInsets.all(4),
        //         width: size.width < 650 ? size.width : 350,

        //         //color: Colors.amber,
        //         // margin:EdgeInsets.only(left: 0) ,
        //         decoration: BoxDecoration(
        //           color: kBgLightColor,
        //           borderRadius: BorderRadius.circular(4),
        //           border: Border.all(color: Colors.grey, width: 0.1),
        //         ),
        //         alignment: Alignment.topCenter,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             const Padding(
        //               padding: EdgeInsets.only(bottom: 6, left: 4),
        //               child: Text(
        //                 "Leave Info",
        //                 style: TextStyle(
        //                     fontSize: 12,
        //                     fontWeight: FontWeight.w500,
        //                     fontStyle: FontStyle.italic,
        //                     color: Colors.blue),
        //               ),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.symmetric(
        //                   vertical: 8, horizontal: 5),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   CustomDatePicker(
        //                     date_controller: TextEditingController(),
        //                     label: "From Date",
        //                     bgColor: Colors.white,
        //                     width: size.width < 650 ? size.width * 0.45 : 150,
        //                   ),
        //                   CustomDatePicker(
        //                     date_controller: TextEditingController(),
        //                     label: "To Date",
        //                     width: size.width < 650 ? size.width * 0.45 : 150,
        //                     bgColor: Colors.white,
        //                   )
        //                 ],
        //               ),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.only(left: 4, top: 8),
        //               child: CustomDropDown(
        //                 id: did,
        //                 list: dlistCombo.map((item) {
        //                   return DropdownMenuItem<String>(
        //                     value: item.dOCID, // Convert item.id to String.
        //                     child: Padding(
        //                       padding: const EdgeInsets.all(0),
        //                       child: Text(
        //                         item.dOCTORNAME!,
        //                         style: const TextStyle(
        //                           fontSize: 14,
        //                         ),
        //                       ),
        //                     ),
        //                   );
        //                 }).toList(),
        //                 onTap: (value) {
        //                   did = value.toString();
        //                 },
        //                 width: size.width < 650 ? size.width * 0.96 : 334,
        //                 labeltext: "Select Responsible Doctor",
        //               ),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.only(left: 1, right: 1, top: 8),
        //               child: CustomTextBox(
        //                 isFilled: true,
        //                 caption: 'Remarks',
        //                 controller: TextEditingController(),
        //                 onChange: (value) {},
        //                 width: size.width < 650 ? size.width : 336,
        //                 height: 80,
        //                 maxLine: 4,
        //                 maxlength: 150,
        //               ),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.only(
        //                   left: 4, right: 4, bottom: 8, top: 4),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.end,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Padding(
        //                     padding: const EdgeInsets.only(bottom: 4),
        //                     child:
        //                         CustomButton(text: "Submit", onPressed: () {}),
        //                   )
        //                 ],
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // );
        var listViewGenarator =
            // doctorListGenator(
            //     size, did, docId, docName, dList, dlistMain, dlistCombo);

            Padding(
          padding: const EdgeInsets.only(left: 8, top: 36),
          child: Stack(
            children: [
              Container(
                width: size.width < 650 ? size.width * 0.96 : 337,
                height: 310,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.5)),
                child: ListView.builder(
                  itemCount: dList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        docId = dList[index].dOCID;
                        docName = dList[index].dOCTORNAME;

                        dlistCombo = dlistMain
                            .where((element) =>
                                element.uNIT == dList[index].uNIT &&
                                element.dOCTORNAME != dList[index].dOCTORNAME)
                            .toList();
                        did = null;

                        context.read<DoctorSearchBloc>().add(
                            DoctorSearchIsSelectedEvent(isSelected: false));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        maxWidth: 30, minWidth: 30),
                                    child: Text(
                                      dList[index].dOCID!,
                                      style: const TextStyle(fontSize: 12),
                                    )),
                                const SizedBox(
                                  width: 2,
                                ),
                                ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        maxWidth: 190, minWidth: 190),
                                    child: Text(
                                      dList[index].dOCTORNAME!,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 100),
                                child: Text(
                                  dList[index].uNIT!,
                                  style: const TextStyle(fontSize: 12),
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          // ignore: dead_code
        );

        return Stack(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            searchDoctorPanel,
            doctorSelectPanel,
            infoEntryPanel,
            docId == '' ? const DisableCover() : const SizedBox(),
            // ignore: dead_code
            isSected ? listViewGenarator : const SizedBox(),
            isSected ? const CloseButton() : const SizedBox(),
          ],
        );
      },
    );

    var decktopTab = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        myBlocBuilder,
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              //border: Border.all(color: Colors.grey, width: 0.3)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
                  builder: (context, state) {
                    return Checkbox(
                      checkColor: Colors.white,
                      value: isChecked,
                      onChanged: (bool? value) {
                        isChecked = value!;
                        context
                            .read<DoctorSearchBloc>()
                            .add(DoctorSearchDoctorSelectEvent(docid: ''));
                      },
                    );
                    // checkColor: Colors.white,
                    //fillColor: ,

                    //  value: isChecked,
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    "Display the list of all doctors on leave",
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );

    var mobile = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        myBlocBuilder,
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey, width: 0.3)),
          ),
        )
      ],
    );

    return RepositoryProvider(
      create: (context) => data_api(),
      child: BlocProvider(
        create: (context) => DoctorSearchBloc(
          RepositoryProvider.of<data_api>(context),
        )..add(DoctorSearchInitEvent()),
        child: Scaffold(
          backgroundColor: Colors.white, //kDefaultIconLightColor,
          body: SizedBox(
            width: double.infinity,
            height: size.height - 28,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
                builder: (context, state) {
                  if (state is DoctorSearchIsSelectedState) {
                    // _width = 0;
                    isSected = state.isSelected;
                  }
                  if (state is DoctorSearchInitState) {
                    dList = state.list;
                    dlistMain = state.list;
                    isSected = state.isSelected;
                    // print(dList.length.toString());
                  }
                  if (state is DoctorListLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is DoctorSearchIsSelectedState) {
                    did = null;
                  }

                  return Responsive(
                      mobile: mobile, tablet: decktopTab, desktop: decktopTab);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget doctorListGenator(
    Size size,
    String? did,
    String? docId,
    String? docName,
    List<DoctorList> dList,
    List<DoctorList> dlistMain,
    List<DoctorList> dlistCombo) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, top: 36),
    child: Stack(
      children: [
        Container(
          width: size.width < 650 ? size.width * 0.96 : 337,
          height: 310,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 0.5)),
          child: ListView.builder(
            itemCount: dList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  docId = dList[index].dOCID;
                  docName = dList[index].dOCTORNAME!;

                  dlistCombo = dlistMain
                      .where((element) =>
                          element.uNIT == dList[index].uNIT &&
                          element.dOCTORNAME != dList[index].dOCTORNAME)
                      .toList();
                  did = null;

                  context
                      .read<DoctorSearchBloc>()
                      .add(DoctorSearchIsSelectedEvent(isSelected: false));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxWidth: 30, minWidth: 30),
                              child: Text(
                                dList[index].dOCID!,
                                style: const TextStyle(fontSize: 12),
                              )),
                          const SizedBox(
                            width: 2,
                          ),
                          ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxWidth: 190, minWidth: 190),
                              child: Text(
                                dList[index].dOCTORNAME!,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              )),
                        ],
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                      ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Text(
                            dList[index].uNIT!,
                            style: const TextStyle(fontSize: 12),
                          ))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
    // ignore: dead_code
  );
}

Widget doctorSelectedPart(Size size, String? docId, String docName) {
  return Padding(
    padding: const EdgeInsets.only(top: 45),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(color: kBgLightColor),
          padding: const EdgeInsets.only(left: 8),
          child: const Text(
            "Selected Doctor",
            style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: Colors.blue),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          width: size.width < 650 ? size.width : 350,
          margin: const EdgeInsets.only(top: 0),

          decoration: BoxDecoration(
            color: kBgLightColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey, width: 0.1),
          ),
          // alignment: Alignment.topCenter,
          child: docId != ''
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "ID: ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(docId!),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      "NAME: ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 220, maxHeight: 15),
                        child: Text(
                          docName,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 42, 77)),
                        )),
                  ],
                )
              : const Text(
                  "No Doctor Selected",
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.left,
                ),
        ),
      ],
    ),
  );
}

Widget leaveInfoEntry(Size size, String? did, List<DoctorList> dlistCombo) {
  return Padding(
    padding: const EdgeInsets.only(top: 100),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          width: size.width < 650 ? size.width : 350,
          decoration: BoxDecoration(
            color: kBgLightColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey, width: 0.1),
          ),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 6, left: 4),
                child: Text(
                  "Leave Info",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDatePicker(
                      date_controller: TextEditingController(),
                      label: "From Date",
                      bgColor: Colors.white,
                      width: size.width < 650 ? size.width * 0.45 : 150,
                    ),
                    CustomDatePicker(
                      date_controller: TextEditingController(),
                      label: "To Date",
                      width: size.width < 650 ? size.width * 0.45 : 150,
                      bgColor: Colors.white,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 8),
                child: CustomDropDown(
                  id: did,
                  list: dlistCombo.map((item) {
                    return DropdownMenuItem<String>(
                      value: item.dOCID, // Convert item.id to String.
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          item.dOCTORNAME!,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onTap: (value) {
                    did = value.toString();
                  },
                  width: size.width < 650 ? size.width * 0.96 : 334,
                  labeltext: "Select Responsible Doctor",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 1, right: 1, top: 8),
                child: CustomTextBox(
                  isFilled: true,
                  caption: 'Remarks',
                  controller: TextEditingController(),
                  onChange: (value) {},
                  width: size.width < 650 ? size.width : 336,
                  height: 80,
                  maxLine: 4,
                  maxlength: 150,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 4, right: 4, bottom: 8, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: CustomButton(text: "Submit", onPressed: () {}),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget searchBoxDoctor(Size size, TextEditingController searchController,
    List<DoctorList> dlistMain, List<DoctorList> dList) {
  return BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
    builder: (context, state) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: CustomSearchBox(
          borderBolor: Colors.black,
          isFilled: true,
          caption: "Search Doctor",
          borderRadious: 8.0,
          width: size.width < 650 ? size.width : 340,
          controller: searchController,
          onChange: (val) {
            dList = dlistMain
                .where((element) =>
                    element.dOCTORNAME!.toLowerCase().contains(
                        searchController.text.toString().toLowerCase()) ||
                    element.uNIT!.toLowerCase().contains(
                        searchController.text.toString().toLowerCase()) ||
                    element.dOCID!.toLowerCase().contains(
                        searchController.text.toString().toLowerCase()))
                .toList();
            //  print(dList.length);

            context.read<DoctorSearchBloc>().add(DoctorListSearchEvent());
          },
          onTap: () {
            //  _width = 0;
            context
                .read<DoctorSearchBloc>()
                .add(DoctorSearchIsSelectedEvent(isSelected: true));
          },
        ),
      );
    },
  );
}

class CloseButton extends StatelessWidget {
  const CloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 14,
        right: 4,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            onTap: () {
              context
                  .read<DoctorSearchBloc>()
                  .add(DoctorSearchIsSelectedEvent(isSelected: false));
            },
            child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black),
                child: const Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.white,
                )),
          ),
        ));
  }
}

class DisableCover extends StatelessWidget {
  const DisableCover({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Container(
        width: size.width < 650 ? size.width : 350,
        color: Colors.white.withOpacity(0.75),
        height: 260,
      ),
    );
  }
}

abstract class DoctorSearchState {}

class DoctorSearchInitState extends DoctorSearchState {
  final bool isSelected;
  final List<DoctorList> list;
  DoctorSearchInitState({required this.isSelected, required this.list});
}

class DoctorSearchIsSelectedState extends DoctorSearchState {
  final bool isSelected;
  DoctorSearchIsSelectedState({required this.isSelected});
}

class DoctorListLoadingState extends DoctorSearchState {}

class DoctorListSearchState extends DoctorSearchState {}

class DoctorListLeaviveDoadedState extends DoctorSearchState {
  final List<DoctorLeaveList> lList;
  DoctorListLeaviveDoadedState({required this.lList});
}

abstract class DoctorSearchEvent {}

class DoctorListSearchEvent extends DoctorSearchEvent {}

class DoctorSearchIsSelectedEvent extends DoctorSearchEvent {
  final bool isSelected;
  DoctorSearchIsSelectedEvent({required this.isSelected});
}

class DoctorSearchDoctorSelectEvent extends DoctorSearchEvent {
  final String docid;
  DoctorSearchDoctorSelectEvent({required this.docid});
}

class DoctorSearchInitEvent extends DoctorSearchEvent {}

class DoctorSearchBloc extends Bloc<DoctorSearchEvent, DoctorSearchState> {
  final data_api apiRepository;
  DoctorSearchBloc(this.apiRepository)
      : super(DoctorSearchIsSelectedState(isSelected: false)) {
    on<DoctorSearchInitEvent>(
      (event, emit) async {
        emit(DoctorListLoadingState());
        try {
          final mList = await apiRepository.createLead([
            {
              'tag': '63',
            }
          ]);
          List<DoctorList> lst =
              mList.map((e) => DoctorList.fromJson(e)).toList();
          emit(DoctorSearchInitState(isSelected: false, list: lst));
        } on Error {
          emit(DoctorSearchInitState(isSelected: false, list: []));
        }
        //emit(DoctorListLoadedState());
      },
    );
    on<DoctorSearchIsSelectedEvent>((event, emit) {
      emit(DoctorSearchIsSelectedState(isSelected: event.isSelected));
    });
    on<DoctorListSearchEvent>(
      (event, emit) {
        emit(DoctorListSearchState());
      },
    );

    on<DoctorSearchDoctorSelectEvent>(
      (event, emit) async {
        emit(DoctorListLoadingState());
        await Future.delayed(const Duration(milliseconds: 3000));
        try {
          final mList = await apiRepository.createLead([
            {
              'tag': '64',
            }
          ]);
          List<DoctorLeaveList> lst =
              mList.map((e) => DoctorLeaveList.fromJson(e)).toList();
          print(mList.length);
          emit(DoctorListLeaviveDoadedState(lList: lst));
        } on Error {
          print('Error');
          emit(DoctorSearchInitState(isSelected: false, list: []));
        }
      },
    );
  }
}
