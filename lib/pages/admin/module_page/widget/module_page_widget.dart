import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_2/component/widget/custom_snakbar.dart';
import 'package:web_2/data/data_api.dart';

import '../../../../component/settings/config.dart';
import '../../../../component/widget/custom_button.dart';
import '../../../../component/widget/custom_container.dart';
import '../../../../component/widget/custom_dropdown.dart';
import '../../../../component/widget/custom_search_box.dart';
import '../../../../component/widget/custom_textbox.dart';
import '../../../../data/module_image_data.dart';
import '../../../../model/model_status.dart';
import '../model/module_model.dart';

Widget rightPanel(TextEditingController txtSearch) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: CustomContainer(
      child: TablePart(txtSearch: txtSearch),
    ),
  );
}

Widget leftPanel(String? iid, TextEditingController txtModule,
    TextEditingController txtDesc, BuildContext context) {
  return BlocListener<ModuleBloc, ModuleState>(
    listener: (context, state) {
      // _showAlertDialog(context, state.message);
      if (state is ModuleSaveSuccessState) {
        CustomSnackbar(context: context, message: state.message);
      }
    },
    child: BlocBuilder<ModuleBloc, ModuleState>(
      builder: (context, state) {
        if (state is ModuleLodingState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is ModuleSaveSuccessState) {
          iid = null;
          txtModule.text = "";
          txtDesc.text = "";
        }
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
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
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
                        maxlength: 150,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: FutureBuilder(
                          future: moduleImageList(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!;
                                return CustomDropDown(
                                  id: iid,
                                  isFilled: true,
                                  labeltext: "Select Icon",
                                  list: data.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item
                                          .category, // Convert item.id to String.
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                              if (txtModule.text.isEmpty) {
                                return;
                              }
                              if (iid == null) {
                                return;
                              }
                              if (txtDesc.text.isEmpty) {
                                return;
                              }
                              List<String> vlist = [
                                txtModule.text,
                                txtDesc.text,
                                iid!
                              ];
                              context
                                  .read<ModuleBloc>()
                                  .add(ModuleSaveEvent(valueList: vlist));

                              //print(iid);
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
      },
    ),
  );
}

void _showAlertDialog(BuildContext context, String msg) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

abstract class ModuleState {}

class ModuleLodingState extends ModuleState {}

class ModuleLInitState extends ModuleState {}

class ModuleLodedState extends ModuleState {}

class ModuleSaveSuccessState extends ModuleState {
  final String message;
  ModuleSaveSuccessState({required this.message});
}

class ModuleleSaveErrorState extends ModuleState {
  final String error;
  ModuleleSaveErrorState({required this.error});
}

abstract class ModuleEvent {}

class ModuleSaveEvent extends ModuleEvent {
  final List<String> valueList;
  ModuleSaveEvent({required this.valueList});
}

class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  //final data_api2 repo;
  ModuleBloc() : super(ModuleLInitState()) {
    on<ModuleSaveEvent>((event, emit) async {
      data_api2 repo = data_api2();
      var img = event.valueList[2];
      var name = event.valueList[0];
      var desc = event.valueList[1];
      if (img.isEmpty || name.isEmpty || desc.isEmpty) {
        emit(ModuleleSaveErrorState(error: "All entry fields value required!"));
        return;
      }
      emit(ModuleLodingState());
      Future.delayed(const Duration(microseconds: 500));
      try {
        var x = await repo.createLead([
          //@name, @pid int,@img
          {"tag": "2", "name": name, "pid": 0, "img": img, "desc": desc}
        ]);
        List<ModelStatus> lst = x
            .map(
              (e) => ModelStatus.fromJson(e),
            )
            .toList();
        if (lst.isEmpty) {
          emit(ModuleleSaveErrorState(error: "No data Saved"));
        } else {
          var a = lst.first.status.toString();
          var m = lst.first.msg!;
          if (a != "1") {
            emit(ModuleleSaveErrorState(error: m));
          } else {
            emit(ModuleSaveSuccessState(message: m));
          }
        }
        // print(x.toString());
        //a = x.map((e) => ModelMenuList.fromJson(e)).toList();
      } on Exception catch (e) {
        print(e.toString());
      }
    });
  }
}

class TablePart extends StatelessWidget {
  const TablePart({
    super.key,
    required this.txtSearch,
    // required this.dList,
  });

  final TextEditingController txtSearch;
  //final List<ModelMenuList> dList;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: get_module_list(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.done) {
              print(snapshot.data!.length.toString());
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
                              child: ModuleListTable(dList: snapshot.data!))),
                    ],
                  ))
                ],
              );
            } else {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ));
            }
          } else {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ));
          }
        });
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
  final List<ModelMenuList> dList;

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
                  padding: const EdgeInsets.all(6.0),
                  child: Text(e.id.toString()),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      e.name!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(e.desc == null ? "" : e.desc!),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.black.withOpacity(0.4),
                      size: 20,
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
