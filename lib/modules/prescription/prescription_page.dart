import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../block/tab_block/tabblock_bloc.dart';
import '../../component/settings/config.dart';
//import '../../component/widget/appbar_with_button.dart';
import '../../component/widget/vitalsign.dart';

// ignore: camel_case_types, must_be_immutable
class prescription_page extends StatelessWidget {
  prescription_page({
    super.key,
  });
  TextEditingController conroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabblockBloc(),
      child: Scaffold(
        
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      // width: double.infinity,
                      //height: double.maxFinite,
                      //  height: 1500,
                      color: backgroundColor,
                      child: BlocBuilder<TabblockBloc, TabblockState>(
                        builder: (context, state) {
                          if (state.index == 0) {
                            return SizedBox(
                              //height: 50,
                              //width: 450,
                              child: CapWithTextFields(
                                caption: 'Heaght(CM)',
                                controller: conroller,
                                width: 250,
                                maxlength: 150,
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                         

                          // return   SizedBox(
                          //     width: 200,
                          //     height: 200,
                          //     child: state.index == 0
                          //         ?  SizedBox(
                          //             //color: Colors.amber,
                          //             height: 50,
                          //             width: 250,
                          //             child: CapWithTextFields(
                          //               caption: 'Heaght(CM)',
                          //               controller: conroller,
                          //             ),
                          //           )
                          //         : state.index == 1
                          //             ? const SizedBox(
                          //                 //color: Colors.red,
                          //                 height: 50,
                          //                 width: 250,
                          //                 child: Text("Aloke"),
                          //               )
                          //             : SizedBox(
                          //                 width: 0,
                          //               ),
                          //   );

                          // return Text(state.index.toString());
                          // return tabPage[state.index];
                        },
                      ),
                    ),
                  ),
                  //context.read<TabblockBloc>().add(addTabIndex(index: 0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
