import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/circular.dart';
import 'package:web_2/component/widget/custom_snakbar.dart';
import 'package:web_2/component/widget/custom_textbox.dart';

import '../../../component/settings/functions.dart';
import '../../../data/data_api.dart';
import '../../../model/model_status.dart';
import 'model/module_model.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgLightColor,
      body: BlocProvider(
        create: (context) => ModuleMenuBloc(),
        child: BlocListener<ModuleMenuBloc, ModuleMenuState>(
          listener: (context, state) {
            if (state is ModuleMenuSuccessState) {
              Navigator.of(context).pop();
              CustomSnackbar(context: context, message: state.msg);
              // b = true;
              // _futurebulder();
            }
            if (state is ModuleMenuErrorState) {
              //Navigator.of(context).pop();
              CustomSnackbar(
                  context: context, message: state.msg, type: MsgType.error);
              // b = false;
            }
          },
          child: BlocBuilder<ModuleMenuBloc, ModuleMenuState>(
            builder: (context, state) {
              return _futurebulder();
            },
          ),
        ),
      ),
    );
  }
}

Widget _futurebulder() {
  return FutureBuilder(
    future: get_module_list(),
    builder:
        (BuildContext context, AsyncSnapshot<List<ModuleMenuList>> snapshot) {
      List<ModuleMenuList> cdata = [];
      // List<ModuleMenuList> mdata = [];
      if (snapshot.hasData) {
        if (snapshot.connectionState == ConnectionState.done) {
          cdata = snapshot.data!;
          List<ModuleMenuList> parent = snapshot.data!
              .where(
                (e) => e.pid!.toString() == "0",
              )
              .toList();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TreeExpandeWidget(
              parent: parent,
              cdata: cdata,
            ),
          );
        } else {
          return  Center(
            child: Circular(),
          );
        }
      } else {
        return  Center(
          child: Circular(),
        );
      }
    },
  );
}

class TreeExpandeWidget extends StatelessWidget {
  const TreeExpandeWidget(
      {super.key, required this.parent, required this.cdata});
  final List<ModuleMenuList> parent;
  final List<ModuleMenuList> cdata;
  @override
  Widget build(BuildContext context) {
    //List<ModuleMenuList> cdata = [];
    List<ModuleMenuList> mdata = [];
    TextEditingController txtManuName = TextEditingController();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Container(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: //List.generate(parent.length, (index) {
                      parent.map((pItem) {
                    mdata = cdata
                        .where((element) =>
                            element.pid!.toString() == pItem.id!.toString())
                        .toList();

                    return ExpansionTile(
                        initiallyExpanded: true,
                        trailing: null, // const SizedBox(width: 0,),
                        tilePadding: EdgeInsets.zero,
                        leading: const Icon(Icons.menu),
                        title: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(255, 197, 197, 197)
                                  .withOpacity(0.09),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pItem.name!,
                                  style: GoogleFonts.titilliumWeb(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                    onPressed: () {
                                      // _showDialog(context);

                                      _dialog(context, pItem, txtManuName);

                                      // CustomDialog(
                                      //     context,
                                      //     Container(
                                      //       decoration: const BoxDecoration(
                                      //           color: Colors.amber,
                                      //           borderRadius: BorderRadius.only(
                                      //               topLeft: Radius.circular(8),
                                      //               topRight:
                                      //                   Radius.circular(8))),
                                      //       child: Padding(
                                      //         padding:
                                      //             const EdgeInsets.symmetric(
                                      //                 horizontal: 12.0,
                                      //                 vertical: 4),
                                      //         child: Text(
                                      //           pItem.name!,
                                      //           style: const TextStyle(
                                      //               fontStyle:
                                      //                   FontStyle.italic),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     Padding(
                                      //       padding: const EdgeInsets.all(8.0),
                                      //       child: Column(
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment.start,
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.start,
                                      //         mainAxisSize: MainAxisSize.min,
                                      //         children: [
                                      //           CustomTextBox(
                                      //               caption: "Sub Menu Name",
                                      //               maxLine: 1,
                                      //               maxlength: 100,
                                      //               width: double.infinity,
                                      //               controller: txtManuName,
                                      //               onChange: (onChange) {})
                                      //         ],
                                      //       ),
                                      //     ), () {
                                      //   if (txtManuName.text.isEmpty) {
                                      //     //print("object");
                                      //     CustomSnackbar(
                                      //         context: context,
                                      //         message: "Name Required",
                                      //         type: MsgType.error);
                                      //     return;
                                      //   } else {
                                      //     //var ids = pItem.id;
                                      //     context.read<ModuleMenuBloc>().add(
                                      //         ModuleMenuSavingEvent(
                                      //             pid: pItem.id.toString(),
                                      //             name: txtManuName.text
                                      //                 .toString()));
                                      //     // Navigator.of(context).pop();
                                      //   }
                                      // });

                                      /// print(ids);
                                    },
                                    child: const Text("Add Sub Menu"))
                              ],
                            )),
                        children: _expandedMenu(
                            cdata, mdata, false, context, txtManuName));
                  }).toList(),
                ),
              ),
            )),
        Expanded(
          flex: MediaQuery.of(context).size.width < 1200 ? 0 : 5,
          child: Container(),
        )
      ],
    );
  }
}

