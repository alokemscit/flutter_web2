import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/custom_snakbar.dart';
import 'package:web_2/component/widget/custom_textbox.dart';

import '../../../component/settings/functions.dart';
import 'model/module_model.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgLightColor,
      body: BlocProvider(
        create: (context) => ModuleMenuBloc(),
        child: FutureBuilder(
          future: get_module_list(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ModelMenuList>> snapshot) {
            List<ModelMenuList> cdata = [];
            // List<ModelMenuList> mdata = [];
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              cdata = snapshot.data!;
              List<ModelMenuList> parent = snapshot.data!
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
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class TreeExpandeWidget extends StatelessWidget {
  const TreeExpandeWidget(
      {super.key, required this.parent, required this.cdata});
  final List<ModelMenuList> parent;
  final List<ModelMenuList> cdata;
  @override
  Widget build(BuildContext context) {
    //List<ModelMenuList> cdata = [];
    List<ModelMenuList> mdata = [];
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
                child: BlocListener<ModuleMenuBloc, ModuleMenuState>(
                  listener: (context, state) {
                     if (state is ModuleMenuSuccessState) {
                                      Navigator.of(context).pop();
                                    }
                  },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        CustomDialog(
                                            context,
                                            Container(
                                              decoration: const BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          topRight:
                                                              Radius.circular(
                                                                  8))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0,
                                                        vertical: 4),
                                                child: Text(
                                                  pItem.name!,
                                                  style: const TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                context: context,
                                                message: "Name Required",
                                                type: MsgType.error);
                                            return;
                                          } else {
                                            //var ids = pItem.id;
                                            context.read<ModuleMenuBloc>().add(
                                                ModuleMenuSavingEvent(
                                                    pid: pItem.id.toString(),
                                                    name:
                                                        pItem.name.toString()));
                                            // Navigator.of(context).pop();
                                          }
                                        });

                                        /// print(ids);
                                      },
                                      child: const Text("Add Sub Menu"))
                                ],
                              )),
                          children: _expandedMenu(cdata, mdata, false));
                    }).toList(),
                  ),
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

_expandedMenu(
    List<ModelMenuList> parent, List<ModelMenuList> mdata, bool isLast) {
  return mdata.map((dataItem) {
    List<ModelMenuList> kdata = parent
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
            // initiallyExpanded :true,
            trailing: const SizedBox(),
            // leading: Icon(Icons.arrow_circle_right),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !isLast
                    ? const Icon(Icons.arrow_right)
                    : const Icon(Icons.menu_open),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dataItem.name!.toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      !isLast
                          ? TextButton(
                              onPressed: () {}, child: const Text("Add Form"))
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
            tilePadding: EdgeInsets.zero,
            children: _expandedMenu(parent, kdata, true),
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
    on<ModuleMenuSavingEvent>((event, emit) {
      emit(ModuleMenuLoadingState());
      print(event.name);
      Future.delayed(const Duration(microseconds: 5000));
      emit(ModuleMenuSuccessState(msg: 'Success'));
    });
  }
}