_dialog(BuildContext context, ModuleMenuList pItem,
    TextEditingController txtManuName) {
  CustomDialog(
      context,
      Container(
        decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
          child: Text(
            pItem.name!,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextBox(
                caption: "Sub Menu Name",
                maxLine: 1,
                maxlength: 100,
                width: double.infinity,
                controller: txtManuName,
                onChange: (onChange) {})
          ],
        ),
      ), () {
    if (txtManuName.text.isEmpty) {
      //print("object");
      CustomSnackbar(
          context: context, message: "Name Required", type: MsgType.error);
      return;
    } else {
      //var ids = pItem.id;
      context.read<ModuleMenuBloc>().add(ModuleMenuSavingEvent(
          pid: pItem.id.toString(), name: txtManuName.text.toString()));
      // Navigator.of(context).pop();
    }
  });
}

_expandedMenu(List<ModuleMenuList> parent, List<ModuleMenuList> mdata,
    bool isLast, BuildContext context, TextEditingController txtManuName) {
  return mdata.map((dataItem) {
    List<ModuleMenuList> kdata = parent
        .where((element) => element.pid!.toString() == dataItem.id!.toString())
        .toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: ExpansionTile(
            initiallyExpanded: true,
            trailing: const SizedBox(),
            // leading: Icon(Icons.arrow_circle_right),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                !isLast
                    ? const Icon(Icons.arrow_right)
                    : const Icon(
                        Icons.menu_open,
                        color: Colors.black,
                        size: 20,
                      ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        dataItem.name!.toString(),
                        style: !isLast
                            ? const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)
                            : const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                      ),
                      !isLast
                          ? TextButton(
                              onPressed: () {
                                _dialog(context, dataItem, txtManuName);
                              },
                              child: const Text(
                                "Add Form",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ))
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
            tilePadding: EdgeInsets.zero,
            children: _expandedMenu(parent, kdata, true, context, txtManuName),
            //Title: Text("data"),
          ),
        ),
      ],
    );
  }).toList();
}

abstract class ModuleMenuState {}

class ModuleMenuInitState extends ModuleMenuState {}

class ModuleMenuLoadingState extends ModuleMenuState {}

class ModuleMenuSavingState extends ModuleMenuState {
  final String pid;
  final String name;
  ModuleMenuSavingState({required this.pid, required this.name});
}

class ModuleMenuSuccessState extends ModuleMenuState {
  final String msg;
  ModuleMenuSuccessState({required this.msg});
}

class ModuleMenuErrorState extends ModuleMenuState {
  final String msg;

  ModuleMenuErrorState({required this.msg});
}

abstract class ModuleMenuEvent {}

class ModuleMenuSavingEvent extends ModuleMenuEvent {
  final String pid;
  final String name;
  ModuleMenuSavingEvent({required this.pid, required this.name});
}

class ModuleMenuBloc extends Bloc<ModuleMenuEvent, ModuleMenuState> {
  ModuleMenuBloc() : super(ModuleMenuInitState()) {
    on<ModuleMenuSavingEvent>((event, emit) async {
      data_api2 repo = data_api2();
      emit(ModuleMenuLoadingState());

      //print(event.name);
      Future.delayed(const Duration(microseconds: 5000));

      try {
        var x = await repo.createLead([
          //@name, @pid int,@img
          {
            "tag": "2",
            "name": event.name,
            "pid": event.pid,
            "img": '',
            "desc": ''
          }
        ]);

        getStatus(
            x,
            () => emit(ModuleMenuErrorState(msg: "No data Saved")),
            (v) => ModuleMenuErrorState(msg: v),
            (v) => emit(ModuleMenuSuccessState(msg: v)));
      } on Exception catch (e) {
        // print(e.toString());
        ModuleMenuErrorState(msg: e.toString());
      }

      //emit(ModuleMenuSuccessState(msg: 'Success'));
    });
  }
}

void getStatus(List<dynamic> x, Function() empty, Function(String msg) error,
    Function(String msg) success) {
  List<ModelStatus> lst = x
      .map(
        (e) => ModelStatus.fromJson(e),
      )
      .toList();
  if (lst.isEmpty) {
    empty();
    //emit(ModuleMenuErrorState(msg: "No data Saved"));
  } else {
    var a = lst.first.status.toString();
    if (a != "1") {
      error(lst.first.msg.toString());
      //emit(ModuleMenuErrorState(msg: m));
    } else {
      success(lst.first.msg.toString());
      //emit(ModuleMenuSuccessState(msg: m));
    }
  }
}
